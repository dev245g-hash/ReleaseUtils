<#
.SYNOPSIS
    프리웨어 툴 릴리즈를 dev245g-hash/dev245g-hash.github.io 에 올린다(기본은 draft). 툴 공통 스크립트.

.DESCRIPTION
    툴별 차이(소스 경로·csproj·exe·버전 문자열 위치)는 tools.json 에 둔다.
    릴리즈 본문은 만들지 않고, 소스 저장소의 promotion\releases\<Version>.md 를 그대로 올린다.

    Release 빌드 → <Tool>.zip(exe 1개) → draft 릴리즈 생성 → zip 업로드 → 편집 화면 열기.

.PARAMETER Tool
    tools.json 에 등록된 툴 이름 (MultiCapture / MultiView ...).

.PARAMETER Version
    릴리즈 날짜 YYYY.MM.DD. 태그 <Tool>/Ver.<Version> 이 된다.

.EXAMPLE
    tools\Publish-Release.ps1 -Tool MultiView -Version 2026.01.01
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string] $Tool,

    [Parameter(Mandatory = $true)]
    [ValidatePattern("^\d{4}\.\d{2}\.\d{2}$")]
    [string] $Version,

    # 기본값 <sourceRoot>\promotion\releases\<Version>.md
    [string] $NotesFile,

    # 이미 빌드해 둔 bin\Release 를 그대로 쓴다
    [switch] $SkipBuild,

    # 브라우저 자동 열기 끄기
    [switch] $NoOpen,

    # 빌드·압축·검증까지만 하고 API 호출은 건너뛴다
    [switch] $DryRun,

    # draft 가 아니라 바로 공개 발행(이미지 없이 낼 때만)
    [switch] $Publish
)

$ErrorActionPreference = "Stop"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function Step([string] $msg) { Write-Host "  $msg" -ForegroundColor Cyan }
function Fail([string] $msg) { Write-Host "[실패] $msg" -ForegroundColor Red; exit 1 }

# ── 0. 툴 설정 ─────────────────────────────────────────────────────────────
$configPath = Join-Path $PSScriptRoot "tools.json"
$all = [IO.File]::ReadAllText($configPath, [Text.Encoding]::UTF8) | ConvertFrom-Json
$cfg = $all.$Tool
if (-not $cfg) { Fail "tools.json 에 없는 툴이다: $Tool (등록된 툴: $(($all.PSObject.Properties.Name) -join ', '))" }

$Owner     = "dev245g-hash"
$Repo      = "dev245g-hash.github.io"
$Tag       = "$Tool/Ver.$Version"
$AssetName = "$Tool.zip"
$Api       = "https://api.github.com/repos/$Owner/$Repo"

$root = $cfg.sourceRoot
if (-not (Test-Path $root)) { Fail "소스 폴더가 없다: $root" }
$exe  = Join-Path $root "bin\Release\$($cfg.exe)"
$zip  = Join-Path $root "bin\Release\$AssetName"
if (-not $NotesFile) { $NotesFile = Join-Path $root "promotion\releases\$Version.md" }

# ── 1. 사전 검증 ───────────────────────────────────────────────────────────
if (-not (Test-Path $NotesFile)) { Fail "릴리즈 본문이 없다: $NotesFile" }
# Get-Content -Raw 은 PSPath 같은 ETS 속성이 붙은 문자열을 준다. 그대로 ConvertTo-Json 에
# 넘기면 본문 대신 그 속성 뭉치가 직렬화돼 GitHub 이 422 로 거부한다.
$notes = [IO.File]::ReadAllText($NotesFile, [Text.Encoding]::UTF8)
if ([string]::IsNullOrWhiteSpace($notes)) { Fail "릴리즈 본문이 비어 있다: $NotesFile" }

# 창 제목 버전과 태그가 어긋나면 잘못된 exe 를 올리는 것이므로 여기서 끊는다.
# (Designer.cs 는 디자이너 영역이라 이 스크립트가 고치지 않고 알리기만 한다)
$versionFile = Join-Path $root $cfg.versionFile
$hit = Select-String -Path $versionFile -Pattern $cfg.versionPattern | Select-Object -First 1
if (-not $hit) { Fail "창 제목 버전을 찾지 못했다: $versionFile" }
$titleVer = $hit.Matches[0].Groups[1].Value
if ($titleVer -ne $Version) {
    Fail "창 제목이 $titleVer 인데 -Version 은 $Version 이다. 디자이너에서 제목을 먼저 맞출 것."
}
Step "본문 $(Split-Path $NotesFile -Leaf) ($($notes.Length)자) · 창 제목 $titleVer"

# ── 2. Release 빌드 ────────────────────────────────────────────────────────
if (-not $SkipBuild) {
    # 실행 중이면 exe 가 잠겨 MSB3027 로 실패한다.
    Get-Process $cfg.process -ErrorAction SilentlyContinue | Stop-Process -Force
    # 에디션마다 설치 경로가 달라 하드코딩 대신 vswhere 로 찾는다.
    $vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
    if (-not (Test-Path $vswhere)) { Fail "vswhere.exe 를 찾지 못했다: $vswhere (Visual Studio 필요)" }
    $msbuild = & $vswhere -latest -products * -requires Microsoft.Component.MSBuild -find "MSBuild\**\Bin\MSBuild.exe" | Select-Object -First 1
    if (-not $msbuild -or -not (Test-Path $msbuild)) { Fail "MSBuild 를 찾지 못했다 (vswhere 결과 없음)" }
    Step "Release 빌드"
    & $msbuild (Join-Path $root $cfg.csproj) /t:Rebuild /p:Configuration=Release /v:minimal /nologo
    if ($LASTEXITCODE -ne 0) { Fail "빌드 실패 (exit $LASTEXITCODE)" }
}
if (-not (Test-Path $exe)) { Fail "빌드 산출물이 없다: $exe" }

# ── 3. 패키징 ──────────────────────────────────────────────────────────────
# exe 한 개만 담는다 — 같은 폴더의 설정·캡처 폴더·pdb 는 실행 흔적이다.
Step "패키징"
if (Test-Path $zip) { Remove-Item $zip -Force }
Compress-Archive -LiteralPath $exe -DestinationPath $zip -Force

Add-Type -AssemblyName System.IO.Compression.FileSystem
$archive = [IO.Compression.ZipFile]::OpenRead($zip)
$entries = @($archive.Entries | ForEach-Object { $_.FullName })
$archive.Dispose()
if ($entries.Count -ne 1 -or $entries[0] -ne $cfg.exe) {
    Fail "zip 내용이 예상과 다르다: $($entries -join ', ')"
}
$zipKB = [Math]::Round((Get-Item $zip).Length / 1KB)
Step "$AssetName ($zipKB KB · $($cfg.exe) 1개)"

if ($DryRun) {
    Write-Host "[DryRun] 여기까지. 릴리즈는 만들지 않았다." -ForegroundColor Yellow
    exit 0
}

# ── 4. 인증 (토큰 값은 절대 출력하지 않는다) ───────────────────────────────
$token = $env:GH_TOKEN
if (-not $token) {
    # stdin 을 파이프로 넘기면 git 이 "missing protocol field" 로 거부하므로
    # 요청/응답을 임시 파일로 주고받는다(토큰은 변수에만 담고 출력하지 않는다).
    $req = Join-Path $env:TEMP "ru-cred-req.txt"
    $res = Join-Path $env:TEMP "ru-cred-out.txt"
    try {
        [IO.File]::WriteAllText($req, "protocol=https`nhost=github.com`n`n")
        Start-Process -FilePath "git" -ArgumentList "credential","fill" `
            -RedirectStandardInput $req -RedirectStandardOutput $res -NoNewWindow -Wait
        $cred = [IO.File]::ReadAllText($res)
        $line = $cred -split "`r?`n" | Where-Object { $_ -like "password=*" } | Select-Object -First 1
        if ($line) { $token = $line.Trim().Substring(9) }
    }
    finally {
        # 응답 파일에 토큰이 들어 있으므로 반드시 지운다.
        [IO.File]::Delete($req)
        [IO.File]::Delete($res)
    }
}
if (-not $token) {
    Fail "github.com 토큰을 찾지 못했다. `$env:GH_TOKEN 에 PAT(contents:write)를 넣고 다시 실행할 것."
}

$headers = @{
    Authorization = "Bearer $token"
    Accept        = "application/vnd.github+json"
    "User-Agent"  = "ReleaseUtils-Publish"
}

try { $repoInfo = Invoke-RestMethod -Uri $Api -Headers $headers }
catch { Fail "저장소 조회 실패 — 토큰이 유효한지 확인할 것. ($($_.Exception.Message))" }
if (-not $repoInfo.permissions.push) { Fail "$Owner/$Repo 에 쓰기 권한이 없는 토큰이다." }

# ── 5. 중복 태그 확인 ──────────────────────────────────────────────────────
$tagUrl = "$Api/releases/tags/$([uri]::EscapeDataString($Tag))"
try {
    $dup = Invoke-RestMethod -Uri $tagUrl -Headers $headers
    Fail "이미 같은 태그의 릴리즈가 있다: $($dup.html_url)"
}
catch [System.Net.WebException] {
    $code = $_.Exception.Response.StatusCode
    if ($code -ne [System.Net.HttpStatusCode]::NotFound) { Fail "태그 확인 실패: $code" }
}

# ── 6. 릴리즈 생성 ─────────────────────────────────────────────────────────
$payload = @{
    tag_name         = $Tag
    target_commitish = "main"
    name             = "$Tool (Ver.$Version)"
    body             = $notes
    draft            = (-not $Publish)
    prerelease       = $false
} | ConvertTo-Json -Depth 3 -Compress

$kind = if ($Publish) { "공개" } else { "draft" }
Step "릴리즈 생성 ($Tag · $kind)"
$release = Invoke-RestMethod -Uri "$Api/releases" -Method Post -Headers $headers `
    -Body ([Text.Encoding]::UTF8.GetBytes($payload)) -ContentType "application/json; charset=utf-8"

# ── 7. zip 업로드 (실패 시 부분 자산 정리 후 1회 재시도) ───────────────────
$uploadUrl = ($release.upload_url -replace "\{\?name,label\}", "") + "?name=$AssetName"
function Upload-Asset {
    Invoke-RestMethod -Uri $uploadUrl -Method Post -Headers $headers -InFile $zip -ContentType "application/zip"
}
Step "$AssetName 업로드"
try { $asset = Upload-Asset }
catch {
    Write-Host "  업로드 실패 — 정리 후 한 번 더 시도한다." -ForegroundColor Yellow
    $current = Invoke-RestMethod -Uri "$Api/releases/$($release.id)" -Headers $headers
    foreach ($a in $current.assets) {
        if ($a.name -eq $AssetName) {
            Invoke-RestMethod -Uri "$Api/releases/assets/$($a.id)" -Method Delete -Headers $headers | Out-Null
        }
    }
    try { $asset = Upload-Asset }
    catch {
        Fail "업로드 재시도 실패: $($_.Exception.Message)`n초안은 남아 있다 — 지우려면 DELETE $Api/releases/$($release.id)"
    }
}

# ── 8. 브라우저로 열기 ─────────────────────────────────────────────────────
# draft 는 tag URL 대신 편집 화면으로 열어야 이미지를 바로 끌어다 놓을 수 있다.
$open = $release.html_url
if (-not $Publish) { $open = $open -replace "/releases/tag/", "/releases/edit/" }
if (-not $NoOpen) { Start-Process $open }

# ── 9. 요약 ────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "완료 — $Tag" -ForegroundColor Green
Write-Host "  자산 : $($asset.name) ($([Math]::Round($asset.size / 1KB)) KB)"
Write-Host "  주소 : $open"
if (-not $Publish) {
    Write-Host "  남은 일: 편집 화면에서 이미지를 드래그해 넣고 Publish 버튼을 누를 것." -ForegroundColor Yellow
}

# ReleaseUtils (프리웨어 배포 저장소 · 사이트)

## 프로젝트
`dev245g-hash/ReleaseUtils` — 개인 개발 유틸(MultiCapture, MultiView, 추후 ~5개)의 **릴리즈 + 소개 페이지** 저장소.
소스 코드는 각 툴 저장소에 있고, 여기에는 **배포물(Releases) · 소개 문서 · 이미지 · 공통 배포 스크립트**만 둔다.
로컬 위치: `D:\Claude\ReleaseUtils` (git clone). 편집은 로컬에서 하고 git으로 푸시한다.

## 구조

| 경로 | 역할 |
|------|------|
| `README.md` | 저장소 첫 화면. 툴 목록 표(설명 + 데모 이미지 + Download 링크) |
| `<Tool>.md` | 툴별 소개 + 기능 카드 + **Version List(문서 최하단)** |
| `images/<tool>/` | 문서에서 쓰는 이미지. **repo에 커밋하고 `raw.githubusercontent.com` 경로로 참조** |
| `tools/Publish-Release.ps1` | 공통 배포 스크립트 (`-Tool`, `-Version`) |
| `tools/tools.json` | 툴별 설정(소스 경로 · csproj · exe · 버전 문자열 위치) |

## 규칙
- 이미지는 repo에 커밋하고 raw 경로를 쓴다. `user-attachments`(웹 드래그 첨부)는 API로 만들 수 없고 repo 이력에 없어 신규 문서에는 쓰지 않는다. (기존 것은 유지)
- 기능 카드: 기능마다 `<table>` 1개, `<td width="480" align="left" valign="middle">`(제목 `<h3>` + 설명) + `<td width="400" align="center">`(이미지 `width="380" height="207"`). 표에 `width="100%"`/% 열 너비는 금지 — GitHub CSS가 무시해 카드마다 너비가 달라진다. 픽셀 고정만 쓴다.
- Version List는 문서 **최하단**. 새 행은 표 맨 위, `![Latest]` 배지는 새 버전으로 옮긴다.
- 릴리즈 본문은 영문 먼저, 한글 나중.
- 툴을 추가할 때: ①`tools/tools.json`에 항목 추가 ②`<Tool>.md` 생성 ③`README.md` 표에 행 추가 ④해당 툴 `CLAUDE.md`의 배포 Flow가 이 저장소의 공통 스크립트를 가리키게 한다.

## 배포 (공통 스크립트)
```powershell
tools\Publish-Release.ps1 -Tool MultiView -Version 2026.01.01
```
- 하는 일: 버전 문자열 검사 → Release 빌드 → exe 1개만 zip → draft 릴리즈(태그 `<Tool>/Ver.<날짜>`) 생성 → zip 업로드 → 편집 화면 열기.
- 옵션: `-SkipBuild` `-DryRun`(API 호출 없이 검증까지만) `-NoOpen` `-Publish`(바로 공개).
- 본문은 **소스 저장소**의 `promotion\releases\<날짜>.md` (툴별 CLAUDE.md의 배포 Flow 1단계가 작성·검토).
- 토큰: `$env:GH_TOKEN` 우선, 없으면 `git credential fill`. **값 출력·저장 금지.**
- 창 제목 버전(`*.Designer.cs`)이 `-Version`과 다르면 중단한다. 디자이너 영역이라 Claude가 고치지 않고 사용자에게 요청한다.

## 설계 메모 / 미결
- 현재 공통 스크립트는 만들어졌으나 **각 툴 저장소의 기존 `tools\Publish-Release.ps1`은 아직 그대로** 있다. 새 스크립트 실사용 검증 후 툴 쪽 CLAUDE.md의 배포 Flow를 이 경로로 교체하고 기존 스크립트를 제거한다.
- 이미지 자동화: 이미지를 `images/<tool>/<날짜>/`에 커밋하고 raw URL을 본문에 넣으면 draft 단계에서 이미지까지 자동화 가능 → 사람은 Publish만 누르면 된다. 미구현.
- 버전 리스트 갱신 대상: 지금은 `<Tool>.md`. GitHub Pages 전환 시 Pages 쪽으로 이동.
- GitHub Pages 전환 / 저장소 이름 `dev245g-hash.github.io` 변경은 **미결정**. 변경하면 하드코딩 링크(각 `<Tool>.md`의 Download·이미지 주소, 스크립트의 `$Repo`, 툴별 CLAUDE.md)를 직접 갱신하고 릴리즈·raw 리다이렉트를 열어 확인해야 한다. 사용자 승인 전에는 실행하지 않는다.

## 버전 관리
- "깃" 지시가 있을 때만 commit/push (전역 규칙). 브랜치 `main`.

## 주요 사이트
- 후원: https://ko-fi.com/dev245

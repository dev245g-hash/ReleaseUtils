(function () {
  var REPO = 'dev245g-hash/dev245g-hash.github.io';
  var root = document.documentElement;

  // theme toggle: dark by default, follows OS light unless the visitor chose
  try { var saved = localStorage.getItem('theme'); if (saved) root.setAttribute('data-theme', saved); } catch (e) {}
  var btn = document.querySelector('.theme-btn');
  function isLight() {
    var t = root.getAttribute('data-theme');
    return t ? t === 'light' : matchMedia('(prefers-color-scheme: light)').matches;
  }
  function paint() { if (btn) btn.textContent = isLight() ? '☾' : '☀'; }
  if (btn) btn.addEventListener('click', function () {
    var next = isLight() ? 'dark' : 'light';
    root.setAttribute('data-theme', next);
    try { localStorage.setItem('theme', next); } catch (e) {}
    paint();
  });
  paint();

  // download buttons: newest published zip per tool; static href stays as fallback
  var links = document.querySelectorAll('[data-download]');
  if (!links.length) return;
  function apply(releases) {
    links.forEach(function (a) {
      var tool = a.getAttribute('data-download');
      var rel = releases.filter(function (r) {
        return !r.draft && !r.prerelease && r.tag_name.indexOf(tool + '/') === 0;
      })[0];
      if (!rel) return;
      var zip = (rel.assets || []).filter(function (x) { return /\.zip$/i.test(x.name); })[0];
      if (zip) a.href = zip.browser_download_url;
      var v = a.querySelector('small');
      if (v) v.textContent = rel.tag_name.split('/')[1] || '';
    });
  }
  var KEY = 'releases-cache', cached = null;
  try { cached = JSON.parse(sessionStorage.getItem(KEY)); } catch (e) {}
  if (cached && Date.now() - cached.t < 600000) { apply(cached.d); return; }
  fetch('https://api.github.com/repos/' + REPO + '/releases?per_page=50')
    .then(function (r) { if (!r.ok) throw 0; return r.json(); })
    .then(function (d) {
      var slim = d.map(function (r) {
        return { draft: r.draft, prerelease: r.prerelease, tag_name: r.tag_name,
          assets: (r.assets || []).map(function (x) { return { name: x.name, browser_download_url: x.browser_download_url }; }) };
      });
      try { sessionStorage.setItem(KEY, JSON.stringify({ t: Date.now(), d: slim })); } catch (e) {}
      apply(slim);
    })
    .catch(function () { /* keep fallback href */ });
})();

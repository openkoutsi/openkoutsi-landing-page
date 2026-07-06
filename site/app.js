// Copy-to-clipboard for the self-host snippet. Replaces the React CopyButton
// that used to live in the web app; behaviour is identical.
document.addEventListener('click', function (e) {
  var btn = e.target.closest('.copy-btn')
  if (!btn) return
  var copy = btn.getAttribute('data-copy') || 'COPY'
  var copied = btn.getAttribute('data-copied') || 'COPIED'
  navigator.clipboard
    .writeText('git clone https://github.com/openkoutsi/openkoutsi\ndocker compose up -d')
    .catch(function () {})
  btn.textContent = copied
  setTimeout(function () {
    btn.textContent = copy
  }, 1500)
})

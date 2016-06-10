window.clearForm = (e) =>
  e.preventDefault()

  [].map.call document.querySelectorAll("input[type='checkbox']"), (checkbox) ->
    checkbox.checked = false

window.toggleBoxes = (parent) =>
  [].map.call document.querySelectorAll("input[id^='" + parent.id + "']"), (checkbox) ->
    checkbox.checked = parent.checked

window.toggleInnerCheckbox = (e) =>
  checkbox = e.currentTarget.querySelector("input[type='checkbox']")
  return if checkbox == e.target
  checkbox.checked = !!!checkbox.checked
  toggleBoxes(checkbox)
 
`window.toggleFullScreen = function() {
  var doc = window.document;
  var docEl = doc.documentElement;

  var requestFullScreen = docEl.requestFullscreen || docEl.mozRequestFullScreen || docEl.webkitRequestFullScreen || docEl.msRequestFullscreen;
  var cancelFullScreen = doc.exitFullscreen || doc.mozCancelFullScreen || doc.webkitExitFullscreen || doc.msExitFullscreen;

  if(!doc.fullscreenElement && !doc.mozFullScreenElement && !doc.webkitFullscreenElement && !doc.msFullscreenElement) {
    requestFullScreen.call(docEl);
  }
  else {
    cancelFullScreen.call(doc);
  }
}
`

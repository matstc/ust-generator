window.clearForm = (e) =>
  e.preventDefault()

  [].map.call document.querySelectorAll("input[type='checkbox']"), (checkbox) ->
    checkbox.checked = false

window.toggleBoxes = (parent) =>
  [].map.call document.querySelectorAll("input[id^='" + parent.id + "']"), (checkbox) ->
    checkbox.checked = parent.checked

window.toggleInnerCheckbox = (e) =>
  e.preventDefault()
  checkbox = e.currentTarget.querySelector("input[type='checkbox']")
  checkbox.checked = !!!checkbox.checked
  toggleBoxes(checkbox)

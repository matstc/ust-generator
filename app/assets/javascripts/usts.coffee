window.clearForm = (e) =>
  e.preventDefault()
  $("input[type='checkbox']").each(_, checkbox) -> checkbox.checked = false

window.generate = -> $('form').submit()

$(window).scroll ->
  if $(window).scrollTop() > 0
    $('.action-bar').css('opacity', '0.8')
  else
    $('.action-bar').css('opacity', '1')

window.toggleBoxes = (parent) =>
  $("input[id^='" + parent.id + "']").each (_, checkbox) ->
    checkbox.checked = parent.checked
    true

window.toggleInnerCheckbox = (e) =>
  checkbox = e.currentTarget.querySelector("input[type='checkbox']")
  return if checkbox == e.target
  checkbox.checked = !!!checkbox.checked
  toggleBoxes(checkbox)
 
window.toggleFullScreen = ->
  doc = window.document
  docEl = doc.documentElement

  requestFullScreen = docEl.requestFullscreen || docEl.mozRequestFullScreen || docEl.webkitRequestFullScreen || docEl.msRequestFullscreen
  cancelFullScreen = doc.exitFullscreen || doc.mozCancelFullScreen || doc.webkitExitFullscreen || doc.msExitFullscreen

  if !doc.fullscreenElement && !doc.mozFullScreenElement && !doc.webkitFullscreenElement && !doc.msFullscreenElement
    requestFullScreen.call(docEl)
  else
    cancelFullScreen.call(doc)

class Player
  constructor: ->
    @progression = []
    @index = 0
    @intervalId = null
    @bpm = 80

  calculateDelay: ->
    60/(@bpm/4)*1000

  use: (progression) ->
    @progression = progression
    $('.glyphicon.glyphicon-play').parents("button").show()

  loop: =>
    return @stop() if (@index >= @progression.length)

    @highlight(@index)
    @scrollTo(@index)
    MIDI.noteOn(0, MIDI.keyToNote[@progression[@index]], 120, 0)
    MIDI.noteOff(0, MIDI.keyToNote[@progression[@index]], 0.70)
    @index += 1

  play: ->
    @index = 0 if @index >= @progression.length
    $('.glyphicon.glyphicon-play').parents("button").hide()
    $('.glyphicon.glyphicon-pause').parents("button").show()
    @intervalId = setInterval(@loop, @calculateDelay())

  stop: ->
    e.preventDefault() if e?
    $('.glyphicon.glyphicon-pause').parents("button").hide()
    $('.glyphicon.glyphicon-play').parents("button").show() if @progression.length > 0
    clearInterval(@intervalId) if @intervalId?
    @intervalId = null
    MIDI.stopAllNotes() if MIDI.stopAllNotes?

  reset: ->
    @stop()
    @index = 0
    $('.bpm').text(@bpm)

  highlight: (index) ->
    tds = $("table.progression td").removeClass('current')
    td = $(tds[index]).addClass('current')

  scrollTo: (index) ->
    td = $($("table.progression td")[index])
    height = $(window).height()
    offset = td.offset().top
    if offset + 150 > height + $(window).scrollTop()
      destination = offset - 100
      $('html, body').animate({ scrollTop: destination}, 2000)

  goTo: (index) ->
    @stop()
    @highlight(index)
    @scrollTo(index)
    @index = index

  toggleAudio:  (e) ->
    if @intervalId?
      @stop(e)
    else
      @play()

  speedUp: (e) ->
    @bpm += 5
    $('.bpm').text(@bpm)
    @stop()

  speedDown: (e) ->
    @bpm -= 5
    $('.bpm').text(@bpm)
    @stop()
 
window.PLAYER = new Player

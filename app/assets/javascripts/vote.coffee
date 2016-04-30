# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(window).load ->
  for counter_name in ["#red-counter","#white-counter"]
    $(counter_name).addClass('counter-analog2').counter({
      initial: '000',
      direction: 'up',
      interval: '500',
      format: '999',
      stop: '999'
    })
    $(counter_name).counter("stop")
  window.last_red = 0
  window.last_white = 0
  window.counter_ready = true
  if window.hang_data
    console.log ("flushing data")
    App.vote_result.received(window.hang_data)
  # for select team
  $(".team-field").click ->
    $(".team-field").removeClass("highlight")
    $(".team-select").val($(this).data("team"))
    $(this).addClass("highlight")
  $(".team-field-link").click (event) ->
    event.preventDefault()
  


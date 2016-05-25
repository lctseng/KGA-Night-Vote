# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(window).load ->
  # for select team
  $(".team-field").click ->
    $(".team-field").removeClass("highlight")
    $(".team-select").val($(this).data("team"))
    $(this).addClass("highlight")
  $(".team-field-link").click (event) ->
    event.preventDefault()
  


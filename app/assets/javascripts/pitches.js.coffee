# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ -> 
  $('.pitches').imagesLoaded ->
    $('.pitches').masonry
      itemSelector: '.box'
      columnWidth: 30
      isFitWidth: true
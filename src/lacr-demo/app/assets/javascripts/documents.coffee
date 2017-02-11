# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

//= require prettify.js
//= require xml2html.js
//= require jquery.zoom.min.js

$(document).ready ->
  $('#doc-image').zoom url: $('#doc-image img').data('largeImage') # Javascript for image zoom on hover
  return

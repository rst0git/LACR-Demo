//= require prettify.js
//= require xml2html.js
//= require jquery.zoom.min.js
//= require ISO_639_2.min.js

$(document).ready(function() {
  // Image zoom on hover
  $('#doc-image').zoom({
    url: $('#doc-image img').data('largeImage')
  });

  // Transform language codes
  $(".language").each(function() {
    $(this).html(ISO_639_2[$(this).html()]['native'][0]);
  });
});

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

  //Load the list of volumes and pages using ajax
  var jqxhr = $.getJSON( "/ajax/doc/list", function() {
      console.log( "success" );
    })
      .done(function(data) {
        $.each( data, function( i, e ) {
          // volume = $('<div>').class("nav-header").html();
          console.log( i, e );
        });
      })
      .fail(function() {
        console.log( "error" );
      })
      .always(function() {
        console.log( "complete" );
      });

    // Perform other work here ...

    // Set another completion function for the request above
    jqxhr.complete(function() {
      console.log( "second complete" );
    });
});

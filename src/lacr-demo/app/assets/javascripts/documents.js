//= require jquery.zoom.min.js
//= require prettify.js
//= require xml2html.js
//= require ISO_639_2.min.js

var jqxhr;

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
  jqxhr = $.getJSON( "/ajax/doc/list")
      .done(function(data) {
        $.each( data, function( i, e ) {
            if($('#vol-'+e.volume).length == 0){
              $('<button id="vol-'+e.volume+'" class="btn btn-primary btn-block" data-toggle="collapse" data-target=".vol-'+e.volume+'">Volume '+e.volume+'</li>').appendTo('#doc_nav');
            }
            $('<div id="vol-'+e.volume+'-page-'+e.page+'" class="vol-'+e.volume+' collapse"><a href="/doc/show?p='+e.page+'&v='+e.volume+'">Page '+e.page+'</a></div>').appendTo('#doc_nav');//.appendTo('#vol-'+e.volume);
        });
      })

    // Set another completion function for the request above
});

//= require jquery.zoom.min.js
//= require prettify.js
//= require xml2html.js
//= require ISO_639_2.min.js

var jqxhr;

// Load partial content
var load_document = function (p, v){
  $('#doc-title').html("Volume: "+v+" Page: "+p);
  $("#transcription-image").load("/doc/page?p="+p+"&v="+v);
  $('div.active').removeClass("active");
  $('#vol-'+v+'-page-'+p).addClass("active");

  // Image zoom on hover
  $('#doc-image').zoom({
    url: $('#doc-image img').data('largeImage')
  });
}

$(document).ready(function() {

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
            $('<div id="vol-'+e.volume+'-page-'+e.page+'" class="vol-'+e.volume+' collapse"><a onclick="load_document(p='+e.page+', v='+e.volume+');">Page '+e.page+'</a></div>').appendTo('#doc_nav');//.appendTo('#vol-'+e.volume);
        });
      })

    // Set another completion function for the request above
});

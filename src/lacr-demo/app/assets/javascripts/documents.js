//= require jquery.zoom.min.js
//= require prettify.js
//= require xml2html.js
//= require ISO_639_2.min.js

var jqxhr;

// Load partial content
var load_document = function (p, v){
  $('#doc-title').html("Volume: "+v+" Page: "+p);
  $("#transcription-image").load("/doc/page?p="+p+"&v="+v, function(responseTxt, statusTxt, xhr){
        if(statusTxt == "success"){
          // Transform language codes
          $(".pr-language").each(function() {
            $(this).html(ISO_639_2[$(this).html()]['native'][0]);
          });

          // Image zoom on hover
          $('#doc-image').zoom({
            url: $('#doc-image img').data('largeImage')
          });

          // Initialise prettyPrint
          PR.prettyPrint();

          // Event listener for add-to-list of selected entries
          $('.add-to-list').click(function(){
            if($(this).is(":checked")) ){
              if($(this).is(":checked")) {
                selected_list.push($(this).attr('data-entry'));
                Cookies.set('selected_entries', selected_list.toString());
              } else {
                selected_list.pop($(this).attr('data-entry'));
                if (selected_list.length == 0) Cookies.remove('selected_entries');
              }
          });
          // Set to checked add-to-list if it is already in the list
          $('.add-to-list').each(function () {$(this).prop('checked', selected_list.indexOf($(this).attr("data-entry")) >= 0)});
        }
        if(statusTxt == "error")
            console.log("Error: " + xhr.status + ": " + xhr.statusText);
    });
  $('div.active').removeClass("active");
  $('#vol-'+v+'-page-'+p).addClass("active");

}

$(document).ready(function() {

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
});

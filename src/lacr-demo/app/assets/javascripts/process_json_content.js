// Execute this script after the content of the page has loaded
$(document).on('turbolinks:load', function() {

  // Create object from the JSON
  var obj = $.parseJSON( $('#json_content').html() );

  // Prevent appending the text twice
  if (!$( "#processed_transcription" ).html()) {

    // Append the content
    $ ('<div/>').html(JSON.stringify(obj.div.p).replace(/\\n/g, "<br />")).appendTo( "#processed_transcription" );
  }
});

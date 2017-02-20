//var entryElements = $( "trnascription" )

function createInput(){
    var $input = $('<input type="button" value="" class"transcription_btn"/>');
    $input.appendTo($(".transcription"));
}

$( document ).ready(function() {
   $(".transcription").children().css({"color": "red"});

});

var xml = $('#xml').html();
var xmlDoc = $.parseXML( $("<div/>").html(xml).text());
var $xml = $( xmlDoc );
$( "#display_xml" ).append($xml.text());

var xml = $('#xml').html();
// var xmlDoc = $.parseXML( $("<div/>").html(xml).text());
var xmlDoc = $.parseXML( $("<div/>").html(xml).text());
console.log(xmlDoc);
var $xml = $( xmlDoc );
//$( "#display_xml" ).append($xml.text());
$( "#display_xml" ).append($xml.text());

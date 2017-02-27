//= require prettify.js
//= require xml2html.js
//= require ISO_639_2.min.js

// Transform language codes
$(".pr-language").each(function() {
  $(this).html(ISO_639_2[$(this).html()]['native'][0]);
});

// Initialise prettyPrint
PR.prettyPrint();

/// Event listener for add-to-list of selected entries
init_selected_checkboxes();

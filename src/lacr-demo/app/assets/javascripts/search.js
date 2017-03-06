//= require jquery.zoom.min.js
//= require prettify.js
//= require xml2html.js
//= require ISO_639_2.min.js

$(document).ready(function() {
    $('a.result-link').click(function(e) {
      e.preventDefault();
      var $this = $(this);
      url = $this.attr('data-url');
      page = $this.attr('data-page');
      vol = $this.attr('data-vol');
      load_page(url, page, vol);
     });
});

function load_page(url, page, vol){
  if ($.isFunction($.fn.fullpage.destroy)) {
    // Disable the fullpage plugin
    $.fn.fullpage.destroy('all');
  }
  // Load the page with Ajax
  $('#result-container').load(url, function () {
    // Load Fullpage.js
    $('#fullpage').fullpage({
      anchors:['results'],
      scrollOverflow: true, // Enable scroll on pages
      fitToSectionDelay: 0, // Load imidiately
      paddingTop: "70px", // Padding for the header
      paddingBottom: "50px", // Padding for the footer
      controlArrows: false, // Disable navigation arrows
      verticalCentered: false, // Do not center pages
      loopHorizontal: false // To prevent unwanted actions
    });

    // Transform language codes
    $(".pr-language").each(function() {
      $(this).html(ISO_639_2[$(this).html()]['native'][0]);
    });

    // Image zoom on hover
    $('#doc-image').zoom({
      url: $('#doc-image img').data('largeImage')
    });

    // Initialise prettify
    PR.prettyPrint();

    // Event listener for add-to-list of selected entries
    init_selected_checkboxes();

    // Update title
    $('#doc-title').html("Volume: "+vol+" Page: "+page);

    // Hide search tools
    $('#search_tools').hide();
    
    // Slide to the loaded transcription
    $.fn.fullpage.moveTo('results', 1);

  });
}

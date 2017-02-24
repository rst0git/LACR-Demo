$(document).ready(function() {
    $('a.result-link').click(function(e) {
      e.preventDefault();
      load_page($(this).attr('data-page'));
     });
});

function load_page(url){
  if ($.isFunction($.fn.fullpage.destroy)) {
    // Disable the fullpage plugin
    $.fn.fullpage.destroy('all');
  }
  // Load the page with Ajax
  $('#result-container').load(url, function () {
    // Load Fullpage.js
    $('#fullpage').fullpage({
      anchors:['results'],
      scrollOverflow: true,
      scrollOverflowReset: true,
      fitToSectionDelay: 0,
      paddingTop: "70px",
      paddingBottom: "20px",
      verticalCentered: false,
      loopHorizontal: false,
    });
    document.location.href = "#results/1";
  });
}

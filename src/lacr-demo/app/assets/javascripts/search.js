$(document).ready(function() {
    $('a').click(function(e) {e.preventDefault();
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
    $('#fullpage').fullpage();
  });
}

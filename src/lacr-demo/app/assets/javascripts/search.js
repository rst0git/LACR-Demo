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
      scrollOverflow: true,
      fitToSectionDelay: 0,
      paddingTop: "70px",
      paddingBottom: "50px",
      verticalCentered: false,
      loopHorizontal: false,
    });

    // Transform language codes
    $(".pr-language").each(function() {
      $(this).html(ISO_639_2[$(this).html()]['native'][0]);
    });

    // Event listener for add-to-list of selected entries
    $('.add-to-list').click(function()){
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

    // Update title
    $('#doc-title').html("Volume: "+vol+" Page: "+page+" \
      <sup><a class=\"btn btn-primary btn-xs\" href=\"/doc/show?p="+page+"&v="+vol+"\"> \
        View Page \
      </a></sup>");

    // Slide to the loaded transcription
    document.location.href = "#results/1";

  });
}

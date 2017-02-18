//= require ISO_639_2.min.js
var selected = {};

function load_document (p, v){
  $('#doc-title').html("Volume: "+v+" Page: "+p);
  $("#transcriptions").load("/doc/page-s?p="+p+"&v="+v, function(responseTxt, statusTxt, xhr){
        if(statusTxt == "success"){
          // Transform language codes
          $(".language").each(function() {
            $(this).html(ISO_639_2[$(this).html()]['native'][0]);
          });
        }
    });
  $("#doc_view").attr('href', "/doc/show?p="+p+"&v="+v);
  $('div.active').removeClass("active");
  $('#vol-'+v+'-page-'+p).addClass("active");
}

$(document).ready(function() {

  //Load the list of volumes and pages using ajax
  jqxhr = $.getJSON( "/ajax/doc/list")
      .done(function(data) {
        $.each( data, function( i, e ) {
            if($('#vol-'+e.volume).length == 0){
              $('\
                  <button id="vol-'+e.volume+'" \
                          data-vol="'+e.volume+'" \
                          data-collapse-group="volume" \
                          class="btn btn-primary btn-block" \
                          data-toggle="collapse" \
                          data-target=".vol-'+e.volume+'">\
                    Volume '+e.volume+' <span id="badge-'+e.volume+'" class="badge"></span>\
                  </button>').appendTo('#volume');
              $('\
                <div data-vol="'+e.volume+'" data-page="'+e.page+'" class="vol-'+e.volume+' collapse">\
                  <input type="checkbox" data-vol="'+e.volume+'" data-page="all">\
                </div>').appendTo('#page');
            }
            $('\
                <div data-vol="'+e.volume+'" data-page="'+e.page+'" class="vol-'+e.volume+' collapse">\
                  <input type="checkbox" data-vol="'+e.volume+'" data-page="'+e.page+'" name="vol-'+e.volume+'-page-'+e.page+'">\
                  <button class="btn btn-link" onclick="load_document(p='+e.page+', v='+e.volume+');">Page '+e.page+'</button>\
                </div>').appendTo('#page');
        });

        // Collpse other volumes on open
        $("[data-collapse-group='volume']").click(function () {
            var $this = $(this);
            $("[data-collapse-group='volume']").removeClass('active');
            $(this).addClass('active')
            $("[data-collapse-group='volume']:not([data-target='" + $this.data("target") + "'])").each(function () {
                $($(this).data("target")).removeClass("in").addClass('collapse');
            });
        });

        // Show pages of the first Volume in the list
          var first_volume_pages = $($("[data-collapse-group='volume']")[0]).addClass('active').attr('data-target');
          var first_volume_no = $($("[data-collapse-group='volume']")[0]).addClass('active').attr('data-vol');
          $(first_volume_pages).collapse('show');

        // Load the first page of the first volume
          var first_page_no = $($(first_volume_pages)[0]).attr('data-page');
          load_document(p=first_page_no, v=first_volume_no);

        // Update badge value when checkbox has been changed
        $(":checkbox").change(function(){
          var $chkbox_vol = $(this).attr('data-vol');
          var $chkbox_page = $(this).attr('data-page');
          var $vol_badge = $('#badge-'+$chkbox_vol);

          // If select all
          if ($chkbox_page == 'all') {
            var $chk_boxes = $('input[data-page!="all"][data-vol="'+$chkbox_vol+'"]');
            $chk_boxes.prop('checked', $(this).is(":checked"));
            if ($(this).is(":checked")) {
              // Indicate with badge on the volume
              $vol_badge.html($chk_boxes.length);
              // Add checked page to list
              $chk_boxes.each(function(c){
                selected[$(c).attr('name')] = {'volume':$(c).attr('page-vol'), 'page':$(c).attr('page-page')};
              });
            } else {
              // Remove chacked page from list
              $chk_boxes.each(function(c){
                delete selected[$(c).attr('name')];
              });
              // Do not show 0 badge
              $vol_badge.html('');
            }
          }
          else {

            var $chkbox_name = $(this).attr('name');
            var badge_value = $vol_badge.html();

            // Convert "badge_value" from str to int
            if (badge_value) total_chked = parseInt(badge_value); else total_chked = 0;

            // If Checked
            if ($(this).is(":checked")) {
              // Indicate with badge on the volume
              $vol_badge.html(total_chked+1);
              // Add checked page to list
              selected[$chkbox_name] = {'volume': $chkbox_vol, 'page':$chkbox_page};
            } else {
              // Remove chacked page from list
              delete selected[$chkbox_name];
              // Do not show 0 badge
              if (total_chked <= 1) $vol_badge.html(''); else $vol_badge.html(total_chked-1);
            }
          }

          // Disable buttons when nothing has been selected
          $('.doc-tools').attr("disabled", Object.keys(selected).length == 0);
        });
      })
});

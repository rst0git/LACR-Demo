$(document).ready(function() {
    $('#fullpage').fullpage({
        anchors:['homepage', 'advsearch', 'about']
    });
});

$('#adv-search-nav').click(function(){
    $.fn.fullpage.moveTo('advsearch');
});

$('#about-nav').click(function(){
    $.fn.fullpage.moveTo('about');
});

$('#home-nav').click(function(){
    $.fn.fullpage.moveTo('homepages');
});

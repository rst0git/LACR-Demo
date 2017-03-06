$(document).ready(function() {
    $('#fullpage').fullpage({
        anchors:['homepage', 'advsearch', 'about'],
        navigation: true,
        menu: '#myMenu'

    });
    $('#mOutputId').html($('#mInputId').attr('value'));
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

$('.fp-controlArrow-down').click(function(){
    $.fn.fullpage.moveSectionDown();
});

$('.fp-controlArrow-up').click(function(){
    $.fn.fullpage.moveSectionUp();
});

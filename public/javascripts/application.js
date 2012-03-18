// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {

    // If on announcement index page.
    if($('.announcements').length > 0) {
    
        $('.announcement-details-item').addClass('hidden');
    
        $('.announcement-list-item').click(function() {

            $('.announcement-list-item').removeClass('selected');
            $(this).addClass('selected')

            $('.announcement-details-item').addClass('hidden');
            $($(this).attr('href')).removeClass('hidden');
        });



    }


});


function inPlaceFocus() {

}


function inPlaceBlur() {


}




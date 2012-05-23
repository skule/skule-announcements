// Skule Announcements

$(document).ready(function() {

    // If on announcement index page.
    if($('.announcements').length > 0) {
    
        $('.announcement-details-item').addClass('hidden');
    
        $('.announcement-list-item').click(function() {

            $('.announcement-list-item').removeClass('selected');
            $(this).addClass('selected')

            $('.announcement-details-item').addClass('hidden');
            $($(this).attr('href')).removeClass('hidden');

            return false;
        });
    }

    if($('.announcement-form').length > 0) {

        if($('.has_datetime_check_box').attr('checked') == 'checked') {
            $('.datetime_field select').removeAttr('disabled');
        } else {
            $('.datetime_field select').attr('disabled', 'disabled');
        }

        $('.has_datetime_check_box').click(function() {
            if($('.datetime_field select').attr('disabled') == 'disabled') {
                $('.datetime_field select').removeAttr('disabled');
            } else {
                $('.datetime_field select').attr('disabled', 'disabled');
            }
        });
    }

});





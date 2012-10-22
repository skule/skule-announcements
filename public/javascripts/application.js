// Skule Announcements

$(document).ready(function() {

    // If on announcement index page.
    if($('.announcements').length > 0) {
    
        var selected = -1;
        var numAnnouncements =  $('.announcement-list-item').length;
        var prevYOffset = 0;

        $('.announcement-details-item').addClass('hidden');
        $('.announcement-list-item').click(function() {
            selected = $('.announcement-list-item').index(this);
            selectAnnouncement(selected);
            return false;
        });

        $(document).keydown(function(event) {
            if(event.keyCode == 38 || event.keyCode == 40) {

                if(event.keyCode == 38) {
                    if(selected > 0) {
                        selected--;
                    }
                } else {
                    if(selected < numAnnouncements - 1) {
                        selected ++;
                    }
                }

                selectAnnouncement(selected);

                event.preventDefault();
            }
        });

        $(document).scroll(function(event) {
            // Allow the details panel to travel back up to the top of the page
            // when the user scrolls up
            if(window.pageYOffset < $('.announcement-details').offset().top) {
                positionDetailsTop();
            }
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

    function selectAnnouncement(a) {
        $('.announcement-list-item').removeClass('selected');
        $('.announcement-list-item:eq(' + a + ')').addClass('selected')

        $('.announcement-details-item').addClass('hidden');
        $($('.announcement-list-item:eq(' + a + ')').attr('href')).removeClass('hidden');

        positionDetailsTop();
    }

    function positionDetailsTop() {
        // The current top offset of the announcemnt-details ul element
        // Can be retrieved with $('.announcement-details').offset().top
        detailsOffsetTop = 106; 

        if(window.pageYOffset > detailsOffsetTop) {
            $('.announcement-details').css('margin-top', window.pageYOffset - detailsOffsetTop);
        } else {
            $('.announcement-details').css('margin-top', 0);
        }
    }

});





$(document).ready(function() {
    $('.imageA').click(function() {
        let index = parseInt($(this).attr('data-index'));

        $('#popUpCarouselDialog').modal('show');
        if (!isNaN(index)) {
            $('#popUpCarousel').carousel(index);
        }
    });
});
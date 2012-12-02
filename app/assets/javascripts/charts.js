
jQuery(function($) {
    // Callback for edit link on section within chart
    $('.chart-section-links a[data-type=html]').on('ajax:success', function(event, data, status, xhr) {
        $('#section-builder').html(data);
    });
});

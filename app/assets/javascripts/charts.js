
jQuery(function($) {

    // Callback for edit link on section within chart
    $('.chart-section-links a[data-type=html]').live('ajax:success', function(event, data, status, xhr) {
        $('#section-builder').html(data);
    });

    // Callback for delete link on section line within section editor
    $('#section-builder-lines a[data-method="delete"]').live('ajax:success', function(event, data, status, xhr) {
        // remove the section line elemente
        var section_line_id = $(event.target).attr('data-section-line-id');
        $('#section-line-' + section_line_id).remove();
    });


    // Callback from clicking a tool link
    $('#tools a[data-remote=true]').live('click', function(event){
        // set tool id and submit new section line form..
        var tool_id = $(event.target).attr('data-tool-id');
        var form = $('form#new-section-line-tool-form');
        form.find('input[name=tool_id]').val(tool_id);
        form.trigger("submit");
    });

    // Callback from submission for new section_line via tool 
    $('form#new-section-line-tool-form').live('ajax:success', function(event, data, status, xhr) {
        $('#section-builder-lines').append(data);
    });

    // Callback from submission for section edit
    $('form#section-form').live('ajax:success', function(event, data, status, xhr) {
        alert('Saved Section:');
    });

});

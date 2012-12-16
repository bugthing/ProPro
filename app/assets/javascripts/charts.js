
jQuery(function($) {

    // Callback for edit link on section within chart
    $(".chart-section-links a:contains('edit')").live('ajax:success', function(event, data, status, xhr) {
        $('#section-builder').html(data);
    });
    // Callback from click on onward link 
    $(".chart-section-links a:contains('onward')").live('click', function(event, data, status, xhr) {
      var onward_section_id = $(event.target).attr('data-section-id');
      // set the id of the section to link to
      $('#from_section_id').val(onward_section_id);
      $('#newsectionModal').modal('show');
      $('#newsectionModal .btn-primary').click(function(){
        $('#newsectionModal form').submit();
      })
    });

    // Callback for delete link on section line within section editor
    $('#section-builder-lines a[data-method=delete]').live('ajax:success', function(event, data, status, xhr) {
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
    $('form#section-form input[type=submit]').live('ajax:success', function(event, data, status, xhr) {
        alert('Saved Section:');
    });

});

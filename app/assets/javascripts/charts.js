
jQuery(function($) {

    // Callback for edit link on section (within chart)
    $(".chart-section-links a:contains('edit')").live('ajax:success', function(event, data, status, xhr) {
      $('#section-builder').html(data);
      // make the section-line edit area sortable (and hook that up to an ajax call)
      $('#section-builder-lines').sortable();
    });
    // Callback from click on onward link for section (within chart)
    $(".chart-section-links a:contains('onward')").live('click', function(event, data, status, xhr) {
      // set the id of the section to be linked from
      var onward_section_id = $(event.target).attr('data-section-id');
      $('#newsectionModal #from_section_id').val(onward_section_id);
      $('#newsectionModal').modal('show'); // show form
    });
    // Callback for delete request resulting from link on section (within chart)
    $(".chart-section-links a:contains('del')").live('ajax:success', function(event, data, status, xhr) {
      var section_id = $(event.target).attr('data-section-id');
      $("#section-" + section_id).remove();
      $("a#chart-connect").trigger('click'); // refresh chart
    });

    // callback from new-section modal-form
    $('#newsectionModal form').live('ajax:success', function(event, data, status, xhr) {
      $('#newsectionModal').modal('hide');
      $('#chart-sections').append(data);
      $("a#chart-connect").trigger('click'); // refresh chart
    });
    // .. hook up the new section modal-form submit button..
    $('#newsectionModal .btn-primary').click(function(){
      $('#newsectionModal form').submit();
    })

    // callback for link to draw chart connections (refresh chart)
    $("a#chart-connect").live('ajax:success', function(event, data, status, xhr) {
        buildFlowChart( data.connections );
    });

    $("a[data-chart-id]").live('ajax:success', function(event, data, status, xhr) {
    });

    // Callback for section name edit form 
    $('form#edit-section-name').live('ajax:success', function(event, data, status, xhr) {

      // reload section within chart
      var sectionId = $(event.target).attr('data-section-id');
      $.get('/builder/chartsection/' + sectionId, function(data) {
        $("#section-" + sectionId).replaceWith(data)
      }); 

      $("a#chart-connect").trigger('click'); // refresh chart
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

    // hook up the user click 'Save' for section-line editting forms
    // ..this sets the weight(order) within each form and submits..
    $('a#section-line-edit-forms-save').live('click', function(event) {
      sortedIds = $('#section-builder-lines').sortable('toArray')
      for (var i=0;i<sortedIds.length;i++) {
        form = $('#' + sortedIds[i]).find('form');
        form.find('#section_line_weight').val( i ); // set weight in the form
        form.submit();
      }
      // finally submit the section name edit form 
      $('form#edit-section-name').submit();
    });

    // Callback from section-line-edit form submission
    $('form.section-line-edit').live('ajax:success', function(event, data, status, xhr) {
      // nothing required (charted is refreshed after edit-section-name form)
    });

});

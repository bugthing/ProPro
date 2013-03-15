
//MedPro = {
//  createReading : function( chartId ) {
//    jQuery.ajax({
//      type: "POST",
//      url: '/reading',
//      data: { 'chart_id': chartId },
//      dataType: 'json',
//      success: function(data){ 
//        jQuery('#middle-content').html(data);
//      }
//    });
//  },
//
//  showReading: function(readingId) {
//    jQuery.ajax({
//      type: "GET",
//      url: '/reading/' + readingId,
//      success: function(data){ 
//        alert( data );
//        //jQuery('#middle-content').html(data);
//      }
//    });
//  }
//};
//
//jQuery(document).ready( function() {
//  jQuery("a.show_reading").click( function(e){
//    var readingId = $(e.target).attr('data-reading');
//    MedPro.showReading( readingId );
//  });
//});

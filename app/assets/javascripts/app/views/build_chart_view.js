App.BuildChartView = Ember.View.extend({
  templateName: 'app/templates/build_chart',

  didInsertElement: function() {
    this._super();

    // maybe init the flowchart graphic..
  },

  submit: function(event) {
    event.preventDefault();
    //this.get('controller').updateRecord();
  }
});

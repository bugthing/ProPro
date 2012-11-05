App.BuildChartController = Em.Controller.extend({
  content: null,

  enterBuilding: function() {
  },

  exitBuilding: function() {
  },

  updateRecord: function() {
  },

  showRecord: function() {
    App.router.transitionTo('charts.chart.index', this.get('content'));
  }
});

App.ChartController = Em.Controller.extend({
  destroyRecord: function() {
    this.get('content').deleteRecord();
    this.get('store').commit();
    App.router.transitionTo('charts.index');
  }
});

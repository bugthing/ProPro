App.ShowChartInListView = Em.View.extend({
  templateName: 'app/templates/show_chart_in_list',
  tagName: 'li',
  classNameBindings: 'isActive:active',

  isActive: function() {
    var id = this.get('content.id'),
        currentPath = App.router.get('currentState.path');

    if (id) {
      return App.get('router.chartController.content.id') === id &&
             currentPath.indexOf('charts.chart') > -1;
    } else {
      return currentPath.indexOf('charts.newChart') > -1;
    }
  }.property('App.router.currentState', 'App.router.chartController.content')
});

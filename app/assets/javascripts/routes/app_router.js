
// see: http://emberjs.com/guides/outlets/

App.Router = Ember.Router.extend({

  root: Ember.Route.extend({

    index: Ember.Route.extend({
      route: '/',
      redirectsTo: 'charts'
    }),

    charts: Ember.Route.extend({
        route: '/charts',
        showChart: Ember.Route.transitionTo('chart'),
        connectOutlets: function(router) {
            router.get('applicationController').connectOutlet('charts', App.Chart.find());
        }
    }),

    chart: Ember.Route.extend({
        route: '/charts/:chart_id',
        connectOutlets: function(router, chart) {
            router.get('applicationController').connectOutlet('chart', chart);
        }
    })

  })
});

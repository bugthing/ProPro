App.Router = Ember.Router.extend({
  enableLogging: true,
  location: 'hash',
  root: Em.Route.extend({
    charts: Em.Route.extend({
      route: '/',
      connectOutlets: function(router) {
        router.get('applicationController').connectOutlet('charts', router.get('store').findAll(App.Chart));
      },
      index: Em.Route.extend({
        route: '/'
      }),
      
      showChart: function(router, event) {
        router.transitionTo('charts.chart.index', event.context);
      },
      showNewChart: function(router) {
        router.transitionTo('charts.newChart', {});
      },

      newChart: Em.Route.extend({
        route: 'charts/new',
        connectOutlets: function(router) {
          router.get('chartsController').connectOutlet('editChart', {});
          router.get('editChartController').enterEditing();
        },

        cancelEdit: function(router) {
          router.transitionTo('charts.index');
        },
        exit: function(router) {
          router.get('editChartController').exitEditing();
        }
      }),
      chart: Em.Route.extend({
        route: 'charts/:chart_id',
        connectOutlets: function(router, context) {
          router.get('chartsController').connectOutlet('chart', context);
        },

        index: Em.Route.extend({
          route: '/',
          connectOutlets: function(router, context) {
            router.get('chartController').connectOutlet('showChart');
          },

          showEdit: function(router) {
            router.transitionTo('charts.chart.edit');
          },
          showBuild: function(router) {
            router.transitionTo('charts.chart.build');
          },
        }),
        edit: Em.Route.extend({
          route: 'edit',
          connectOutlets: function(router) {
            var chartController = router.get('chartController');
            chartController.connectOutlet('editChart', chartController.get('content'));
            router.get('editChartController').enterEditing();
          },

          cancelEdit: function(router) {
            router.transitionTo('charts.chart.index');
          },
          exit: function(router) {
            router.get('editChartController').exitEditing();
          }
        }),
        build: Em.Route.extend({
          route: 'build',
          connectOutlets: function(router) {
            var chartController = router.get('chartController');
            var chart = chartController.get('content');
            //router.get('applicationController').connectOutlet('buildChart', chart);
            chartController.connectOutlet('buildChart', chart);
            router.get('buildChartController').enterBuilding();

          },
          index: Ember.Route.extend({
            route: '/'
          }),

          exit: function(router) {
            router.get('buildChartController').exitBuilding();
          },
          cancelBuild: function(router) {
            router.transitionTo('charts.chart.index');
          },
          showSections: function(router, event) {
            router.transitionTo('charts.chart.build.sections', event.context);
          },
          sections: Ember.Route.extend({
            route: 'sections',
            connectOutlets: function(router) {
              //router.get('applicationController').connectOutlet('charts', router.get('store').findAll(App.Chart));
            },
            index: Em.Route.extend({
              route: '/'
            })
          })
        })
      })
    })
  })
});

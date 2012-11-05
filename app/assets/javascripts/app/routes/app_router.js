App.Router = Ember.Router.extend({
  location: 'hash',
  
  root: Em.Route.extend({
    charts: Em.Route.extend({
      route: '/',
      
      showChart: function(router, event) {
        router.transitionTo('charts.chart.index', event.context);
      },

      showNewChart: function(router) {
        router.transitionTo('charts.newChart', {});
      },

      connectOutlets: function(router) {
        router.get('applicationController').connectOutlet('charts', router.get('store').findAll(App.Chart));
      },

      index: Em.Route.extend({
        route: '/',

        connectOutlets: function(router) {
          router.get('applicationController').connectOutlet('charts');
        }
      }),

      newChart: Em.Route.extend({
        route: '/charts/new',

        cancelEdit: function(router) {
          router.transitionTo('charts.index');
        },

        connectOutlets: function(router) {
          router.get('chartsController').connectOutlet('editChart', {});
          router.get('editChartController').enterEditing();
        },

        exit: function(router) {
          router.get('editChartController').exitEditing();
        }
      }),

      chart: Em.Route.extend({
        route: '/charts/:chart_id',

        connectOutlets: function(router, context) {
          router.get('chartsController').connectOutlet('chart', context);
        },

        index: Em.Route.extend({
          route: '/',

          showEdit: function(router) {
            router.transitionTo('charts.chart.edit');
          },

          showBuild: function(router) {
            router.transitionTo('charts.chart.build');
          },

          connectOutlets: function(router, context) {
            router.get('chartController').connectOutlet('showChart');
          }
        }),

        build: Em.Route.extend({
          route: 'build',

          cancelBuild: function(router) {
            router.transitionTo('charts.chart.index');
          },

          connectOutlets: function(router) {
            var chartController = router.get('chartController');
            chartController.connectOutlet('buildChart', chartController.get('content'));
            router.get('buildChartController').enterBuilding();
          },

          exit: function(router) {
            router.get('buildChartController').exitBuilding();
          }
        }),

        edit: Em.Route.extend({
          route: 'edit',

          cancelEdit: function(router) {
            router.transitionTo('charts.chart.index');
          },

          connectOutlets: function(router) {
            var chartController = router.get('chartController');
            chartController.connectOutlet('editChart', chartController.get('content'));
            router.get('editChartController').enterEditing();
          },

          exit: function(router) {
            router.get('editChartController').exitEditing();
          }
        })
      })
    })
  })
});

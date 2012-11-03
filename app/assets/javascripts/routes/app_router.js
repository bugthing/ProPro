
// see: http://emberjs.com/guides/outlets/

App.Router = Ember.Router.extend({
    enableLogging: true,

    root: Ember.Route.extend({
        index: Ember.Route.extend({
            route: '/',
            connectOutlets: function(router, charts) {
                router.get('chartsController').set('content', App.Chart.find());
                router.get("applicationController").connectOutlet("charts");
            },
            index: Ember.Route.extend({
                route: '/'
            }),
            create: Ember.Route.extend({
                route: '/create',
                connectOutlets: function(router, chart) {
                    router.get('chartCreateController').set('content', {});
                    router.get("chartsController").connectOutlet("chartCreate");
                },
                exit: function(router) { router.get('chartsController').set('view', null); },
                cancel: Ember.Route.transitionTo('index'),
                    submitForm: function(router, event) {
                    var hash = router.getPath('chartCreateController.content');
                    App.Chart.createRecord(hash);
                    router.transitionTo('index');
                }
            }),
            update: Ember.Route.extend({
                route: '/update/:chart_id',
                connectOutlets: function(router, chart) {
                    router.get('chartUpdateController').set('content', chart );
                    router.get("chartsController").connectOutlet("chartUpdate");
                },
                exit: function(router) { router.get('chartsController').set('view', null); },
                cancel: Ember.Route.transitionTo('index'),
                submitForm: function(router, event) {
                    var chart = router.getPath('chartUpdateController.content');
                    chart.updateRecord();
                    router.transitionTo('index');
                }
            }),
            delete: Ember.Route.extend({
                route: '/delete/:chart_id',
                connectOutlets: function(router, chart) {
                    chart.deleteRecord();
                    router.get("applicationController").connectOutlet("charts");
                }
            }),
            view: Ember.Route.extend({
                route: '/view/:chart_id',
                connectOutlets: function(router, chart) {
                    router.get('applicationController').connectOutlet('chart', chart);
                },
                cancel: function(router, event) {
                    router.get('applicationController').connectOutlet('charts', App.Chart.find());
                    router.transitionTo('index');
                }
            }),
            showChart: Ember.Route.transitionTo('view'),
            delChart: Ember.Route.transitionTo('delete'),
            newChart: Ember.Route.transitionTo('create'),
            editChart: Ember.Route.transitionTo('update')
        })
    })

});

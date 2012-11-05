App = Em.Application.create({
    rootElement: '#builder'
});

App.Store = DS.Store.extend({
  adapter:  DS.RESTAdapter.create(),
  revision: 7
});

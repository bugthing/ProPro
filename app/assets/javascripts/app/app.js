App = Em.Application.create({
    rootElement: '#builder'
});

App.Store = DS.Store.extend({
  adapter:  DS.RESTAdapter.create(),
  //adapter:  DS.FixtureAdapter.create(),
  revision: 7
});

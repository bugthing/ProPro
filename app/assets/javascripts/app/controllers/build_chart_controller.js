App.BuildChartController = Em.Controller.extend({
  content: null,

  enterBuilding: function() {
    var store = this.get('store');
    var id = this.get('content.id');   
    var apt = store.adapter;
    var root = apt.rootForType(App.Chart);
    apt.ajax(apt.buildURL(root, id), "GET", {
      success: function(json) {
        apt.didFindRecord(store, App.Chart, json, id);
      }
    });
  },

  exitBuilding: function() {
  }

});

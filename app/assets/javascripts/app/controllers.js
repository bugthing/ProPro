App.ApplicationController = Em.Controller.extend({
});
App.ChartController = Em.Controller.extend({
  destroyRecord: function() {
    this.get('content').deleteRecord();
    this.get('store').commit();
    App.router.transitionTo('charts.index');
  }
});
App.ChartsController = Em.ArrayController.extend({
  sortProperties: ['name']
});
App.EditChartController = Em.Controller.extend({
  content: null,

  enterEditing: function() {
    this.transaction = this.get('store').transaction();
    if (this.get('content.id')) {
      this.transaction.add(this.get('content'));
    } else {
      this.set('content', this.transaction.createRecord(App.Chart, {}));
    }
  },

  exitEditing: function() {
    if (this.transaction) {
      this.transaction.rollback();
      this.transaction = null;
    }
  },

  updateRecord: function() {
    // TODO - validations

    // commit and then clear the transaction (so exitEditing doesn't attempt a rollback)
    this.transaction.commit();
    this.transaction = null;

    if (this.get('content.isNew')) {
      // when creating new records, it's necessary to wait for the record to be assigned
      // an id before we can transition to its route (which depends on its id)
      this.get('content').addObserver('id', this, 'showRecord');
    } else {
      // when updating records, the id is already known, so we can transition immediately
      this.showRecord();
    }
  },

  showRecord: function() {
    App.router.transitionTo('charts.chart.index', this.get('content'));
  }
});
App.ReadChartController = Em.Controller.extend({
  content: null,
  enterReading: function() {
  }
});
App.BuildChartController = Em.Controller.extend({
  content: null,
});

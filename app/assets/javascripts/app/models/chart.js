App.Chart = DS.Model.extend({
  "name": DS.attr('string'),
})
App.Section = DS.Model.extend({
  name: DS.attr('string'),
});
App.SectionLine = DS.Model.extend({
  toolId: DS.attr('string'),
});
App.Tool = DS.Model.extend({
  name: DS.attr('string'),
});

App.Chart.FIXTURES = [
    { "id": 1, "name": "Chart Fix One"   },
    { "id": 2, "name": "Chart Fix Two"   },
    { "id": 3, "name": "Chart Fix Three" }
];
App.Section.FIXTURES = [
    { "id": 1, "name": "Chart Fix One"   },
    { "id": 2, "name": "Chart Fix Two"   },
    { "id": 3, "name": "Chart Fix Three" }
];
App.SectionLine.FIXTURES = [
    { "id": 1, "tool_id": 1 },
    { "id": 2, "tool_id": 2 },
    { "id": 3, "tool_id": 3 }
];
App.Tool.FIXTURES = [
    { "id": 1, "name": "Text" },
    { "id": 2, "name": "Text Input" },
    { "id": 3, "name": "Button Input" }
];



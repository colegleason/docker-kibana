define(['settings'],
       function (Settings) {
           "use strict";
           return new Settings({
               elasticsearch:    "http://localhost:8081",
               default_route     : '/dashboard/file/default.json',
               kibana_index: "kibana-int",
               panel_names: [
                   'histogram',
                   'map',
                   'goal',
                   'table',
                   'filtering',
                   'timepicker',
                   'text',
                   'hits',
                   'column',
                   'trends',
                   'bettermap',
                   'query',
                   'terms',
                   'stats',
                   'sparklines'
               ]
           });
       });

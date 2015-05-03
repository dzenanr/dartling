part of default_project;

// http://www.json.org/
// http://jsonformatter.curiousconcept.com/

// lib/default/project/json/model.dart

var defaultProjectModelJson = r'''
{
   "width":990,
   "height":580,
   "lines":[

   ],
   "boxes":[
      {
         "entry":true,
         "name":"Project",
         "x":179,
         "y":226,
         "width":120,
         "height":120,
         "items":[
            {
               "sequence":10,
               "category":"identifier",
               "name":"name",
               "type":"String",
               "essential":true,
               "sensitive":false,
               "init":""
            },
            {
               "sequence":20,
               "category":"attribute",
               "name":"description",
               "type":"String",
               "essential":false,
               "sensitive":false,
               "init":""
            }
         ]
      }
   ]
}
''';
  
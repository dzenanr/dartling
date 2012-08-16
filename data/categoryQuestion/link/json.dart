

var categoryQuestionLinkDataInJson =
'{"domain":"CategoryQuestion","entries":[{"concept":"Member","entities":[{"oid":"1345062993781","lastName":"Ridjanovic","password":"drifting09","email":"dzenanr@gmail.com","interests":[{"category":"1345062993772","member":"1345062993781","oid":"1345062993784","description":"I am interested in web software developed in Dart.","code":null}],"about":"I like to walk, hike and stop to have a good bite and drink.","karma":"17.9","code":"dzenanr","receiveEmail":"true","firstName":"Dzenan","startedOn":"2012-08-15 16:36:33.454","role":"admin"},{"oid":"1345062993783","lastName":"Begin","password":"claudeb8527","email":"claude.begin@hotmail.com","interests":[],"about":"null","karma":"1","code":"claudeb","receiveEmail":"false","firstName":"Claude","startedOn":"2012-08-15 16:36:33.455","role":"regular"}]},{"concept":"Category","entities":[{"questions":[],"description":"Dart Web language.","oid":"1345062993772","name":"Dart","approved":"false","webLinks":[{"updatedOn":"null","oid":"1345062993776","description":"Dart is a new web language with libraries and tools.","subject":"Dart Home","approved":"false","category":"1345062993772","url":"http://www.dartlang.org/","createdOn":"2012-08-15 16:36:33.453","code":null},{"updatedOn":"null","oid":"1345062993777","description":"Try out the Dart Language from the comfort of your web browser.","subject":"Try Dart","approved":"false","category":"1345062993772","url":"http://try.dartlang.org/","createdOn":"2012-08-15 16:36:33.453","code":null},{"updatedOn":"null","oid":"1345062993779","description":"Official news from the Dart project.","subject":"Dart News","approved":"false","category":"1345062993772","url":"http://news.dartlang.org/","createdOn":"2012-08-15 16:36:33.454","code":null},{"updatedOn":"null","oid":"1345062993780","description":"Dart error management.","subject":"Dart Bugs","approved":"false","category":"1345062993772","url":"????+\\dart&bug!hom","createdOn":"2012-08-15 16:36:33.454","code":null}],"interests":[{"category":"1345062993772","member":"1345062993781","oid":"1345062993784","description":"I am interested in web software developed in Dart.","code":null}],"code":null},{"questions":[],"description":"HTML5 is the ubiquitous platform for the modern web.","oid":"1345062993773","name":"HTML5","approved":"false","webLinks":[],"interests":[],"code":null},{"questions":[],"description":"Cascading Style Sheets for the modern web.","oid":"1345062993775","name":"CSS3","approved":"false","webLinks":[],"interests":[],"code":null}]},{"concept":"Comment","entities":[]},{"concept":"Question","entities":[]}],"model":"Link"}';

/*
var categoryQuestionLinkDataInJson = '''
{
   "domain":"CategoryQuestion",
   "entries":[
      {
         "concept":"Member",
         "entities":[
            {
               "oid":"1345062836286",
               "lastName":"Ridjanovic",
               "password":"drifting09",
               "email":"dzenanr@gmail.com",
               "interests":[
                  {
                     "category":"1345062836277",
                     "member":"1345062836286",
                     "oid":"1345062836289",
                     "description":"I am interested in web software developed in Dart.",
                     "code":null
                  }
               ],
               "about":"I like to walk, hike and stop to have a good bite and drink.",
               "karma":"17.9",
               "code":"dzenanr",
               "receiveEmail":"true",
               "firstName":"Dzenan",
               "startedOn":"2012-08-15 16:33:55.959",
               "role":"admin"
            },
            {
               "oid":"1345062836288",
               "lastName":"Begin",
               "password":"claudeb8527",
               "email":"claude.begin@hotmail.com",
               "interests":[

               ],
               "about":"null",
               "karma":"1",
               "code":"claudeb",
               "receiveEmail":"false",
               "firstName":"Claude",
               "startedOn":"2012-08-15 16:33:55.960",
               "role":"regular"
            }
         ]
      },
      {
         "concept":"Category",
         "entities":[
            {
               "questions":[

               ],
               "description":"Dart Web language.",
               "oid":"1345062836277",
               "name":"Dart",
               "approved":"false",
               "webLinks":[
                  {
                     "updatedOn":"null",
                     "oid":"1345062836281",
                     "description":"Dart is a new web language with libraries and tools.",
                     "subject":"Dart Home",
                     "approved":"false",
                     "category":"1345062836277",
                     "url":"http://www.dartlang.org/",
                     "createdOn":"2012-08-15 16:33:55.958",
                     "code":null
                  },
                  {
                     "updatedOn":"null",
                     "oid":"1345062836283",
                     "description":"Try out the Dart Language from the comfort of your web browser.",
                     "subject":"Try Dart",
                     "approved":"false",
                     "category":"1345062836277",
                     "url":"http://try.dartlang.org/",
                     "createdOn":"2012-08-15 16:33:55.959",
                     "code":null
                  },
                  {
                     "updatedOn":"null",
                     "oid":"1345062836284",
                     "description":"Official news from the Dart project.",
                     "subject":"Dart News",
                     "approved":"false",
                     "category":"1345062836277",
                     "url":"http://news.dartlang.org/",
                     "createdOn":"2012-08-15 16:33:55.959",
                     "code":null
                  },
                  {
                     "updatedOn":"null",
                     "oid":"1345062836285",
                     "description":"Dart error management.",
                     "subject":"Dart Bugs",
                     "approved":"false",
                     "category":"1345062836277",
                     "url":"????+\\dart&bug!hom",
                     "createdOn":"2012-08-15 16:33:55.959",
                     "code":null
                  }
               ],
               "interests":[
                  {
                     "category":"1345062836277",
                     "member":"1345062836286",
                     "oid":"1345062836289",
                     "description":"I am interested in web software developed in Dart.",
                     "code":null
                  }
               ],
               "code":null
            },
            {
               "questions":[

               ],
               "description":"HTML5 is the ubiquitous platform for the modern web.",
               "oid":"1345062836278",
               "name":"HTML5",
               "approved":"false",
               "webLinks":[

               ],
               "interests":[

               ],
               "code":null
            },
            {
               "questions":[

               ],
               "description":"Cascading Style Sheets for the modern web.",
               "oid":"1345062836280",
               "name":"CSS3",
               "approved":"false",
               "webLinks":[

               ],
               "interests":[

               ],
               "code":null
            }
         ]
      },
      {
         "concept":"Comment",
         "entities":[

         ]
      },
      {
         "concept":"Question",
         "entities":[

         ]
      }
   ],
   "model":"Link"
}
''';
*/
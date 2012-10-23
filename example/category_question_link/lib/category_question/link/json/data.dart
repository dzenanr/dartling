//part of category_question_link;

// http://jsonformatter.curiousconcept.com/

// rename dartling to yourDomainName
// rename Skeleton to YourModelName

// data/category_question/link/json/data.dart

var categoryQuestionLinkDataJson = r'''
{
   "domain":"CategoryQuestion",
   "entries":[
      {
         "concept":"Member",
         "entities":[
            {
               "oid":"1346376859922",
               "lastName":"Ridjanovic",
               "password":"drifting09",
               "email":"dzenanr@gmail.com",
               "interests":[
                  {
                     "category":"1346376859911",
                     "member":"1346376859922",
                     "oid":"1346376859925",
                     "description":"I am interested in web software developed in Dart.",
                     "code":null
                  }
               ],
               "about":"I like to walk, hike and stop to have a good bite and drink.\n    In addition, my name is Dženan Riđanović. (Dzenan Ridjanovic).\n    I am an associate professor in the Business School at the\n    Laval University (Universit Laval), Quebec, Canada.\n    I received a B.Sc. in informatics from the University of Sarajevo,\n    an M.Sc. in computer science from the University of Maryland,\n    and a Ph.D. in management information systems from the\n    University of Minnesota. My research interests are in the\n    spiral development of domain models and dynamic web applications\n    with NoSQL databases.",
               "karma":"17.9",
               "code":"dzenanr",
               "receiveEmail":"true",
               "firstName":"Dzenan",
               "startedOn":"2012-08-30 21:34:19.614",
               "role":"admin"
            },
            {
               "oid":"1346376859923",
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
               "startedOn":"2012-08-30 21:34:19.614",
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
               "oid":"1346376859911",
               "name":"Dart",
               "approved":"false",
               "webLinks":[
                  {
                     "updatedOn":"null",
                     "oid":"1346376859917",
                     "description":"Dart is a new web language with libraries and tools.",
                     "subject":"Dart Home",
                     "approved":"false",
                     "category":"1346376859911",
                     "url":"http://www.dartlang.org/",
                     "createdOn":"2012-08-30 21:34:19.613",
                     "code":null
                  },
                  {
                     "updatedOn":"null",
                     "oid":"1346376859918",
                     "description":"Try out the Dart Language from the comfort of your web browser.",
                     "subject":"Try Dart",
                     "approved":"false",
                     "category":"1346376859911",
                     "url":"http://try.dartlang.org/",
                     "createdOn":"2012-08-30 21:34:19.613",
                     "code":null
                  },
                  {
                     "updatedOn":"null",
                     "oid":"1346376859919",
                     "description":"Official news from the Dart project.",
                     "subject":"Dart News",
                     "approved":"false",
                     "category":"1346376859911",
                     "url":"http://news.dartlang.org/",
                     "createdOn":"2012-08-30 21:34:19.613",
                     "code":null
                  },
                  {
                     "updatedOn":"null",
                     "oid":"1346376859921",
                     "description":"Dart error management.",
                     "subject":"Dart Bugs",
                     "approved":"false",
                     "category":"1346376859911",
                     "url":"????+\\dart&bug!hom",
                     "createdOn":"2012-08-30 21:34:19.614",
                     "code":null
                  }
               ],
               "interests":[
                  {
                     "category":"1346376859911",
                     "member":"1346376859922",
                     "oid":"1346376859925",
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
               "oid":"1346376859913",
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
               "oid":"1346376859915",
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
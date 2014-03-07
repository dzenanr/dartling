part of dartling;

String genModel(Model model, String library) {
  Domain domain = model.domain;

  var sc = ' \n';
  sc = '${sc}part of ${library}; \n';
  sc = '${sc} \n';
  sc = '${sc}// lib/${domain.codeLowerUnderscore}/'
       '${model.codeLowerUnderscore}/model.dart \n';
  sc = '${sc} \n';
  sc = '${sc}class ${model.code}Model extends ${model.code}Entries { \n';
  sc = '${sc} \n';
  sc = '${sc}  ${model.code}Model(Model model) : super(model); \n';
  sc = '${sc} \n';
  for (Concept entryConcept in model.entryConcepts) {
    sc = '${sc}  fromJsonTo${entryConcept.code}Entry() { \n';
    sc = '${sc}    fromJson(${domain.codeFirstLetterLower}${model.code}'
         '${entryConcept.code}Entry); \n';
    sc = '${sc}  } \n';
    sc = '${sc} \n';
  }
  
  sc = '${sc}  Map<String, String> fromModelToJson() { \n';
  sc = '${sc}    var jsonEntries = new Map<String, String>(); \n';  
  for (Concept entryConcept in model.entryConcepts) {
    sc = '${sc}    jsonEntries["${entryConcept.code}"] = '
         'toJson("${entryConcept.code}"); \n';
  }
  sc = '${sc}    return jsonEntries; \n';
  sc = '${sc}  } \n';
  sc = '${sc} \n';

  sc = '${sc}  fromJsonToModel(Map<String, String> jsonEntries) { \n';
  sc = '${sc}    var jsonEntries = new Map<String, String>(); \n';  
  for (Concept entryConcept in model.entryConcepts) {
    sc = '${sc}    String ${entryConcept.codeFirstLetterLower}Entry = '
         'jsonEntries["${entryConcept.code}"]; \n';
    sc = '${sc}    fromJson(${entryConcept.codeFirstLetterLower}Entry); \n';
  }
  sc = '${sc}  } \n';
  sc = '${sc} \n';
  var init = _init(model);
  sc = '${sc} ${init} \n'; 
  sc = '${sc}} \n';
  sc = '${sc} \n';
  return sc;
}

String _init(Model model) {
  var sc = ' \n';
  sc = '${sc}  init() { \n';
  for (Concept entryConcept in model.entryConcepts) {
    sc = '${sc}    // =============================== \n';
    sc = '${sc}    // ${entryConcept.code} entry      \n';
    sc = '${sc}    // =============================== \n';
    sc = '${sc}    var ${entryConcept.codeFirstLetterLower}Concept = '
         '${entryConcept.codesFirstLetterLower}.concept; \n';
    sc = '${sc} \n';
    var entitiesCreated = createEntitiesRandomly(entryConcept, 3);
    sc = '${sc}${entitiesCreated}';
  }
  sc = '${sc}  } \n';
  sc = '${sc} \n';   
  return sc;
}

String createEntitiesRandomly(Concept concept, int count, [String parent='']) {
  var sc = '';
  for (var i = 1; i < count + 1; i++) {
    String entity = '${parent}${concept.codeFirstLetterLower}${i}';
    String entities = '${concept.codesFirstLetterLower}';
    sc = '${sc}    var ${entity} = new ${concept.code}('   
         '${concept.codeFirstLetterLower}Concept); \n';
    //var attributesSet = setAttributesRandomly(concept, entity, i.toString());
    var attributesSet = setAttributesRandomly(concept, entity);
    sc = '${sc}${attributesSet}';
    if (parent == '') {
      sc = '${sc}    ${entities}.add(${entity}); \n';     
    } else {
      sc = '${sc}    ${parent}.${entities}.add(${entity}); \n';    
    }
    sc = '${sc} \n';
    for (Child child in concept.children) {
      if (child.internal) {
        Concept childConcept = child.destinationConcept;
        if (i == 1) {
          sc = '${sc}    var ${childConcept.codeFirstLetterLower}Concept = '
               '${entity}.${child.code}.concept; \n';
          sc = '${sc} \n';            
        }
        var entitiesCreated = createEntitiesRandomly(childConcept, 2, entity);
        sc = '${sc}${entitiesCreated}';
      }
    } // for child
  } // for var  
  return sc;
}

String setAttributesRandomly(Concept concept, String entity, [String end='']) {
  var sc = '';
  for (Attribute attribute in concept.attributes) {
    if (attribute.type.code == 'String') {
      if (end == '') {
        sc = '${sc}    ${entity}.${attribute.code} = "${randomWord()}"; \n';
      } else {
        sc = '${sc}    ${entity}.${attribute.code} = "${randomWord()}${end}"; \n';
      }
    } else if (attribute.type.code == 'num') {
      sc = '${sc}    ${entity}.${attribute.code} = ${randomNum(1000)}; \n';
    } else if (attribute.type.code == 'int') {
      sc = '${sc}    ${entity}.${attribute.code} = ${randomInt(10000)}; \n';
    } else if (attribute.type.code == 'double') {
      sc = '${sc}    ${entity}.${attribute.code} = ${randomDouble(100)}; \n';
    } else if (attribute.type.code == 'bool') {
      sc = '${sc}    ${entity}.${attribute.code} = ${randomBool()}; \n';
    } else if (attribute.type.code == 'DateTime') {
      sc = '${sc}    ${entity}.${attribute.code} = new DateTime.now(); \n';
    } else if (attribute.type.code == 'Uri') {
      sc = '${sc}    ${entity}.'
           '${attribute.code} = Uri.parse("${randomUriString()}"); \n';
    }
  }
  return sc;
}

randomBool() => new Random().nextBool();

randomDouble(num max) => new Random().nextDouble() * max;

randomInt(int max) => new Random().nextInt(max);

num randomNum(int max) {
  var logic = randomBool();
  var sign = randomSign();
  if (logic) {
    return sign * randomInt(max);
  } else {
    return sign * randomDouble(max);
  }
}

randomSign() {
  int result = 1;
  var random = randomInt(10);
  if (random == 0 || random == 5 || random == 10) {
    result = -1;
  }
  return result;
}

randomWord() => randomListElement(wordList);

randomUriString() => randomListElement(uriList);

randomListElement(List list) => list[randomInt(list.length - 1)];

var wordList = [
  'home', 'train', 'holiday', 'cup', 'coffee', 'cream', 'architecture', 'judge',
  'wife', 'ship', 'ocean', 'fish', 'drink', 'beer', 'software', 'pattern',
  'children', 'plate', 'room', 'milk', 'lunch', 'dinner', 'web', 'service',
  'body', 'money', 'smog', 'guest', 'cinema', 'series', 'wave', 'river',
  'nothingness', 'hot', 'small', 'instruction', 'cloud', 'consulting', 'beach',
  'place', 'big', 'tall', 'teaching', 'ball', 'circle', 'explanation', 'music',
  'kids', 'month', 'time', 'line', 'horse', 'abstract', 'revolution', 'college',
  'concern', 'house', 'tent', 'paper', 'letter', 'hospital', 'debt', 'undo',
  'family', 'car', 'auto', 'restaurant', 'present', 'parfem', 'bank', 'redo',
  'fascination', 'truck', 'blue', 'accident', 'policeman', 'advisor', 'interest',
  'authority', 'park', 'city', 'craving', 'accomodation', 'account', 'do',
  'school', 'country', 'call', 'cabinet', 'element', 'call', 'center', 'selfdo',
  'teacher', 'message', 'text', 'job', 'table', 'tape', 'price', 'discount',
  'marriage', 'word', 'tag', 'saving', 'cable', 'sand', 'darts', 'autobus',
  'feeling', 'tree', 'flower', 'employer', 'understanding', 'camping', 'pub',
  'heaven', 'beans', 'rice', 'effort', 'umbrella', 'distance', 'mile', 'selfie',
  'hell', 'brad', 'water', 'taxi', 'season', 'seed', 'brave', 'meter', 'done',
  'void', 'yellow', 'lake', 'energy', 'tax', 'heating', 'crisis', 'measuremewnt',
  'point', 'deep', 'corner', 'hunting', 'dog', 'sailing', 'beginning', 'agile',
  'slate', 'wheat', 'pencil', 'enquiry', 'salad', 'salary', 'vacation', '',
  'baby', 'computer', 'algorithm', 'edition', 'television', 'highway', 'winter',
  'life', 'performance', 'productivity', 'economy', 'tension', 'health', 'top',
  'knowledge', 'picture', 'photo', 'entertainment', 'team', 'capacity', 'notch',
  'walking', 'phone', 'bird', 'oil', 'organization', 'election', 'grading',
  'mind', 'boat', 'question', 'electronic', 'entrance', 'head', 'privacy',
  'finger', 'answer', 'sentence', 'candy', 'output', 'hat', 'security', 'ticket',
  'vessel', 'book', 'message', 'navigation', 'cash', 'office', 'east', 'unit',
  'consciousness', 'video', 'email', 'observation', 'objective', 'chemist', 'up',
  'girl', 'agreement', 'training', 'test', 'opinion', 'offence', 'down', 'test',
  'time', 'course', 'school', 'hall', 'celebration', 'thing', 'left', 'future',
  'universe', 'university', 'professor', 'cardboard', 'dvd', 'theme', 'right',
  'lifespan', 'sun', 'sin', 'chairman', 'executive', 'secretary', 'end', 'now'
];

var uriList = [
'http://www.useit.com/alertbox/articles-not-blogs.html',
'http://cci.mit.edu/ci2012/plenaries/index.html',
'http://www.typescriptlang.org/',
'http://whoapi.com/',
'http://news.ycombinator.com/item?id=4530217',
'http://www.pythontutor.com/',
'https://github.com/languages/Dart',
'http://www.drdobbs.com/open-source/dart-build-html5-apps-fast/240005631',
'http://darttrials.blogspot.ca/2012/09/contributed-contributions.html',
'http://kkovacs.eu/cassandra-vs-mongodb-vs-couchdb-vs-redis',
'http://code.google.com/p/dart-enumerators/',
'http://gsdview.appspot.com/dart-editor-archive-continuous/latest/',
'http://www.villa-marrakech.ma/',
'http://www.dartlang.org/articles/idiomatic-dart/',
'http://dartery.blogspot.ca/2012/09/memoizing-functions-in-dart.html',
'http://blog.dynamicprogrammer.com/2012/09/01/first-steps-with-dart.html',
'http://www.dartlang.org/',
'https://github.com/dart-lang',
'http://pub.dartlang.org/',
'http://www.builtwithdart.com/',
'http://www.drdobbs.com/open-source/dart-build-html5-apps-fast/240005631',
'https://code.google.com/p/dart/',
'https://groups.google.com/a/dartlang.org/forum/?fromgroups#!forum/misc',
'https://groups.google.com/a/dartlang.org/forum/?fromgroups#!forum/web-ui',
'http://www.dartlang.org/support/',
'http://code.google.com/p/dart/issues/list',
'http://try.dartlang.org/',
'http://www.dartlang.org/articles/style-guide/',
'http://code.google.com/p/dart/wiki/Contributing',
'http://news.dartlang.org/2012/08/tracking-darts-m1-progress.html',
'http://www.dartlang.org/articles/m1-language-changes/',
'https://github.com/dart-lang',
'http://blog.dartwatch.com/p/community-dart-packages-and-examples.html',
'http://api.dartlang.org/docs/continuous/',
'http://www.dartlang.org/articles/style-guide/',
'http://hilite.me/',
'http://jsonformatter.curiousconcept.com/',
'http://stackoverflow.com/tags/dart',
'http://www.dartlang.org/articles/m1-language-changes/',
'http://www.dartlang.org/articles/dart-unit-tests/',
'http://www.dartlang.org/docs/editor/',
'http://blog.dartwatch.com/p/community-dart-packages-and-examples.html',
'http://www.dartlang.org/slides/2012/06/io12/Bullseye-Your-first-Dart-app-Codelab-GoogleIO2012.pdf',
'http://www.mendeley.com/',
'http://www.google.com/+/learnmore/hangouts/?hl=en'
];

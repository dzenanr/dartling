part of dartling;

String genInitDomainModel(Model model, String library) {
  Domain domain = model.domain;

  var sc = 'part of ${library}; \n';
  sc = '${sc} \n';
  sc = '${sc}// lib/${domain.codeLowerUnderscore}/'
       '${model.codeLowerUnderscore}/init.dart \n';
  sc = '${sc} \n';
  sc = '${sc}init${domain.code}${model.code}(var entries) { \n';
  for (Concept entryConcept in model.entryConcepts) {
    sc = '${sc}  _init${entryConcept.codes}(entries); \n';
  }
  sc = '${sc}} \n';
  sc = '${sc} \n';

  for (Concept entryConcept in model.entryConcepts) {
    sc = '${sc}_init${entryConcept.codes}(var entries) { \n';
    for (var i = 0; i < 10; i++) {
      if (i == 0) {
        sc = '${sc}  ${entryConcept.code} ${entryConcept.codeFirstLetterLower} = ';
      } else {
        sc = '${sc}  ${entryConcept.codeFirstLetterLower} = ';
      }
      sc = '${sc}new ${entryConcept.code}';
      sc = '${sc}(entries.${entryConcept.codesFirstLetterLower}.concept); \n';
      for (Attribute attribute in entryConcept.attributes) {
        if (attribute.type.code == 'String') {
          sc = '  ${sc}  ${entryConcept.codeFirstLetterLower}.${attribute.code} = ';
          sc = '${sc}"value${i}"; \n';
        } else if (attribute.type.code == 'num') {
          sc = '  ${sc}  ${entryConcept.codeFirstLetterLower}.${attribute.code} = ';
          sc = '${sc}${randomNum(1000)}; \n';
        } else if (attribute.type.code == 'int') {
          sc = '  ${sc}  ${entryConcept.codeFirstLetterLower}.${attribute.code} = ';
          sc = '${sc}${randomInt(10000)}; \n';
        } else if (attribute.type.code == 'double') {
          sc = '  ${sc}  ${entryConcept.codeFirstLetterLower}.${attribute.code} = ';
          sc = '${sc}${randomDouble(100)}; \n';
        } else if (attribute.type.code == 'bool') {
          sc = '  ${sc}  ${entryConcept.codeFirstLetterLower}.${attribute.code} = ';
          sc = '${sc}${randomBool()}; \n';
        } else if (attribute.type.code == 'DateTime') {
          sc = '  ${sc}  ${entryConcept.codeFirstLetterLower}.${attribute.code} = ';
          sc = '${sc}new DateTime.now(); \n';
        } else if (attribute.type.code == 'Uri') {
          sc = '  ${sc}  ${entryConcept.codeFirstLetterLower}.${attribute.code} = ';
          sc = '${sc}Uri.parse("${randomUriString()}"); \n';
        }
      }
      sc = '${sc}  entries.${entryConcept.codesFirstLetterLower}.';
      sc = '${sc}add(${entryConcept.codeFirstLetterLower}); \n';
      sc = '${sc} \n';
    }
    sc = '${sc}} \n';
    sc = '${sc} \n';
  }

  return sc;
}

String genConcept(Concept concept, String library) {
  Model model = concept.model;
  Domain domain = model.domain;

  var sc = 'part of ${library}; \n';
  sc = '${sc} \n';
  sc = '${sc}// lib/${domain.codeLowerUnderscore}/'
       '${model.codeLowerUnderscore}/${concept.codesLowerUnderscore}.dart \n';
  sc = '${sc} \n';
  sc = '${sc}class ${concept.code} extends ${concept.code}Gen { \n';
  sc = '${sc} \n';
  sc = '${sc}  ${concept.code}(Concept concept) : super(concept); \n';
  sc = '${sc} \n';

  Id id = concept.id;
  if (id.length > 0) {
    sc = '${sc}  ${concept.code}.withId(Concept concept';
    if (id.parentLength > 0) {
      for (Parent parent in concept.parents) {
        if (parent.identifier) {
          Concept destinationConcept = parent.destinationConcept;
          sc = '${sc}, ${destinationConcept.code} ${parent.code}';
        }
      }
    }
    if (id.attributeLength > 0) {
      for (Attribute attribute in concept.attributes) {
        if (attribute.identifier) {
          sc = '${sc}, ${attribute.type.base} ${attribute.code}';
        }
      }
    }
    sc = '${sc}) : \n';
    sc = '${sc}    super.withId(concept';
    if (id.parentLength > 0) {
      for (Parent parent in concept.parents) {
        if (parent.identifier) {
          sc = '${sc}, ${parent.code}';
        }
      }
    }
    if (id.attributeLength > 0) {
      for (Attribute attribute in concept.attributes) {
        if (attribute.identifier) {
          sc = '${sc}, ${attribute.code}';
        }
      }
    }
    sc = '${sc}); \n';
    sc = '${sc} \n';
  }

  sc = '${sc}} \n';
  sc = '${sc} \n';

  sc = '${sc}class ${concept.codes} extends ${concept.codes}Gen { \n';
  sc = '${sc} \n';
  sc = '${sc}  ${concept.codes}(Concept concept) : super(concept); \n';
  sc = '${sc} \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

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

randomUriString() => randomListElement(uriList);

randomListElement(List list) => list[randomInt(list.length - 1)];

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

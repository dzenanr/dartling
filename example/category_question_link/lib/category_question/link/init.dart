//part of category_question_link;

// data/category_question/link/init.dart

initCategoryQuestionLink(var entries) {
   //_initMembers();
   //_initCategories();
   //_initComments();
   //_initQuestions();

  _initWithTestSetUpData(entries);
}

_initWithTestSetUpData(var entries) {
  var categoryConcept = entries.getConcept('Category');
  var webLinkConcept = entries.getConcept('WebLink');
  var categories = entries.categories;
  var dartCategory = new Category(categoryConcept);
  dartCategory.name = 'Dart';
  dartCategory.description = 'Dart Web language.';
  categories.add(dartCategory);

  var html5Category = new Category(categoryConcept);
  html5Category.name = 'HTML5';
  html5Category.description =
      'HTML5 is the ubiquitous platform for the modern web.';
  categories.add(html5Category);

  var css3Category = new Category(categoryConcept);
  css3Category.name = 'CSS3';
  css3Category.description = 'Cascading Style Sheets for the modern web.';
  categories.add(css3Category);

  var dartHomeWebLink = new WebLink(webLinkConcept);
  dartHomeWebLink.subject = 'Dart Home';
  dartHomeWebLink.url = new Uri.fromString('http://www.dartlang.org/');
  dartHomeWebLink.description =
      'Dart is a new web language with libraries and tools.';
  dartHomeWebLink.category = dartCategory;
  dartCategory.webLinks.add(dartHomeWebLink);

  var tryDartWebLink = new WebLink(webLinkConcept);
  tryDartWebLink.subject = 'Try Dart';
  tryDartWebLink.url = new Uri.fromString('http://try.dartlang.org/');
  tryDartWebLink.description =
      'Try out the Dart Language from the comfort of your web browser.';
  tryDartWebLink.category = dartCategory;
  dartCategory.webLinks.add(tryDartWebLink);

  var dartNewsWebLink = new WebLink(webLinkConcept);
  dartNewsWebLink.subject = 'Dart News';
  dartNewsWebLink.url = new Uri.fromString('http://news.dartlang.org/');
  dartNewsWebLink.description =
      'Official news from the Dart project.';
  dartNewsWebLink.category = dartCategory;
  dartCategory.webLinks.add(dartNewsWebLink);

  var dartBugssWebLink = new WebLink(webLinkConcept);
  dartBugssWebLink.subject = 'Dart Bugs';
  dartBugssWebLink.url = new Uri.fromString('????+\\dart&bug!hom');
  dartBugssWebLink.description = 'Dart error management.';
  dartBugssWebLink.category = dartCategory;
  dartCategory.webLinks.add(dartBugssWebLink);

  var memberConcept = entries.getConcept('Member');
  var interestConcept = entries.getConcept('Interest');
  var members = entries.members;

  var dzenan = new Member(memberConcept);
  dzenan.code = 'dzenanr';
  dzenan.password = 'drifting09';
  dzenan.firstName = 'Dzenan';
  dzenan.lastName = 'Ridjanovic';
  dzenan.email = 'dzenanr@gmail.com';
  dzenan.receiveEmail = true;
  dzenan.role = 'admin';
  dzenan.karma = 17.9;
  //dzenan.about = 'I like to walk, hike and stop to have a good bite and drink.';
  dzenan.about = '''I like to walk, hike and stop to have a good bite and drink.
      In addition, my name is Dženan Riđanović. (Dzenan Ridjanovic).
      I am an associate professor in the Business School at the
      Laval University (Universit Laval), Quebec, Canada.
      I received a B.Sc. in informatics from the University of Sarajevo,
      an M.Sc. in computer science from the University of Maryland,
      and a Ph.D. in management information systems from the
      University of Minnesota. My research interests are in the
      spiral development of domain models and dynamic web applications
      with NoSQL databases.''';
  members.add(dzenan);

  var claudeb = new Member(memberConcept);
  claudeb.code = 'claudeb';
  claudeb.password = 'claudeb8527';
  claudeb.firstName = 'Claude';
  claudeb.lastName = 'Begin';
  claudeb.email = 'claude.begin@hotmail.com';
  members.add(claudeb);

  var dzenanDartInterest = new Interest(interestConcept);
  dzenanDartInterest.description =
      'I am interested in web software developed in Dart.';
  dzenanDartInterest.member = dzenan;
  dzenanDartInterest.category = dartCategory;
  dzenan.interests.add(dzenanDartInterest);
  dartCategory.interests.add(dzenanDartInterest);
}



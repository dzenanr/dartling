
LinkEntry fromJsonToLinkEntry() {
  /**
   *  || Category
   *  id name
   *  at description
   *  0N webLinks
   *
   *  WebLink
   *  id name
   *  rq url
   *  at description
   *  id category
   */
  var _json = '''
    {"width":990,"lines":[{"box2box1Min":"1","box1Name":"Category",
    "box1box2Min":"0","box2Name":"WebLink","category":"relationship",
    "box2box1Id":true,"box2box1Name":"category","box1box2Id":false,
    "box1box2Name":"webLinks","box1box2Max":"N","internal":true,
    "box2box1Max":"1"}],"height":580,"boxes":[{"entry":true,"name":"Category",
    "x":146,"y":201,"width":120,"height":120,"items":[{"sequence":20,
    "category":"identifier","name":"name","type":"String","init":""},
    {"sequence":30,"category":"attribute","name":"description",
    "type":"String","init":""}]},{"entry":false,"name":"WebLink",
    "x":505,"y":215,"width":120,"height":120,
    "items":[{"sequence":20,"category":"identifier","name":"name",
    "type":"String","init":""},{"sequence":30,"category":"required",
    "name":"url","type":"String","init":""},{"sequence":40,
    "category":"attribute","name":"description","type":"String","init":""}]}]}
  ''';
  return new LinkEntry(fromMagicBoxes(_json));
}

testLinkData() {
  var entry;
  var session;
  var data;
  var categories;
  var categoryConcept;
  var webLinkConcept;
  var categoryCount;
  var dartCategoryWebLinkCount;
  group('Testing Link', () {
    setUp(() {
      entry = fromJsonToLinkEntry();
      data = entry.data;
      session = entry.newSession();

      categoryConcept = data.categoryConcept;
      expect(categoryConcept, isNotNull);
      expect(categoryConcept.attributes, isNot(isEmpty));
      expect(categoryConcept.attributes.count, equals(2));

      webLinkConcept = data.webLinkConcept;
      expect(webLinkConcept, isNotNull);
      expect(webLinkConcept.attributes, isNot(isEmpty));
      expect(webLinkConcept.attributes.count, equals(3));

      categoryCount = 0;

      categories = data.categories;
      expect(categories, isNotNull);
      expect(categories.count, equals(categoryCount));

      var dartCategory = new Category(categoryConcept);
      expect(dartCategory, isNotNull);
      expect(dartCategory.webLinks.count, equals(0));
      dartCategory.name = 'Dart';
      dartCategory.description = 'Dart Web language.';
      categories.add(dartCategory);
      expect(categories.count, equals(++categoryCount));

      var html5Category = new Category(categoryConcept);
      expect(html5Category, isNotNull);
      expect(html5Category.webLinks.count, equals(0));
      html5Category.name = 'HTML5';
      html5Category.description =
          'HTML5 is the ubiquitous platform for the modern web.';
      categories.add(html5Category);
      expect(categories.count, equals(++categoryCount));

      var css3Category = new Category(categoryConcept);
      expect(css3Category, isNotNull);
      expect(css3Category.webLinks.count, equals(0));
      css3Category.name = 'CSS3';
      css3Category.description = 'Cascading Style Sheets for the modern web.';
      categories.add(css3Category);
      expect(categories.count, equals(++categoryCount));

      dartCategoryWebLinkCount = 0;

      var dartHomeWebLink = new WebLink(webLinkConcept);
      expect(dartHomeWebLink, isNotNull);
      dartHomeWebLink.name = 'Dart Home';
      dartHomeWebLink.url = new Uri.fromString('http://www.dartlang.org/');
      dartHomeWebLink.description =
          'Dart brings structure to web app engineering '
          'with a new language, libraries, and tools.';
      dartHomeWebLink.category = dartCategory;
      expect(dartHomeWebLink.category, isNotNull);
      dartCategory.webLinks.add(dartHomeWebLink);
      expect(dartCategory.webLinks.count == ++dartCategoryWebLinkCount);

      var tryDartWebLink = new WebLink(webLinkConcept);
      expect(tryDartWebLink, isNotNull);
      tryDartWebLink.name = 'Try Dart';
      tryDartWebLink.url = new Uri.fromString('http://try.dartlang.org/');
      tryDartWebLink.description =
          'Try out the Dart Language from the comfort of your web browser.';
      expect(tryDartWebLink.category, isNull);
      tryDartWebLink.category = dartCategory;
      expect(tryDartWebLink.category, isNotNull);
      dartCategory.webLinks.add(tryDartWebLink);
      expect(dartCategory.webLinks.count, equals(++dartCategoryWebLinkCount));

      var dartNewsWebLink = new WebLink(webLinkConcept);
      expect(dartNewsWebLink, isNotNull);
      dartNewsWebLink.name = 'Dart News';
      dartNewsWebLink.url = new Uri.fromString('http://news.dartlang.org/');
      dartNewsWebLink.description =
          'Official news from the Dart project.';
      expect(dartNewsWebLink.category, isNull);
      dartNewsWebLink.category = dartCategory;
      expect(dartNewsWebLink.category, isNotNull);
      dartCategory.webLinks.add(dartNewsWebLink);
      expect(dartCategory.webLinks.count, equals(++dartCategoryWebLinkCount));

      var dartBugssWebLink = new WebLink(webLinkConcept);
      expect(dartBugssWebLink, isNotNull);
      dartBugssWebLink.name = 'Dart Bugs';
      dartBugssWebLink.url = new Uri.fromString('????+\\dart&bug!hom');
      dartBugssWebLink.description = 'Dart error management.';
      expect(dartBugssWebLink.category, isNull);
      dartBugssWebLink.category = dartCategory;
      expect(dartBugssWebLink.category, isNotNull);
      dartCategory.webLinks.add(dartBugssWebLink);
      expect(dartCategory.webLinks.count, equals(++dartCategoryWebLinkCount));
    });
    tearDown(() {
      categories.clear();
      expect(categories.count, equals(0));
    });
    test('Find Category and Web Link by Id', () {
      Id categoryId = new Id(data.categoryConcept);
      categoryId.setAttribute('name', 'Dart');
      Category dartCategory = categories.findById(categoryId);
      expect(dartCategory, isNotNull);
      expect(dartCategory.name, equals('Dart'));

      WebLinks dartWebLinks = dartCategory.webLinks;
      expect(dartWebLinks.count == dartCategoryWebLinkCount);
      Id dartHomeId = new Id(data.webLinkConcept);
      dartHomeId.setParent('category', dartCategory);
      dartHomeId.setAttribute('name', 'Dart Home');
      WebLink dartHomeWebLink = dartWebLinks.findById(dartHomeId);
      expect(dartHomeWebLink, isNotNull);
      expect(dartHomeWebLink.name, equals('Dart Home'));
    });
    test('Order Categories by Id (code not used, id is name)', () {
      Categories orderedCategories = categories.order();
      expect(orderedCategories, isNotNull);
      expect(orderedCategories, isNot(isEmpty));
      expect(orderedCategories.count, equals(categoryCount));
      expect(orderedCategories.source, isNotNull);
      expect(orderedCategories.source, isNot(isEmpty));
      expect(orderedCategories.source.count, equals(categoryCount));

      orderedCategories.display(
        'Categories Ordered By Id (code not used, id is name)');
    });
    test('Order Dart Web Links by Name', () {
      Category dartCategory = categories.findByAttribute('name', 'Dart');
      expect(dartCategory, isNotNull);
      WebLinks dartWebLinks = dartCategory.webLinks;
      expect(dartWebLinks.count, equals(dartCategoryWebLinkCount));

      WebLinks orderedDartWebLinks = dartWebLinks.order();
      expect(orderedDartWebLinks, isNotNull);
      expect(orderedDartWebLinks, isNot(isEmpty));
      expect(orderedDartWebLinks.count, equals(dartCategoryWebLinkCount));
      expect(orderedDartWebLinks.source, isNotNull);
      expect(orderedDartWebLinks.source, isNot(isEmpty));
      expect(orderedDartWebLinks.source.count,
        equals(dartCategoryWebLinkCount));

      orderedDartWebLinks.display('Ordered Dart Web Links');
    });
    test('New Category with Id', () {
      var webFrameworkCategory =
          new Category.withId(categoryConcept, 'Web Framework');
      expect(webFrameworkCategory, isNotNull);
      expect(webFrameworkCategory.webLinks.count, equals(0));
      categories.add(webFrameworkCategory);
      expect(categories.count, equals(++categoryCount));

      categories.display('Categories Including Web Framework');
    });
    test('New WebLink No Category Error', () {
      Category dartCategory = categories.findByAttribute('name', 'Dart');
      expect(dartCategory, isNotNull);

      var dartHomeWebLink = new WebLink(webLinkConcept);
      expect(dartHomeWebLink, isNotNull);
      expect(dartHomeWebLink.category, isNull);
      dartHomeWebLink.name = 'Dart Home';
      dartHomeWebLink.url = new Uri.fromString('http://www.dartlang.org/');
      dartHomeWebLink.description =
          'Dart brings structure to web app engineering '
          'with a new language, libraries, and tools.';
      dartCategory.webLinks.add(dartHomeWebLink);
      expect(dartCategory.webLinks.count, equals(dartCategoryWebLinkCount));
      expect(dartCategory.webLinks.errors.count, equals(1));
      expect(dartCategory.webLinks.errors.list[0].category, equals('required'));
      dartCategory.webLinks.errors.display('WebLink Error');
    });
    test('New Uri from String', () {
      Uri uri;
      var s;

      try {
        s = '????:\\**""##&dartbug!hom';
        uri = new Uri.fromString(s);
      } catch (final IllegalArgumentException e) {
        expect(uri, isNull);
        print('/// Not valid uri: $s; $e');
        print('');
      }
      expect(uri, isNotNull);  // it should be: expect(uri, isNull);
      print('/// Not valid uri, but no illegal argument exception: $uri');
      print('');

      try {
        s = '';
        uri = new Uri.fromString(s);
      } catch (final IllegalArgumentException e) {
        expect(uri, isNull);
        print('/// Not valid uri: $s; $e');
        print('');
      }
      expect(uri, isNotNull);  // it should be: expect(uri, isNull);
      print('/// Not valid uri, but no illegal argument exception: $uri');
      print('');

      try {
        s = null;
        uri = null;
        uri = new Uri.fromString(s);
      } catch (final NullPointerException e) {
        expect(uri, isNull);
        print('/// Not valid uri: $s; $e');
        print('');
      }
    });
    test('No Concept Defined for Errors', () {
      Category dartCategory = categories.findByAttribute('name', 'Dart');
      expect(dartCategory, isNotNull);

      try {
        dartCategory.webLinks.errors.selectByAttribute('category', 'required');
      } catch (final ConceptException ce) {
        print('');
        print('In testWebData(), try errors.selectByAttribute -- $ce');
        print('');
      }
      expect(() =>
          dartCategory.webLinks.errors.selectByAttribute('category', 'required'),
          throwsException);
    });
    test('Undo and Redo Action', () {
      var webFrameworkCategory =
          new Category.withId(categoryConcept, 'Web Framework');
      expect(webFrameworkCategory, isNotNull);
      expect(webFrameworkCategory.webLinks.count, equals(0));

      var action = new AddAction(session, categories, webFrameworkCategory);
      action.doit();
      expect(categories.count, equals(++categoryCount));

      session.past.undo();
      expect(categories.count, equals(--categoryCount));

      session.past.redo();
      expect(categories.count, equals(++categoryCount));
    });
    test('Undo and Redo Transaction', () {
      var webFrameworkCategory =
          new Category.withId(categoryConcept, 'Web Framework');
      expect(webFrameworkCategory, isNotNull);
      expect(webFrameworkCategory.webLinks.count, equals(0));

      var action1 = new AddAction(session, categories, webFrameworkCategory);

      var dbCategory = new Category.withId(categoryConcept, 'Database');
      expect(dbCategory, isNotNull);
      expect(dbCategory.webLinks.count, equals(0));

      var action2 = new AddAction(session, categories, dbCategory);

      var transaction = new Transaction('two adds on categories', session);
      transaction.add(action1);
      transaction.add(action2);
      transaction.doit();
      categoryCount = categoryCount + 2;
      expect(categories.count, equals(categoryCount));
      categories.display('Transaction Done');

      session.past.undo();
      categoryCount = categoryCount - 2;
      expect(categories.count, equals(categoryCount));
      categories.display('Transaction Undone');

      session.past.redo();
      categoryCount = categoryCount + 2;
      expect(categories.count, equals(categoryCount));
      categories.display('Transaction Redone');
    });
    test('Undo and Redo Transaction with Id Error', () {
      var webFrameworkCategory =
          new Category.withId(categoryConcept, 'Web Framework');
      expect(webFrameworkCategory, isNotNull);
      expect(webFrameworkCategory.webLinks.count, equals(0));

      var action1 = new AddAction(session, categories, webFrameworkCategory);

      var dbCategory = new Category.withId(categoryConcept, 'Dart');
      expect(dbCategory, isNotNull);
      expect(dbCategory.webLinks.count, equals(0));

      var action2 = new AddAction(session, categories, dbCategory);

      var transaction = new Transaction(
        'two adds on categories, with an error on the second', session);
      transaction.add(action1);
      transaction.add(action2);
      var done = transaction.doit();
      expect(categories.count, equals(categoryCount));
      categories.display('Transaction (with Id Error) Done');

      if (done) {
        var undone = session.past.undo();
        expect(categories.count, equals(categoryCount));
        categories.display('Transaction (with Id Error) Undone');
        if (undone) {
          session.past.redo();
          expect(categories.count, equals(categoryCount));
          categories.display('Transaction (with Id Error) Redone');
        }
      }
    });
    test('Undo and Redo Transaction on Two Different Concepts', () {
      var webFrameworkCategory =
          new Category.withId(categoryConcept, 'Web Framework');
      expect(webFrameworkCategory, isNotNull);
      expect(webFrameworkCategory.webLinks.count, equals(0));

      var action1 = new AddAction(session, categories, webFrameworkCategory);

      var wicketWebLink = new WebLink(webLinkConcept);
      expect(wicketWebLink, isNotNull);
      wicketWebLink.name = 'Wicket';
      wicketWebLink.url = new Uri.fromString('http://wicket.apache.org/');
      wicketWebLink.description =
          'With proper mark-up/logic separation, a POJO data model, '
          'and a refreshing lack of XML, Apache Wicket makes developing '
          'web-apps simple and enjoyable again. Swap the boilerplate, complex '
          'debugging and brittle code for powerful, reusable components written '
          'with plain Java and HTML.';
      wicketWebLink.category = webFrameworkCategory;
      expect(webFrameworkCategory.webLinks.count, equals(0));

      var action2 =
          new AddAction(session, webFrameworkCategory.webLinks, wicketWebLink);

      var transaction = new Transaction('two adds on different concepts', session);
      transaction.add(action1);
      transaction.add(action2);
      transaction.doit();
      expect(categories.count, equals(++categoryCount));
      expect(webFrameworkCategory.webLinks.count, equals(1));
      categories.display('Transaction  on Two Different Concepts Done');

      session.past.undo();
      expect(categories.count, equals(--categoryCount));
      categories.display('Transaction on Two Different Concepts Undone');

      session.past.redo();
      expect(categories.count, equals(++categoryCount));
      var category = categories.findByAttribute('name', 'Web Framework');
      expect(category, isNotNull);
      expect(category.webLinks.count, equals(1));
      categories.display('Transaction on Two Different Concepts Redone');
    });

  });
}
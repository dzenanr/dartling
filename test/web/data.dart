testWebData() {
  var data;
  group('Testing', () {
    setUp(() {
      data = new WebData();
      var categoryConcept = data.categoryConcept;
      expect(categoryConcept, isNotNull);
      expect(categoryConcept.attributes, isNot(isEmpty));
      expect(categoryConcept.attributes.count == 2);
      var webLinkConcept = data.webLinkConcept;
      expect(webLinkConcept, isNotNull);
      expect(webLinkConcept.attributes, isNot(isEmpty));
      expect(webLinkConcept.attributes.count == 3);
      var categories = data.categories;
      expect(categories, isNotNull);
      expect(categories.count == 0);

      var dartCategory = new Category(categoryConcept);
      expect(dartCategory, isNotNull);
      expect(dartCategory.webLinks.count == 0);
      dartCategory.name = 'Dart';
      dartCategory.description = 'Dart Web language.';
      categories.add(dartCategory);
      expect(categories.count == 1);

      var html5Category = new Category(categoryConcept);
      expect(html5Category, isNotNull);
      expect(html5Category.webLinks.count == 0);
      html5Category.name = 'HTML5';
      html5Category.description = 'HTML5 is the ubiquitous platform for the web.';
      categories.add(html5Category);
      expect(categories.count == 2);

      var dartHomeWebLink = new WebLink(webLinkConcept);
      expect(dartHomeWebLink, isNotNull);
      expect(dartHomeWebLink.category, isNull);
      dartHomeWebLink.name = 'Dart Home';
      dartHomeWebLink.url = 'http://www.dartlang.org/';
      dartHomeWebLink.description =
          'Dart brings structure to web app engineering '
          'with a new language, libraries, and tools.';
      dartCategory.webLinks.add(dartHomeWebLink);
      expect(dartCategory.webLinks.count == 0);
      expect(dartCategory.webLinks.errors.count == 1);
      expect(dartCategory.webLinks.errors.getList()[0].category == 'required');
      dartCategory.webLinks.errors.display('WebLink Error');

      try {
        dartCategory.webLinks.errors.selectByAttribute('category', 'required');
      } catch (final ConceptException ce) {
        print('$ce');
      }

      dartHomeWebLink.category = dartCategory;
      expect(dartHomeWebLink.category, isNotNull);
      dartCategory.webLinks.add(dartHomeWebLink);
      expect(dartCategory.webLinks.count == 1);

      var tryDartWebLink = new WebLink(webLinkConcept);
      expect(tryDartWebLink, isNotNull);
      tryDartWebLink.name = 'Try Dart';
      tryDartWebLink.url = 'http://try.dartlang.org/';
      tryDartWebLink.description =
          'Try out the Dart Language from the comfort of your web browser.';
      expect(tryDartWebLink.category, isNull);
      tryDartWebLink.category = dartCategory;
      expect(tryDartWebLink.category, isNotNull);
      tryDartWebLink.display('try: ');
      dartCategory.webLinks.add(tryDartWebLink);
      expect(dartCategory.webLinks.count == 2);

      var dartNewsWebLink = new WebLink(webLinkConcept);
      expect(dartNewsWebLink, isNotNull);
      dartNewsWebLink.name = 'Dart News';
      dartNewsWebLink.url = 'http://news.dartlang.org/';
      dartNewsWebLink.description =
          'Official news from the Dart project.';
      expect(dartNewsWebLink.category, isNull);
      dartNewsWebLink.category = dartCategory;
      expect(dartNewsWebLink.category, isNotNull);
      dartCategory.webLinks.add(dartNewsWebLink);
      expect(dartCategory.webLinks.count == 3);
    });
    tearDown(() {
      var categories = data.categories;
      categories.empty();
      expect(categories.count == 0);
    });
    test('Get Category and Web Link By Id', () {
      var categories = data.categories;
      expect(categories.count == 2);
      categories.display('Categories With Web Links');

      Id categoryId = new Id(data.categoryConcept);
      categoryId.setAttribute('name', 'Dart');
      Category dartCategory = categories.getEntityById(categoryId);
      expect(dartCategory, isNotNull);
      expect(dartCategory.name == 'Dart');

      WebLinks dartWebLinks = dartCategory.webLinks;
      expect(dartWebLinks.count == 3);
      Id dartHomeId = new Id(data.webLinkConcept);
      dartHomeId.setParent('category', dartCategory);
      dartHomeId.setAttribute('name', 'Dart Home');
      WebLink dartHomeWebLink = dartWebLinks.getEntityById(dartHomeId);
      expect(dartHomeWebLink, isNotNull);
      expect(dartHomeWebLink.name == 'Dart Home');
    });
    test('Order Web Links By Name', () {
      var categories = data.categories;
      expect(categories.count == 2);
      categories.display('Categories With Web Links');

      Category dartCategory = categories.getEntityByAttribute('name', 'Dart');
      expect(dartCategory, isNotNull);
      WebLinks dartWebLinks = dartCategory.webLinks;
      expect(dartWebLinks.count == 3);

      List<WebLink> orderedDartWebLinkList = dartWebLinks.order();
      expect(orderedDartWebLinkList, isNotNull);
      expect(orderedDartWebLinkList, isNot(isEmpty));
      expect(orderedDartWebLinkList.length == 3);

      WebLinks orderedDartWebLinks = new WebLinks(data.categoryConcept);
      orderedDartWebLinks.addFrom(orderedDartWebLinkList);
      orderedDartWebLinks.sourceEntities = dartWebLinks;
      expect(orderedDartWebLinks, isNotNull);
      expect(orderedDartWebLinks, isNot(isEmpty));
      expect(orderedDartWebLinks.count == 3);
      expect(orderedDartWebLinks.sourceEntities, isNotNull);
      expect(orderedDartWebLinks.sourceEntities, isNot(isEmpty));
      expect(orderedDartWebLinks.sourceEntities.count == 3);

      orderedDartWebLinks.display('Ordered Dart Web Links');
    });
  });
}




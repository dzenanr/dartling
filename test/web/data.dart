testWebData() {
  var catalog;
  group('Testing', () {
    setUp(() {
      catalog = new Catalog();
      var categoryConcept = catalog.categoryConcept;
      expect(categoryConcept, isNotNull);
      expect(categoryConcept.attributes, isNot(isEmpty));
      expect(categoryConcept.attributes.count == 1);
      var webLinkConcept = catalog.webLinkConcept;
      expect(webLinkConcept, isNotNull);
      expect(webLinkConcept.attributes, isNot(isEmpty));
      expect(webLinkConcept.attributes.count == 2);
      var categories = catalog.categories;
      expect(categories, isNotNull);
      expect(categories.count == 0);

      var dartCategory = new Category(categoryConcept);
      expect(dartCategory, isNotNull);
      expect(dartCategory.webLinks.count == 0);
      dartCategory.code = 'Dart';
      dartCategory.description = 'Dart Web language.';
      categories.add(dartCategory);
      expect(categories.count == 1);

      var html5Category = new Category(categoryConcept);
      expect(html5Category, isNotNull);
      expect(html5Category.webLinks.count == 0);
      html5Category.code = 'HTML5';
      html5Category.description = 'HTML5 is the ubiquitous platform for the web.';
      categories.add(html5Category);
      expect(categories.count == 2);

      var dartHomeWebLink = new WebLink(webLinkConcept);
      expect(dartHomeWebLink, isNotNull);
      expect(dartHomeWebLink.category, isNull);
      dartHomeWebLink.code = 'Dart Home';
      dartHomeWebLink.url = 'http://www.dartlang.org/';
      dartHomeWebLink.description =
          'Dart brings structure to web app engineering '
          'with a new language, libraries, and tools.';
      dartCategory.webLinks.add(dartHomeWebLink);
      expect(dartCategory.webLinks.count == 1);
      dartHomeWebLink.category = dartCategory;
      expect(dartHomeWebLink.category, isNotNull);

      var tryDartWebLink = new WebLink(webLinkConcept);
      expect(tryDartWebLink, isNotNull);
      expect(tryDartWebLink.category, isNull);
      tryDartWebLink.code = 'Try Dart';
      tryDartWebLink.url = 'http://try.dartlang.org/';
      tryDartWebLink.description =
          'Try out the Dart Language from the comfort of your web browser.';
      dartCategory.webLinks.add(tryDartWebLink);
      expect(dartCategory.webLinks.count == 2);
      tryDartWebLink.category = dartCategory;
      expect(tryDartWebLink.category, isNotNull);

      var dartNewsWebLink = new WebLink(webLinkConcept);
      expect(dartNewsWebLink, isNotNull);
      expect(dartNewsWebLink.category, isNull);
      dartNewsWebLink.code = 'Dart News';
      dartNewsWebLink.url = 'http://news.dartlang.org/';
      dartNewsWebLink.description =
          'Official news from the Dart project.';
      dartCategory.webLinks.add(dartNewsWebLink);
      expect(dartCategory.webLinks.count == 3);
      dartNewsWebLink.category = dartCategory;
      expect(dartNewsWebLink.category, isNotNull);
    });
    tearDown(() {
      var categories = catalog.categories;
      categories.empty();
      expect(categories.count == 0);
    });
    test('Order Web Links By Code', () {
      var categories = catalog.categories;
      expect(categories.count == 2);
      //categories.display('Categories', withOid: false);
      categories.display('Categories With Web Links');

      Category dartCategory = categories.getEntityByCode('Dart');
      expect(dartCategory, isNotNull);
      WebLinks dartWebLinks = dartCategory.webLinks;
      expect(dartWebLinks.count == 3);

      List<WebLink> orderedDartWebLinkList =
          dartWebLinks.orderByCode();
      expect(orderedDartWebLinkList, isNotNull);
      expect(orderedDartWebLinkList, isNot(isEmpty));
      expect(orderedDartWebLinkList.length == 3);

      WebLinks orderedDartWebLinks = new WebLinks(catalog.categoryConcept);
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



unitTests() {
  test('Catalog Creation', () {
    var catalog = new Catalog();
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

    //categories.display('Catalog', withOid: false);
    categories.display('Create Web Catalog');
  });
}

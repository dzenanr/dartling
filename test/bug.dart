
testBug() {
  test('Child Parent', () {
    var data = new WebData();
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

    var dartHomeWebLink = new WebLink(webLinkConcept);
    expect(dartHomeWebLink, isNotNull);
    dartHomeWebLink.name = 'Dart Home';
    dartHomeWebLink.url = 'http://www.dartlang.org/';
    dartHomeWebLink.description =
        'Dart brings structure to web app engineering '
        'with a new language, libraries, and tools.';
    expect(dartHomeWebLink.category, isNull);
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
    dartCategory.webLinks.add(tryDartWebLink);
    expect(dartCategory.webLinks.count == 2);
  });
}

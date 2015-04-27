import 'package:test/test.dart';
import 'package:dartling/dartling.dart';

Model createDomainModel() {
  Domain domain = new Domain('CategoryQuestion');
  Model model = new Model(domain, 'Link');
  assert(domain.models.length == 1);

  Concept categoryConcept = new Concept(model, 'Category');
  categoryConcept.description = 'Category of web links.';
  assert(model.concepts.length == 1);
  new Attribute(categoryConcept, 'name').identifier = true;
  new Attribute(categoryConcept, 'description');
  assert(categoryConcept.attributes.length == 2);

  Concept webLinkConcept = new Concept(model, 'WebLink');
  webLinkConcept.entry = false;
  webLinkConcept.description = 'Web links of interest.';
  assert(model.concepts.length == 2);
  new Attribute(webLinkConcept, 'subject').identifier = true;
  new Attribute(webLinkConcept, 'url');
  new Attribute(webLinkConcept, 'description');
  assert(webLinkConcept.attributes.length == 3);

  Child categoryWebLinksNeighbor =
      new Child(categoryConcept, webLinkConcept, 'webLinks');
  Parent webLinkCategoryNeighbor =
      new Parent(webLinkConcept, categoryConcept, 'category');
  webLinkCategoryNeighbor.identifier = true;
  categoryWebLinksNeighbor.opposite = webLinkCategoryNeighbor;
  webLinkCategoryNeighbor.opposite = categoryWebLinksNeighbor;
  assert(categoryConcept.children.length == 1);
  assert(webLinkConcept.parents.length == 1);
  assert(categoryConcept.sourceParents.length == 1);
  assert(webLinkConcept.sourceChildren.length == 1);

  return model;
}

ModelEntries createModelData(Model model) {
  var entries = new ModelEntries(model);
  Entities categories = entries.getEntry('Category');
  assert(categories.length == 0);

  ConceptEntity dartCategory = new ConceptEntity();
  dartCategory.concept = categories.concept;
  dartCategory.setAttribute('name', 'Dart');
  dartCategory.setAttribute('description', 'Dart Web language.');
  categories.add(dartCategory);
  assert(categories.length == 1);

  ConceptEntity html5Category = new ConceptEntity();
  html5Category.concept = categories.concept;
  html5Category.setAttribute('name', 'HTML5');
  html5Category.setAttribute('description',
    'HTML5 is the ubiquitous platform for the web.');
  categories.add(html5Category);

  Entities dartWebLinks = dartCategory.getChild('webLinks');
  assert(dartWebLinks.length == 0);

  ConceptEntity dartHomeWebLink = new ConceptEntity();
  dartHomeWebLink.concept = dartWebLinks.concept;
  dartHomeWebLink.setAttribute('subject', 'Dart Home');
  dartHomeWebLink.setAttribute('url', 'http://www.dartlang.org/');
  dartHomeWebLink.setAttribute('description',
    'Dart brings structure to web app engineering with a new language, libraries, and tools.');
  dartHomeWebLink.setParent('category', dartCategory);
  dartWebLinks.add(dartHomeWebLink);
  assert(dartWebLinks.length == 1);
  assert(dartHomeWebLink.getParent('category').getAttribute('name') == 'Dart');

  ConceptEntity tryDartWebLink = new ConceptEntity();
  tryDartWebLink.concept = dartWebLinks.concept;
  tryDartWebLink.setAttribute('subject', 'Try Dart');
  tryDartWebLink.setAttribute('url', 'http://try.dartlang.org/');
  tryDartWebLink.setAttribute('description',
    'Try out the Dart Language from the comfort of your web browser.');
  tryDartWebLink.setParent('category', dartCategory);
  dartWebLinks.add(tryDartWebLink);
  assert(dartWebLinks.length == 2);
  assert(tryDartWebLink.getParent('category').getAttribute('name') == 'Dart');
  return entries;
}

testModelData(Model model) {
  ModelEntries entries;
  group('Testing Model Data:', () {
    setUp(() {
      entries = createModelData(model);
      expect(entries, isNotNull);
    });
    tearDown(() {
      entries.clear();
      expect(entries.isEmpty, isTrue);
    });
    test('Find Category and Web Link by Id', () {
      var categories = entries.getEntry('Category');
      Id categoryId = new Id(entries.getConcept('Category'));
      categoryId.setAttribute('name', 'Dart');
      var dartCategory = categories.singleWhereId(categoryId);
      expect(dartCategory, isNotNull);
      expect(dartCategory.getAttribute('name'), equals('Dart'));
      var dartWebLinks = dartCategory.getChild('webLinks');
      Id dartHomeId = new Id(entries.getConcept('WebLink'));
      dartHomeId.setParent('category', dartCategory);
      dartHomeId.setAttribute('subject', 'Dart Home');
      var dartHomeWebLink = dartWebLinks.singleWhereId(dartHomeId);
      expect(dartHomeWebLink, isNotNull);
      expect(dartHomeWebLink.getAttribute('subject'), equals('Dart Home'));
    });
    test('Sort Categories by Id (code not used, id is name)', () {
      var categories = entries.getEntry('Category');
      categories.sort();
      categories.display(title:
        'Categories Sorted By Id (code not used, id is name)');
    });
    test('Sort Dart Web Links by Name', () {
      var categories = entries.getEntry('Category');
      var dartCategory = categories.firstWhereAttribute('name', 'Dart');
      expect(dartCategory, isNotNull);
      var dartWebLinks = dartCategory.getChild('webLinks');
      dartWebLinks.sort();
      dartWebLinks.display(title:'Sorted Dart Web Links');
    });
    test('New Category with Id', () {
      var categories = entries.getEntry('Category');
      var categoryCount = categories.length;
      var webFrameworkCategory = new ConceptEntity();
      webFrameworkCategory.concept = categories.concept;
      webFrameworkCategory.setAttribute('name', 'Web Framework');
      expect(webFrameworkCategory, isNotNull);
      expect(webFrameworkCategory.getChild('webLinks').length, equals(0));
      categories.add(webFrameworkCategory);
      expect(categories.length, equals(++categoryCount));

      categories.display(title:'Categories Including Web Framework');
    });
    test('New WebLink No Category Error', () {
      var categories = entries.getEntry('Category');
      var dartCategory = categories.firstWhereAttribute('name', 'Dart');
      expect(dartCategory, isNotNull);

      var dartWebLinks = dartCategory.getChild('webLinks');
      var dartHomeWebLink = new ConceptEntity();
      dartHomeWebLink.concept = dartWebLinks.concept;
      expect(dartHomeWebLink, isNotNull);
      expect(dartHomeWebLink.getParent('category'), isNull);

      dartHomeWebLink.setAttribute('subject', 'Dart Home');
      dartHomeWebLink.setAttribute('url', 'http://www.dartlang.org/');
      dartHomeWebLink.setAttribute('description', 'Dart brings structure to '
          'web app engineering with a new language, libraries, and tools.');
      dartCategory.getChild('webLinks').add(dartHomeWebLink);
      expect(dartCategory.getChild('webLinks').length, equals(dartWebLinks.length));
      expect(dartCategory.getChild('webLinks').errors.length, equals(1));
      expect(dartCategory.getChild('webLinks').errors.toList()[0].category,
          equals('required'));
      dartCategory.getChild('webLinks').errors.display(title:'WebLink Error');
    });
    test('From Link Model to JSON', () {
      var entryConceptCode = 'Category';
      var json = entries.fromEntryToJson(entryConceptCode);
      expect(json, isNotNull);
      entries.displayEntryJson(entryConceptCode);
    });

  });
}

void main() {
  testModelData(createDomainModel());
}

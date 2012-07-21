
createModelEntry() {
  // Meta

  Domain domain = new Domain();
  Model model = new Model(domain);
  assert(domain.models.length == 1);

  Concept categoryConcept = new Concept(model, 'Category');
  categoryConcept.description = 'Category of web links.';
  assert(model.concepts.length == 1);
  Attribute categoryDescriptionAttribute =
      new Attribute(categoryConcept, 'description');
  assert(categoryConcept.attributes.length == 1);

  Concept webLinkConcept = new Concept(model, 'WebLink');
  webLinkConcept.entry = false;
  webLinkConcept.description = 'Web links of interest.';
  assert(model.concepts.length == 2);
  Attribute webLinkUrlAttribute = new Attribute(webLinkConcept, 'url');
  Attribute webLinkDescriptionAttribute =
      new Attribute(webLinkConcept, 'description');
  assert(webLinkConcept.attributes.length == 2);

  Neighbor categoryWebLinksNeighbor =
      new Neighbor(categoryConcept, webLinkConcept, 'webLinks');
  categoryWebLinksNeighbor.max = 'N';
  assert(categoryConcept.destinations.length == 1);
  assert(webLinkConcept.sources.length == 1);
  Neighbor webLinkCategoryNeighbor =
      new Neighbor(webLinkConcept, categoryConcept, 'category');
  webLinkCategoryNeighbor.id = true;
  webLinkCategoryNeighbor.child = false;
  categoryWebLinksNeighbor.opposite = webLinkCategoryNeighbor;
  webLinkCategoryNeighbor.opposite = categoryWebLinksNeighbor;
  assert(webLinkConcept.destinations.length == 1);
  assert(categoryConcept.sources.length == 1);

  // Data

  Entries entries = new Entries(model);
  assert(entries.length == 1);
  Entities categories = entries.getEntry('Category');
  assert(categories.length == 0);

  Entity dartCategory = new Entity.of(categoryConcept);
  dartCategory.code = 'Dart';
  dartCategory.setAttribute('description', 'Dart Web language.');
  categories.add(dartCategory);
  assert(categories.length == 1);

  Entity html5Category = new Entity.of(categoryConcept);
  html5Category.code = 'HTML5';
  html5Category.setAttribute('description',
    'HTML5 is the ubiquitous platform for the web.');
  categories.add(html5Category);

  Entities dartWebLinks = dartCategory.getChild('webLinks');
  assert(dartWebLinks.length == 0);

  Entity dartHomeWebLink = new Entity.of(webLinkConcept);
  dartHomeWebLink.code = 'Dart Home';
  dartHomeWebLink.setAttribute('url', 'http://www.dartlang.org/');
  dartHomeWebLink.setAttribute('description',
    'Dart brings structure to web app engineering with a new language, libraries, and tools.');
  dartWebLinks.add(dartHomeWebLink);
  assert(dartWebLinks.length == 1);
  dartHomeWebLink._parentMap['category'] = dartCategory;
  assert(dartHomeWebLink.getParent('category').code == 'Dart');

  Entity tryDartWebLink = new Entity.of(webLinkConcept);
  tryDartWebLink.code = 'Try Dart';
  tryDartWebLink.setAttribute('url', 'http://try.dartlang.org/');
  tryDartWebLink.setAttribute('description',
    'Try out the Dart Language from the comfort of your web browser.');
  dartWebLinks.add(tryDartWebLink);
  assert(dartWebLinks.length == 2);
  tryDartWebLink.setParent('category', dartCategory);
  assert(tryDartWebLink.getParent('category').code == 'Dart');

  // Display
  print('');
  print('******************');
  print('Create Model Entry');
  print('******************');
  print('');
  categories.display();
  print('');
  print('With Oids');
  print('==========');
  print('');
  categories.display(withOid: true);
}

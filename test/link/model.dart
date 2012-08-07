
testLinkModel() {
  // Meta

  Domain domain = new Domain();
  Model model = new Model(domain);
  assert(domain.models.count == 1);

  Concept categoryConcept = new Concept(model, 'Category');
  categoryConcept.description = 'Category of web links.';
  assert(model.concepts.count == 1);
  new Attribute(categoryConcept, 'name').id = true;
  new Attribute(categoryConcept, 'description');
  assert(categoryConcept.attributes.count == 2);

  Concept webLinkConcept = new Concept(model, 'WebLink');
  webLinkConcept.entry = false;
  webLinkConcept.description = 'Web links of interest.';
  assert(model.concepts.count == 2);
  new Attribute(webLinkConcept, 'name').id = true;
  new Attribute(webLinkConcept, 'url');
  new Attribute(webLinkConcept, 'description');
  assert(webLinkConcept.attributes.count == 3);

  Child categoryWebLinksNeighbor =
      new Child(categoryConcept, webLinkConcept, 'webLinks');
  Parent webLinkCategoryNeighbor =
      new Parent(webLinkConcept, categoryConcept, 'category');
  webLinkCategoryNeighbor.id = true;
  categoryWebLinksNeighbor.opposite = webLinkCategoryNeighbor;
  webLinkCategoryNeighbor.opposite = categoryWebLinksNeighbor;
  assert(categoryConcept.children.count == 1);
  assert(webLinkConcept.parents.count == 1);
  assert(categoryConcept.sourceParents.count == 1);
  assert(webLinkConcept.sourceChildren.count == 1);

  // Data

  var entries = new Data(model);
  Entities categories = entries.getEntry('Category');
  assert(categories.count == 0);

  Entity dartCategory = new Entity.of(categoryConcept);
  dartCategory.setAttribute('name', 'Dart');
  dartCategory.setAttribute('description', 'Dart Web language.');
  categories.add(dartCategory);
  assert(categories.count == 1);

  Entity html5Category = new Entity.of(categoryConcept);
  html5Category.setAttribute('name', 'HTML5');
  html5Category.setAttribute('description',
    'HTML5 is the ubiquitous platform for the web.');
  categories.add(html5Category);

  Entities dartWebLinks = dartCategory.getChild('webLinks');
  assert(dartWebLinks.count == 0);

  Entity dartHomeWebLink = new Entity.of(webLinkConcept);
  dartHomeWebLink.setAttribute('name', 'Dart Home');
  dartHomeWebLink.setAttribute('url', 'http://www.dartlang.org/');
  dartHomeWebLink.setAttribute('description',
    'Dart brings structure to web app engineering with a new language, libraries, and tools.');
  dartWebLinks.add(dartHomeWebLink);
  assert(dartWebLinks.count == 1);
  dartHomeWebLink.setParent('category', dartCategory);
  assert(dartHomeWebLink.getParent('category').getAttribute('name') == 'Dart');

  Entity tryDartWebLink = new Entity.of(webLinkConcept);
  tryDartWebLink.setAttribute('name', 'Try Dart');
  tryDartWebLink.setAttribute('url', 'http://try.dartlang.org/');
  tryDartWebLink.setAttribute('description',
    'Try out the Dart Language from the comfort of your web browser.');
  dartWebLinks.add(tryDartWebLink);
  assert(dartWebLinks.count == 2);
  tryDartWebLink.setParent('category', dartCategory);
  assert(tryDartWebLink.getParent('category').getAttribute('name') == 'Dart');

  // Display
  categories.display('Link Model Creation', withOid: true);
}

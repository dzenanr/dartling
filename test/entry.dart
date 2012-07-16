
createModelEntry() {
  // Meta
  
  Domain domain = new Domain();
  Model model = new Model(domain);
  assert(domain.childModels.length == 1);
  
  Concept categoryConcept = new Concept(model, 'Category');
  categoryConcept.description = 'Category of web links.';
  assert(model.childConcepts.length == 1);
  Attribute categoryDescriptionAttribute = new Attribute(categoryConcept, 'description');
  assert(categoryConcept.childAttributes.length == 1);
  
  Concept webLinkConcept = new Concept(model, 'WebLink');
  webLinkConcept.entry = false;
  webLinkConcept.description = 'Web links of interest.';
  assert(model.childConcepts.length == 2);
  Attribute webLinkUrlAttribute = new Attribute(webLinkConcept, 'url');
  Attribute webLinkDescriptionAttribute = new Attribute(webLinkConcept, 'description');
  assert(webLinkConcept.childAttributes.length == 2);
  
  Neighbor categoryWebLinksNeighbor = new Neighbor(categoryConcept, webLinkConcept, 'webLinks');
  categoryWebLinksNeighbor.max = 'N';
  assert(categoryConcept.childDestinations.length == 1);
  assert(webLinkConcept.childSources.length == 1);
  Neighbor webLinkCategoryNeighbor = new Neighbor(webLinkConcept, categoryConcept, 'category');
  webLinkCategoryNeighbor.id = true;
  webLinkCategoryNeighbor.child = false;
  assert(webLinkConcept.childDestinations.length == 1);
  assert(categoryConcept.childSources.length == 1);
  
  // Data
  
  Entry entry = new Entry(model);
  assert(entry.concepts.length == 1);
  Entities categories = entry.concepts['Category'];
  assert(categories.length == 0);
  
  Entity dartCategory = new Entity.of(categoryConcept);
  assert(dartCategory.attributes.length == 1);
  dartCategory.code = 'Dart';
  dartCategory.attributes['description'] = 'Dart Web language.';
  categories.add(dartCategory);
  assert(categories.length == 1);
  
  Entity html5Category = new Entity.of(categoryConcept);
  html5Category.code = 'HTML5';
  html5Category.attributes['description'] = 'HTML5 is the ubiquitous platform for the web.';
  categories.add(html5Category);
  
  Entities dartWebLinks = dartCategory.children['webLinks'];
  assert(dartWebLinks.length == 0);
  
  Entity dartHomeWebLink = new Entity.of(webLinkConcept);
  assert(dartHomeWebLink.attributes.length == 2);
  dartHomeWebLink.code = 'Dart Home';
  dartHomeWebLink.attributes['url'] = 'http://www.dartlang.org/';
  dartHomeWebLink.attributes['description'] = 'Dart brings structure to web app engineering with a new language, libraries, and tools.';
  dartWebLinks.add(dartHomeWebLink);
  assert(dartWebLinks.length == 1);
  dartHomeWebLink.parents['category'] = dartCategory;
  assert(dartHomeWebLink.parents['category'].code == 'Dart');
  
  Entity tryDartWebLink = new Entity.of(webLinkConcept);
  tryDartWebLink.code = 'Try Dart';
  tryDartWebLink.attributes['url'] = 'http://try.dartlang.org/';
  tryDartWebLink.attributes['description'] = 'Try out the Dart Language from the comfort of your web browser.';
  dartWebLinks.add(tryDartWebLink);
  assert(dartWebLinks.length == 2);
  tryDartWebLink.parents['category'] = dartCategory;
  assert(tryDartWebLink.parents['category'].code == 'Dart');
  
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

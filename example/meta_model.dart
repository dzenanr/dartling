
import 'package:dartling/dartling.dart';

Model createDomainModel() {
  Domain domain = new Domain('CategoryQuestion');
  Model model = new Model(domain, 'Link');
  assert(domain.models.count == 1);

  Concept categoryConcept = new Concept(model, 'Category');
  categoryConcept.description = 'Category of web links.';
  assert(model.concepts.count == 1);
  new Attribute(categoryConcept, 'name').identifier = true;
  new Attribute(categoryConcept, 'description');
  assert(categoryConcept.attributes.count == 2);

  Concept webLinkConcept = new Concept(model, 'WebLink');
  webLinkConcept.entry = false;
  webLinkConcept.description = 'Web links of interest.';
  assert(model.concepts.count == 2);
  new Attribute(webLinkConcept, 'subject').identifier = true;
  new Attribute(webLinkConcept, 'url');
  new Attribute(webLinkConcept, 'description');
  assert(webLinkConcept.attributes.count == 3);

  Child categoryWebLinksNeighbor =
      new Child(categoryConcept, webLinkConcept, 'webLinks');
  Parent webLinkCategoryNeighbor =
      new Parent(webLinkConcept, categoryConcept, 'category');
  webLinkCategoryNeighbor.identifier = true;
  categoryWebLinksNeighbor.opposite = webLinkCategoryNeighbor;
  webLinkCategoryNeighbor.opposite = categoryWebLinksNeighbor;
  assert(categoryConcept.children.count == 1);
  assert(webLinkConcept.parents.count == 1);
  assert(categoryConcept.sourceParents.count == 1);
  assert(webLinkConcept.sourceChildren.count == 1);
  
  return model;
}

createModelData(Model model) {
  var entries = new ModelEntries(model);
  Entities categories = entries.getEntry('Category');
  assert(categories.count == 0);

  ConceptEntity dartCategory = new ConceptEntity.of(categories.concept);
  dartCategory.setAttribute('name', 'Dart');
  dartCategory.setAttribute('description', 'Dart Web language.');
  categories.add(dartCategory);
  assert(categories.count == 1);

  ConceptEntity html5Category = new ConceptEntity.of(categories.concept);
  html5Category.setAttribute('name', 'HTML5');
  html5Category.setAttribute('description',
    'HTML5 is the ubiquitous platform for the web.');
  categories.add(html5Category);

  Entities dartWebLinks = dartCategory.getChild('webLinks');
  assert(dartWebLinks.count == 0);

  ConceptEntity dartHomeWebLink = new ConceptEntity.of(dartWebLinks.concept);
  dartHomeWebLink.setAttribute('subject', 'Dart Home');
  dartHomeWebLink.setAttribute('url', 'http://www.dartlang.org/');
  dartHomeWebLink.setAttribute('description',
    'Dart brings structure to web app engineering with a new language, libraries, and tools.');
  dartHomeWebLink.setParent('category', dartCategory);
  dartWebLinks.add(dartHomeWebLink);
  assert(dartWebLinks.count == 1);
  assert(dartHomeWebLink.getParent('category').getAttribute('name') == 'Dart');

  ConceptEntity tryDartWebLink = new ConceptEntity.of(dartWebLinks.concept);
  tryDartWebLink.setAttribute('subject', 'Try Dart');
  tryDartWebLink.setAttribute('url', 'http://try.dartlang.org/');
  tryDartWebLink.setAttribute('description',
    'Try out the Dart Language from the comfort of your web browser.');
  tryDartWebLink.setParent('category', dartCategory);
  dartWebLinks.add(tryDartWebLink);
  assert(dartWebLinks.count == 2);
  assert(tryDartWebLink.getParent('category').getAttribute('name') == 'Dart');

  // Display
  categories.display(title:'Link Model Creation');
}

void main() {
  var model = createDomainModel();
  createModelData(model);
}

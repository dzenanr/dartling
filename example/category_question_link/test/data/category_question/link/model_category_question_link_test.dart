
// test/data/category_question/link/model_category_question_link_test.dart

//#import("package:unittest/unittest.dart");
//#import("../../../../../../../unittest/unittest.dart");
//#import("dart:json");
//#import("dart:math");
//#import("dart:uri");

#import("package:dartling/dartling.dart");

/*
#source("../../../../../../lib/data/domain/model/event/actions.dart");
#source("../../../../../../lib/data/domain/model/event/reactions.dart");
#source("../../../../../../lib/data/domain/model/exception/errors.dart");
#source("../../../../../../lib/data/domain/model/exception/exceptions.dart");
#source("../../../../../../lib/data/domain/model/transfer/json.dart");
#source("../../../../../../lib/data/domain/model/entities.dart");
#source("../../../../../../lib/data/domain/model/entity.dart");
#source("../../../../../../lib/data/domain/model/entries.dart");
#source("../../../../../../lib/data/domain/model/id.dart");
#source("../../../../../../lib/data/domain/model/oid.dart");
#source("../../../../../../lib/data/domain/models.dart");
#source("../../../../../../lib/data/domain/session.dart");

#source("../../../../../../lib/data/gen/dartling_data.dart");
#source("../../../../../../lib/data/gen/dartling_view.dart");
#source("../../../../../../lib/data/gen/generated.dart");
#source("../../../../../../lib/data/gen/specific.dart");
#source("../../../../../../lib/data/gen/tests.dart");

#source("../../../../../../lib/data/meta/attributes.dart");
#source("../../../../../../lib/data/meta/children.dart");
#source("../../../../../../lib/data/meta/concepts.dart");
#source("../../../../../../lib/data/meta/domains.dart");
#source("../../../../../../lib/data/meta/models.dart");
#source("../../../../../../lib/data/meta/neighbor.dart");
#source("../../../../../../lib/data/meta/parents.dart");
#source("../../../../../../lib/data/meta/property.dart");
#source("../../../../../../lib/data/meta/types.dart");

#source("../../../../../../lib/data/repository.dart");

#source("../../../../src/data/category_question/link/json/data.dart");
#source("../../../../src/data/category_question/link/json/model.dart");

#source("../../../../src/data/category_question/link/init.dart");
#source("../../../../src/data/category_question/link/members.dart");
#source("../../../../src/data/category_question/link/categories.dart");
#source("../../../../src/data/category_question/link/web_links.dart");
#source("../../../../src/data/category_question/link/interests.dart");
#source("../../../../src/data/category_question/link/comments.dart");
#source("../../../../src/data/category_question/link/questions.dart");

#source("../../../../src/data/gen/category_question/link/entries.dart");
#source("../../../../src/data/gen/category_question/link/members.dart");
#source("../../../../src/data/gen/category_question/link/categories.dart");
#source("../../../../src/data/gen/category_question/link/web_links.dart");
#source("../../../../src/data/gen/category_question/link/interests.dart");
#source("../../../../src/data/gen/category_question/link/comments.dart");
#source("../../../../src/data/gen/category_question/link/questions.dart");
#source("../../../../src/data/gen/category_question/models.dart");
#source("../../../../src/data/gen/category_question/repository.dart");
*/

testCategoryQuestionLinkModel() {
  // Meta

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

  // Data

  var entries = new ModelEntries(model);
  Entities categories = entries.getEntry('Category');
  assert(categories.count == 0);

  ConceptEntity dartCategory = new ConceptEntity.of(categoryConcept);
  dartCategory.setAttribute('name', 'Dart');
  dartCategory.setAttribute('description', 'Dart Web language.');
  categories.add(dartCategory);
  assert(categories.count == 1);

  ConceptEntity html5Category = new ConceptEntity.of(categoryConcept);
  html5Category.setAttribute('name', 'HTML5');
  html5Category.setAttribute('description',
    'HTML5 is the ubiquitous platform for the web.');
  categories.add(html5Category);

  Entities dartWebLinks = dartCategory.getChild('webLinks');
  assert(dartWebLinks.count == 0);

  ConceptEntity dartHomeWebLink = new ConceptEntity.of(webLinkConcept);
  dartHomeWebLink.setAttribute('subject', 'Dart Home');
  dartHomeWebLink.setAttribute('url', 'http://www.dartlang.org/');
  dartHomeWebLink.setAttribute('description',
    'Dart brings structure to web app engineering with a new language, libraries, and tools.');
  dartHomeWebLink.setParent('category', dartCategory);
  dartWebLinks.add(dartHomeWebLink);
  assert(dartWebLinks.count == 1);
  assert(dartHomeWebLink.getParent('category').getAttribute('name') == 'Dart');

  ConceptEntity tryDartWebLink = new ConceptEntity.of(webLinkConcept);
  tryDartWebLink.setAttribute('subject', 'Try Dart');
  tryDartWebLink.setAttribute('url', 'http://try.dartlang.org/');
  tryDartWebLink.setAttribute('description',
    'Try out the Dart Language from the comfort of your web browser.');
  tryDartWebLink.setParent('category', dartCategory);
  dartWebLinks.add(tryDartWebLink);
  assert(dartWebLinks.count == 2);
  assert(tryDartWebLink.getParent('category').getAttribute('name') == 'Dart');

  // Display
  categories.display('Link Model Creation');
}

void main() {
  testCategoryQuestionLinkModel();
}


abstract class CategoryGen extends Entity<Category> {

  CategoryGen(Concept concept) : super.of(concept) {
    Concept webLinkConcept = concept.model.concepts.findByCode('WebLink');
    setChild('webLinks', new WebLinks(webLinkConcept));
    Concept interestConcept = concept.model.concepts.findByCode('Interest');
    setChild('interests', new Interests(interestConcept));
    Concept questionConcept = concept.model.concepts.findByCode('Question');
    setChild('questions', new Questions(questionConcept));
  }

  CategoryGen.withId(Concept concept, String name) : super.of(concept) {
    setAttribute('name', name);
    Concept webLinkConcept = concept.model.concepts.findByCode('WebLink');
    setChild('webLinks', new WebLinks(webLinkConcept));
    Concept interestConcept = concept.model.concepts.findByCode('Interest');
    setChild('interests', new Interests(interestConcept));
    Concept questionConcept = concept.model.concepts.findByCode('Question');
    setChild('questions', new Questions(questionConcept));
  }

  String get name() => getAttribute('name');
  set name(String a) => setAttribute('name', a);

  String get description() => getAttribute('description');
  set description(String a) => setAttribute('description', a);

  bool get approved() => getAttribute('approved');
  set approved(bool a) => setAttribute('approved', a);

  WebLinks get webLinks() => getChild('webLinks');
  Interests get interests() => getChild('interests');

  Category newEntity() => new Category(concept);

  /**
   * Compares two categories based on name.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareName(Category other) {
    return name.compareTo(other.name);
  }

}

abstract class CategoriesGen extends Entities<Category> {

  CategoriesGen(Concept concept) : super.of(concept);

  Categories newEntities() => new Categories(concept);

}




class Category extends CategoryGen {

  Category(Concept concept) : super(concept);

  Category.withId(Concept concept, String name) : super(concept) {
    setAttribute('name', name);
    Concept webLinkConcept = concept.model.concepts.findByCode('WebLink');
    setChild('webLinks', new WebLinks(webLinkConcept));
    Concept interestConcept = concept.model.concepts.findByCode('Interest');
    setChild('interests', new Interests(interestConcept));
  }

}

class Categories extends CategoriesGen {

  Categories(Concept concept) : super(concept);

}


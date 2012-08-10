
class Category extends CategoryGen {

  Category(Concept concept) : super(concept);

  Category.withId(Concept concept, String name) : super(concept) {
    setAttribute('name', name);
    Concept webLinkConcept = concept.model.concepts.findByCode('WebLink');
    setChild('webLinks', new WebLinks(webLinkConcept));
  }

}

class Categories extends CategoriesGen {

  Categories(Concept concept) : super(concept);

}



class Category extends Entity<Category> {

  Category(Concept concept) : super.of(concept) {
    Concept webLinkConcept = concept.model.concepts.getEntityByCode('WebLink');
    setChild('webLinks', new WebLinks(webLinkConcept));
  }
  
  Category.withId(Concept concept, String name) : super.of(concept) {
    setAttribute('name', name);
    Concept webLinkConcept = concept.model.concepts.getEntityByCode('WebLink');
    setChild('webLinks', new WebLinks(webLinkConcept));
  }

  String get name() => getAttribute('name');
  set name(String a) => setAttribute('name', a);

  String get description() => getAttribute('description');
  set description(String a) => setAttribute('description', a);

  WebLinks get webLinks() => getChild('webLinks');
  
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

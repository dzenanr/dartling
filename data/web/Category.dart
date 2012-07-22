
class Category extends Entity<Category> {

  Category(Concept concept) : super.of(concept) {
    Concept webLinkConcept = concept.model.concepts.getEntity('WebLink');
    setChild('webLinks', new WebLinks(webLinkConcept));
  }

  String get description() => getAttribute('description');
  set description(String a) => setAttribute('description', a);

  WebLinks get webLinks() => getChild('webLinks');

}

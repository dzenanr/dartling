
class Category extends Entity<Category> {

  Category(Concept concept) : super.of(concept) {
    Concept webLinkConcept = concept.model.concepts.getEntity('WebLink');
    setChild('webLinks', new WebLinks(webLinkConcept));
  }

  String get description() => getAttribute('description');
  set description(String d) => setAttribute('description', d);

  WebLinks get webLinks() => getChild('webLinks');

}

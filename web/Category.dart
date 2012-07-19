
class Category extends Entity<Category> {
  
  Category(Concept concept) : super.of(concept) {
    Concept webLinkConcept = concept.model.concepts.getEntity('WebLink');
    childMap['webLinks'] = new WebLinks(webLinkConcept);
  }
  
  String get description() => attributeMap['description'];  
  set description(String d) => attributeMap['description'] = d;
  
  WebLinks get webLinks() => childMap['webLinks'];  
  
}

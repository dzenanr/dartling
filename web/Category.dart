
class Category extends Entity<Category> {
  
  Category(Concept concept) : super.of(concept) {
    Concept webLinkConcept = concept.parentModel.childConcepts.getEntity('WebLink');
    children['webLinks'] = new WebLinks(webLinkConcept);
  }
  
  String get description() => attributes['description'];  
  set description(String d) => attributes['description'] = d;
  
  WebLinks get webLinks() => children['webLinks'];  
  
}

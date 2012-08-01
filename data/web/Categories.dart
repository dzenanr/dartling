
class Categories extends Entities<Category> {
  
  Categories(Concept concept) : super.of(concept);
  
  Categories newEntities() => new Categories(concept);
  
}

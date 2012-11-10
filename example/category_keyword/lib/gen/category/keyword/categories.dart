part of category_keyword;

// data/gen/category/keyword/categories.dart

abstract class CategoryGen extends ConceptEntity<Category> {

  CategoryGen(Concept concept) : super.of(concept) {
    Concept categoryConcept = concept.model.concepts.findByCode("Category");
    setChild("categories", new Categories(categoryConcept));
    Concept tagConcept = concept.model.concepts.findByCode("Tag");
    setChild("tags", new Tags(tagConcept));
  }

  CategoryGen.withId(Concept concept, String namePath) : super.of(concept) {
    setAttribute("namePath", namePath);
    Concept categoryConcept = concept.model.concepts.findByCode("Category");
    setChild("categories", new Categories(categoryConcept));
    Concept tagConcept = concept.model.concepts.findByCode("Tag");
    setChild("tags", new Tags(tagConcept));
  }

  Category get category => getParent("category");
  set category(Category p) => setParent("category", p);

  String get name => getAttribute("name");
  set name(String a) => setAttribute("name", a);

  String get namePath => getAttribute("namePath");
  set namePath(String a) => setAttribute("namePath", a);

  Categories get categories => getChild("categories");

  Tags get tags => getChild("tags");

  Category newEntity() => new Category(concept);

  int namePathCompareTo(Category other) {
    return namePath.compareTo(other.namePath);
  }

}

abstract class CategoriesGen extends Entities<Category> {

  CategoriesGen(Concept concept) : super.of(concept);

  Categories newEntities() => new Categories(concept);

}
part of category_keyword; 
 
// lib/gen/category/keyword/categories.dart 
 
abstract class CategoryGen extends ConceptEntity<Category> { 
 
  CategoryGen(Concept concept) { 
    this.concept = concept;
    Concept categoryConcept = concept.model.concepts.singleWhereCode("Category"); 
    setChild("categories", new Categories(categoryConcept)); 
    Concept tagConcept = concept.model.concepts.singleWhereCode("Tag"); 
    setChild("tags", new Tags(tagConcept)); 
  } 
 
  CategoryGen.withId(Concept concept, String namePath) { 
    this.concept = concept;
    setAttribute("namePath", namePath); 
    Concept categoryConcept = concept.model.concepts.singleWhereCode("Category"); 
    setChild("categories", new Categories(categoryConcept)); 
    Concept tagConcept = concept.model.concepts.singleWhereCode("Tag"); 
    setChild("tags", new Tags(tagConcept)); 
  } 
 
  Reference get categoryReference => getReference("category"); 
  set categoryReference(Reference reference) => setReference("category", reference); 
  
  Category get category => getParent("category"); 
  set category(Category p) => setParent("category", p); 
  
  String get name => getAttribute("name"); 
  set name(String a) => setAttribute("name", a); 
  
  String get namePath => getAttribute("namePath"); 
  set namePath(String a) => setAttribute("namePath", a); 
  
  Categories get categories => getChild("categories"); 
  
  Tags get tags => getChild("tags"); 
  
  Category newEntity() => new Category(concept); 
  Categories newEntities() => new Categories(concept); 
  
  int namePathCompareTo(Category other) { 
    return namePath.compareTo(other.namePath); 
  } 
 
} 
 
abstract class CategoriesGen extends Entities<Category> { 
 
  CategoriesGen(Concept concept) {
    this.concept = concept;
  }
 
  Categories newEntities() => new Categories(concept); 
  Category newEntity() => new Category(concept); 
  
} 
 

part of category_keyword; 
 
// lib/gen/category/keyword/tags.dart 
 
abstract class TagGen extends ConceptEntity<Tag> { 
 
  TagGen(Concept concept) {
    this.concept = concept;
  }
 
  TagGen.withId(Concept concept, Keyword keyword, Category category) { 
    this.concept = concept;
    setParent("keyword", keyword); 
    setParent("category", category); 
  } 
 
  Reference get keywordReference => getReference("keyword"); 
  void set keywordReference(Reference reference) { setReference("keyword", reference); }
  
  Keyword get keyword => getParent("keyword"); 
  void set keyword(Keyword p) { setParent("keyword", p); }
  
  Reference get categoryReference => getReference("category"); 
  void set categoryReference(Reference reference) { setReference("category", reference); }
  
  Category get category => getParent("category"); 
  void set category(Category p) { setParent("category", p); }
  
  Tag newEntity() => new Tag(concept); 
  Tags newEntities() => new Tags(concept); 
  
} 
 
abstract class TagsGen extends Entities<Tag> { 
 
  TagsGen(Concept concept) {
    this.concept = concept;
  }
 
  Tags newEntities() => new Tags(concept); 
  Tag newEntity() => new Tag(concept); 
  
} 
 

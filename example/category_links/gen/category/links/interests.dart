part of category_links; 
 
// lib/gen/category/links/interests.dart 
 
abstract class InterestGen extends ConceptEntity<Interest> { 
 
  InterestGen(Concept concept) {
    this.concept = concept;
  }
 
  InterestGen.withId(Concept concept, Category category, Member member) { 
    this.concept = concept;
    setParent("category", category); 
    setParent("member", member); 
  } 
 
  Reference get categoryReference => getReference("category"); 
  void set categoryReference(Reference reference) { setReference("category", reference); }
  
  Category get category => getParent("category"); 
  void set category(Category p) { setParent("category", p); }
  
  Reference get memberReference => getReference("member"); 
  void set memberReference(Reference reference) { setReference("member", reference); }
  
  Member get member => getParent("member"); 
  void set member(Member p) { setParent("member", p); }
  
  String get description => getAttribute("description"); 
  void set description(String a) { setAttribute("description", a); }
  
  Interest newEntity() => new Interest(concept); 
  Interests newEntities() => new Interests(concept); 
  
} 
 
abstract class InterestsGen extends Entities<Interest> { 
 
  InterestsGen(Concept concept) {
    this.concept = concept;
  }
 
  Interests newEntities() => new Interests(concept); 
  Interest newEntity() => new Interest(concept); 
  
} 
 

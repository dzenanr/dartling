part of category_links; 
 
// lib/gen/category/links/questions.dart 
 
abstract class QuestionGen extends ConceptEntity<Question> { 
 
  QuestionGen(Concept concept) {
    this.concept = concept;
  }
 
  QuestionGen.withId(Concept concept, int number) { 
    this.concept = concept;
    setAttribute("number", number); 
  } 
 
  Reference get categoryReference => getReference("category"); 
  void set categoryReference(Reference reference) { setReference("category", reference); }
  
  Category get category => getParent("category"); 
  void set category(Category p) { setParent("category", p); }
  
  int get number => getAttribute("number"); 
  void set number(int a) { setAttribute("number", a); } 
  
  String get type => getAttribute("type"); 
  void set type(String a) { setAttribute("type", a); }
  
  String get text => getAttribute("text"); 
  void set text(String a) { setAttribute("text", a); }
  
  String get response => getAttribute("response"); 
  set response(String a) { setAttribute("response", a); }
  
  String get createdOn => getAttribute("createdOn"); 
  void set createdOn(String a) { setAttribute("createdOn", a); }
  
  num get points => getAttribute("points"); 
  void set points(num a) { setAttribute("points", a); }
  
  Question newEntity() => new Question(concept); 
  Questions newEntities() => new Questions(concept); 
  
  int numberCompareTo(Question other) { 
    return number.compareTo(other.number); 
  } 
 
} 
 
abstract class QuestionsGen extends Entities<Question> { 
 
  QuestionsGen(Concept concept) {
    this.concept = concept;
  }
 
  Questions newEntities() => new Questions(concept); 
  Question newEntity() => new Question(concept); 
  
} 
 

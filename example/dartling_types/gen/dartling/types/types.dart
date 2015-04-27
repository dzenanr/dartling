part of dartling_types; 
 
// lib/gen/dartling/types/types.dart 
 
abstract class TypeGen extends ConceptEntity<Type> { 
 
  TypeGen(Concept concept) {
    this.concept = concept;
  }
 
  TypeGen.withId(Concept concept, int sequence) { 
    this.concept = concept;
    setAttribute("sequence", sequence); 
  } 
 
  int get sequence => getAttribute("sequence"); 
  set sequence(int a) => setAttribute("sequence", a); 
  
  String get title => getAttribute("title"); 
  set title(String a) => setAttribute("title", a); 
  
  String get email => getAttribute("email"); 
  set email(String a) => setAttribute("email", a); 
  
  DateTime get started => getAttribute("started"); 
  set started(DateTime a) => setAttribute("started", a); 
  
  double get price => getAttribute("price"); 
  set price(double a) => setAttribute("price", a); 
  
  num get qty => getAttribute("qty"); 
  set qty(num a) => setAttribute("qty", a); 
  
  bool get completed => getAttribute("completed"); 
  set completed(bool a) => setAttribute("completed", a); 
  
  dynamic get whatever => getAttribute("whatever"); 
  set whatever(dynamic a) => setAttribute("whatever", a); 
  
  Uri get web => getAttribute("web"); 
  set web(Uri a) => setAttribute("web", a); 
  
  dynamic get other => getAttribute("other"); 
  set other(dynamic a) => setAttribute("other", a); 
  
  String get note => getAttribute("note"); 
  set note(String a) => setAttribute("note", a); 
  
  Type newEntity() => new Type(concept); 
  Types newEntities() => new Types(concept); 
  
  int sequenceCompareTo(Type other) { 
    return sequence.compareTo(other.sequence); 
  } 
 
} 
 
abstract class TypesGen extends Entities<Type> { 
 
  TypesGen(Concept concept) {
    this.concept = concept;
  }
 
  Types newEntities() => new Types(concept); 
  Type newEntity() => new Type(concept); 
  
} 
 

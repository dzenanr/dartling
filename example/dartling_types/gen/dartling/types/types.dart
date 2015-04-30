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
  void set sequence(int a) { setAttribute("sequence", a); }
  
  String get title => getAttribute("title"); 
  void set title(String a) { setAttribute("title", a); }
  
  String get email => getAttribute("email"); 
  void set email(String a) { setAttribute("email", a); }
  
  DateTime get started => getAttribute("started"); 
  void set started(DateTime a) { setAttribute("started", a); }
  
  double get price => getAttribute("price"); 
  void set price(double a) { setAttribute("price", a); }
  
  num get qty => getAttribute("qty"); 
  void set qty(num a) { setAttribute("qty", a); }
  
  bool get completed => getAttribute("completed"); 
  void set completed(bool a) { setAttribute("completed", a); }
  
  dynamic get whatever => getAttribute("whatever"); 
  void set whatever(dynamic a) { setAttribute("whatever", a); }
  
  Uri get web => getAttribute("web"); 
  void set web(Uri a) { setAttribute("web", a); }
  
  dynamic get other => getAttribute("other"); 
  void set other(dynamic a) { setAttribute("other", a); }
  
  String get note => getAttribute("note"); 
  void set note(String a) { setAttribute("note", a); }
  
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
 

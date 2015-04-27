part of category_links; 
 
// lib/gen/category/links/members.dart 
 
abstract class MemberGen extends ConceptEntity<Member> { 
 
  MemberGen(Concept concept) { 
    this.concept = concept;
    Concept interestConcept = concept.model.concepts.singleWhereCode("Interest"); 
    setChild("interests", new Interests(interestConcept)); 
  } 
 
  MemberGen.withId(Concept concept, String email) { 
    this.concept = concept;
    setAttribute("email", email); 
    Concept interestConcept = concept.model.concepts.singleWhereCode("Interest"); 
    setChild("interests", new Interests(interestConcept)); 
  } 
 
  String get email => getAttribute("email"); 
  set email(String a) => setAttribute("email", a); 
  
  String get firstName => getAttribute("firstName"); 
  set firstName(String a) => setAttribute("firstName", a); 
  
  String get lastName => getAttribute("lastName"); 
  set lastName(String a) => setAttribute("lastName", a); 
  
  DateTime get startedOn => getAttribute("startedOn"); 
  set startedOn(DateTime a) => setAttribute("startedOn", a); 
  
  bool get receiveEmail => getAttribute("receiveEmail"); 
  set receiveEmail(bool a) => setAttribute("receiveEmail", a); 
  
  String get password => getAttribute("password"); 
  set password(String a) => setAttribute("password", a); 
  
  String get role => getAttribute("role"); 
  set role(String a) => setAttribute("role", a); 
  
  num get karma => getAttribute("karma"); 
  set karma(num a) => setAttribute("karma", a); 
  
  String get about => getAttribute("about"); 
  set about(String a) => setAttribute("about", a); 
  
  Interests get interests => getChild("interests"); 
  
  Member newEntity() => new Member(concept); 
  Members newEntities() => new Members(concept); 
  
  int emailCompareTo(Member other) { 
    return email.compareTo(other.email); 
  } 
 
} 
 
abstract class MembersGen extends Entities<Member> { 
 
  MembersGen(Concept concept) {
    this.concept = concept;
  }
 
  Members newEntities() => new Members(concept); 
  Member newEntity() => new Member(concept); 
  
} 
 

part of category_links; 
 
// lib/gen/category/links/web_links.dart 
 
abstract class WebLinkGen extends ConceptEntity<WebLink> { 
 
  WebLinkGen(Concept concept) {
    this.concept = concept;
  }
 
  WebLinkGen.withId(Concept concept, Category category, String subject) { 
    this.concept = concept;
    setParent("category", category); 
    setAttribute("subject", subject); 
  } 
 
  Reference get categoryReference => getReference("category"); 
  set categoryReference(Reference reference) => setReference("category", reference); 
  
  Category get category => getParent("category"); 
  set category(Category p) => setParent("category", p); 
  
  String get subject => getAttribute("subject"); 
  set subject(String a) => setAttribute("subject", a); 
  
  Uri get url => getAttribute("url"); 
  set url(Uri a) => setAttribute("url", a); 
  
  String get description => getAttribute("description"); 
  set description(String a) => setAttribute("description", a); 
  
  DateTime get createdOn => getAttribute("createdOn"); 
  set createdOn(DateTime a) => setAttribute("createdOn", a); 
  
  DateTime get updatedOn => getAttribute("updatedOn"); 
  set updatedOn(DateTime a) => setAttribute("updatedOn", a); 
  
  bool get approved => getAttribute("approved"); 
  set approved(bool a) => setAttribute("approved", a); 
  
  WebLink newEntity() => new WebLink(concept); 
  WebLinks newEntities() => new WebLinks(concept); 
  
  int subjectCompareTo(WebLink other) { 
    return subject.compareTo(other.subject); 
  } 
 
} 
 
abstract class WebLinksGen extends Entities<WebLink> { 
 
  WebLinksGen(Concept concept) {
    this.concept = concept;
  }
 
  WebLinks newEntities() => new WebLinks(concept); 
  WebLink newEntity() => new WebLink(concept); 
  
} 
 

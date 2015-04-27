part of category_links; 
 
// lib/category/links/web_links.dart 
 
class WebLink extends WebLinkGen { 
 
  WebLink(Concept concept) : super(concept); 
 
  WebLink.withId(Concept concept, Category category, String subject) : 
    super.withId(concept, category, subject); 
 
  // added after code gen - begin 
 
  set description(String a) {
    var before = description;
    super.description = a;
    if (before != null) {
      updatedOn = new DateTime.now();
    }
  }

  set approved(bool a) {
    super.approved = a;
    if (approved) {
      updatedOn = new DateTime.now();
    }
  }
  
  // added after code gen - end 
 
} 
 
class WebLinks extends WebLinksGen { 
 
  WebLinks(Concept concept) : super(concept); 
 
  // added after code gen - begin 
 
  // added after code gen - end 
 
} 
 

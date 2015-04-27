part of category_links; 
 
// lib/gen/category/links/comments.dart 
 
abstract class CommentGen extends ConceptEntity<Comment> { 
 
  CommentGen(Concept concept) {
    this.concept = concept;
  }
 
  String get text => getAttribute("text"); 
  set text(String a) => setAttribute("text", a); 
  
  String get source => getAttribute("source"); 
  set source(String a) => setAttribute("source", a); 
  
  DateTime get createdOn => getAttribute("createdOn"); 
  set createdOn(DateTime a) => setAttribute("createdOn", a); 
  
  Comment newEntity() => new Comment(concept); 
  Comments newEntities() => new Comments(concept); 
  
} 
 
abstract class CommentsGen extends Entities<Comment> { 
 
  CommentsGen(Concept concept) {
    this.concept = concept;
  }
 
  Comments newEntities() => new Comments(concept); 
  Comment newEntity() => new Comment(concept); 
  
} 
 

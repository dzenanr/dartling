//part of category_question_link;

// data/gen/category_question/link/comments.dart

abstract class CommentGen extends ConceptEntity<Comment> {

  CommentGen(Concept concept) : super.of(concept);

  String get text => getAttribute("text");
  set text(String a) => setAttribute("text", a);

  String get source => getAttribute("source");
  set source(String a) => setAttribute("source", a);

  Date get createdOn => getAttribute("createdOn");
  set createdOn(Date a) => setAttribute("createdOn", a);

  Comment newEntity() => new Comment(concept);

}

abstract class CommentsGen extends Entities<Comment> {

  CommentsGen(Concept concept) : super.of(concept);

  Comments newEntities() => new Comments(concept);

}


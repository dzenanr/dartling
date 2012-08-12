
abstract class CommentGen extends Entity<Comment> {

  CommentGen(Concept concept) : super.of(concept);

  String get text() => getAttribute('text');
  set text(String a) => setAttribute('text', a);

  String get source() => getAttribute('source');
  set source(String a) => setAttribute('source', a);

  Date get createdOn() => getAttribute('createdOn');
  set createdOn(Date a) => setAttribute('createdOn', a);

  Comment newEntity() => new Comment(concept);

  bool get onDart() =>
      text.contains('Dart') ? true : false;

  /**
   * Compares two projects based on createdOn.
   * If the result is less than 0 then the first entity is greater than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is lower than the second.
   */
  int compareCreatedOn(Comment other) {
    return -createdOn.compareTo(other.createdOn);
  }

}

abstract class CommentsGen extends Entities<Comment> {

  CommentsGen(Concept concept) : super.of(concept);

  Comments newEntities() => new Comments(concept);

}



abstract class WebLinkGen extends ConceptEntity<WebLink> {

  WebLinkGen(Concept concept) : super.of(concept);

  WebLinkGen.withId(
      Concept concept, Category category, String name) : super.of(concept) {
    setParent('category', category);
    setAttribute('name', name);
  }

  Category get category() => getParent('category');
  set category(Category p) => setParent('category', p);

  String get subject() => getAttribute('subject');
  set subject(String a) => setAttribute('subject', a);

  Uri get url() => getAttribute('url');
  set url(Uri a) => setAttribute('url', a);

  String get description() => getAttribute('description');
  set description(String a) => setAttribute('description', a);

  Date get createdOn() => getAttribute('createdOn');
  set createdOn(Date a) => setAttribute('createdOn', a);

  Date get updatedOn() => getAttribute('updatedOn');
  set updatedOn(Date a) => setAttribute('updatedOn', a);

  bool get approved() => getAttribute('approved');
  set approved(bool a) => setAttribute('approved', a);

  WebLink newEntity() => new WebLink(concept);

  /**
   * Compares two web links based on subject.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(WebLink other) {
    return subject.compareTo(other.subject);
  }

}

abstract class WebLinksGen extends Entities<WebLink> {

  WebLinksGen(Concept concept) : super.of(concept);

  WebLinks newEntities() => new WebLinks(concept);

}




class WebLinks extends Entities<WebLink> {

  WebLinks(Concept concept) : super.of(concept);

  WebLinks newEntities() => new WebLinks(concept);

}

class WebLink extends Entity<WebLink> {

  WebLink(Concept concept) : super.of(concept);

  WebLink.withId(
      Concept concept, Category category, String name) : super.of(concept) {
    setParent('category', category);
    setAttribute('name', name);
  }

  Category get category() => getParent('category');
  set category(Category p) => setParent('category', p);

  String get name() => getAttribute('name');
  set name(String a) => setAttribute('name', a);

  Uri get url() => getAttribute('url');
  set url(Uri a) => setAttribute('url', a);

  String get description() => getAttribute('description');
  set description(String a) => setAttribute('description', a);

  WebLink newEntity() => new WebLink(concept);

  /**
   * Compares two web links based on name.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(WebLink other) {
    return name.compareTo(other.name);
  }

}

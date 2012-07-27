
class WebLink extends Entity<WebLink> {

  WebLink(Concept concept) : super.of(concept);

  String get name() => getAttribute('name');
  set name(String a) => setAttribute('name', a);

  String get url() => getAttribute('url');
  set url(String a) => setAttribute('url', a);

  String get description() => getAttribute('description');
  set description(String a) => setAttribute('description', a);

  Category get category() => getParent('category');
  set category(Category p) => setParent('category', p);

  /**
   * Compares two entities based on the names.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(WebLink other) {
    return name.compareTo(other.name);
  }

}

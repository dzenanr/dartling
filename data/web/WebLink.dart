
class WebLink extends Entity<WebLink> {

  WebLink(Concept concept) : super.of(concept);

  String get url() => getAttribute('url');
  set url(String a) => setAttribute('url', a);

  String get description() => getAttribute('description');
  set description(String a) => setAttribute('description', a);

  Category get category() => getParent('category');
  set category(Category a) => setParent('category', a);

}

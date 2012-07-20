
class WebLink extends Entity<WebLink> {

  WebLink(Concept concept) : super.of(concept);

  String get url() => getAttribute('url');
  set url(String u) => setAttribute('url', u);

  String get description() => getAttribute('description');
  set description(String d) => setAttribute('description', d);

  Category get category() => getParent('category');
  set category(Category c) => setParent('category', c);

}

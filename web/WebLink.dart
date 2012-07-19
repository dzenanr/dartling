
class WebLink extends Entity<WebLink> {

  WebLink(Concept concept) : super.of(concept);

  String get url() => attributeMap['url'];
  set url(String u) => attributeMap['url'] = u;

  String get description() => attributeMap['description'];
  set description(String d) => attributeMap['description'] = d;

  Category get category() => parentMap['category'];
  set category(Category c) => parentMap['category'] = c;

}

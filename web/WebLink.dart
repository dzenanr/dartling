
class WebLink extends Entity<WebLink> {
  
  WebLink(Concept concept) : super.of(concept);
  
  String get url() => attributes['url'];  
  set url(String u) => attributes['url'] = u;
  
  String get description() => attributes['description'];  
  set description(String d) => attributes['description'] = d;
  
  Category get category() => parents['category'];  
  set category(Category c) => parents['category'] = c;
  
}

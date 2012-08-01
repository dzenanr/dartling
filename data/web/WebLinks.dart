
class WebLinks extends Entities<WebLink> {
  
  WebLinks(Concept concept) : super.of(concept);
  
  WebLinks newEntities() => new WebLinks(concept);
  
}

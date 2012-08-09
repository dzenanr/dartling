
class WebLink extends WebLinkGen {

  WebLink(Concept concept) : super(concept);

  WebLink.withId(
      Concept concept, Category category, String name) : super(concept) {
    setParent('category', category);
    setAttribute('name', name);
  }

}

class WebLinks extends WebLinksGen {

  WebLinks(Concept concept) : super(concept);

}


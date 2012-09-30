
// data/category_question/link/web_links.dart

class WebLink extends WebLinkGen {

  WebLink(Concept concept) : super(concept);

  WebLink.withId(Concept concept, Category category, String subject) :
    super.withId(concept, category, subject);

  set description(String a) {
    var before = description;
    super.description = a;
    if (before != null) {
      updatedOn = new Date.now();
    }
  }

  set approved(bool a) {
    super.approved = a;
    if (approved) {
      updatedOn = new Date.now();
    }
  }

}

class WebLinks extends WebLinksGen {

  WebLinks(Concept concept) : super(concept);

}



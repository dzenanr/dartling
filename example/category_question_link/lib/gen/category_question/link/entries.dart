//part of category_question_link;

// data/gen/category_question/link/entries.dart

class LinkEntries extends ModelEntries {

  LinkEntries(Model model) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept;
    concept = model.concepts.findByCode("Member");
    entries["Member"] = new Members(concept);
    concept = model.concepts.findByCode("Category");
    entries["Category"] = new Categories(concept);
    concept = model.concepts.findByCode("Comment");
    entries["Comment"] = new Comments(concept);
    concept = model.concepts.findByCode("Question");
    entries["Question"] = new Questions(concept);
    return entries;
  }

  Entities newEntities(String conceptCode) {
    var concept = model.concepts.findByCode(conceptCode);
    if (concept == null) {
      throw new ConceptException("${conceptCode} concept does not exist.") ;
    }
    if (concept.code == "Member") {
      return new Members(concept);
    }
    if (concept.code == "Category") {
      return new Categories(concept);
    }
    if (concept.code == "WebLink") {
      return new WebLinks(concept);
    }
    if (concept.code == "Interest") {
      return new Interests(concept);
    }
    if (concept.code == "Comment") {
      return new Comments(concept);
    }
    if (concept.code == "Question") {
      return new Questions(concept);
    }
  }

  ConceptEntity newEntity(String conceptCode) {
    var concept = model.concepts.findByCode(conceptCode);
    if (concept == null) {
      throw new ConceptException("${conceptCode} concept does not exist.") ;
    }
    if (concept.code == "Member") {
      return new Member(concept);
    }
    if (concept.code == "Category") {
      return new Category(concept);
    }
    if (concept.code == "WebLink") {
      return new WebLink(concept);
    }
    if (concept.code == "Interest") {
      return new Interest(concept);
    }
    if (concept.code == "Comment") {
      return new Comment(concept);
    }
    if (concept.code == "Question") {
      return new Question(concept);
    }
  }

  fromJsonToData() {
    fromJson(categoryQuestionLinkDataJson);
  }

  Members get members => getEntry("Member");
  Categories get categories => getEntry("Category");
  Comments get comments => getEntry("Comment");
  Questions get questions => getEntry("Question");

}


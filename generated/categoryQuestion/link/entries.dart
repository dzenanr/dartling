
class LinkEntries extends ModelEntries {

  LinkEntries(Model model) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept = model.concepts.findByCode('Category');
    if (concept.entry) {
      entries[concept.code] = new Categories(concept);
    }
    concept = model.concepts.findByCode('Member');
    if (concept.entry) {
      entries[concept.code] = new Members(concept);
    }
    concept = model.concepts.findByCode('Comment');
    if (concept.entry) {
      entries[concept.code] = new Comments(concept);
    }
    concept = model.concepts.findByCode('Question');
    if (concept.entry) {
      entries[concept.code] = new Questions(concept);
    }
    return entries;
  }

  Entities newEntities(String conceptCode) {
    var concept = model.concepts.findByCode(conceptCode);
    if (concept.code == 'Category') {
      return new Categories(concept);
    } else if (concept.code == 'Comment') {
      return new Comments(concept);
    } else if (concept.code == 'Member') {
      return new Members(concept);
    } else if (concept.code == 'Question') {
      return new Questions(concept);
    } else if (concept.code == 'Interest') {
      return new Interests(concept);
    } else if (concept.code == 'WebLink') {
      return new WebLinks(concept);
    } else {
      throw new ConceptException('${concept.code} concept does not exist.');
    }
    /*
    if (!concept.entry) {
      if (concept.code == 'Interests') {
        return  new Interests(concept);
      } else if (concept.code == 'WebLink') {
        return  new WebLinks(concept);
      }
    }
    */
  }

  Entity newEntity(String conceptCode) {
    var concept = model.concepts.findByCode(conceptCode);
    if (concept.code == 'Category') {
      return new Category(concept);
    } else if (concept.code == 'Comment') {
      return new Comment(concept);
    } else if (concept.code == 'Member') {
      return new Member(concept);
    } else if (concept.code == 'Question') {
      return new Question(concept);
    } else if (concept.code == 'Interest') {
      return new Interest(concept);
    } else if (concept.code == 'WebLink') {
      return new WebLink(concept);
    } else {
      throw new ConceptException('${concept.code} concept does not exist.');
    }
  }

  fromJsonToData() {
    fromJson(categoryQuestionLinkDataInJson);
  }

  Categories get categories() => getEntry('Category');
  Comments get comments() => getEntry('Comment');
  Members get members() => getEntry('Member');
  Questions get questions() => getEntry('Question');

  Concept get categoryConcept() => categories.concept;
  Concept get memberConcept() => members.concept;
  Concept get commentConcept() => comments.concept;
  Concept get questionConcept() => questions.concept;

  Concept get interestConcept() => model.concepts.findByCode('Interest');
  Concept get webLinkConcept() => model.concepts.findByCode('WebLink');

}







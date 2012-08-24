
class LinkEntries extends ModelEntries {

  LinkEntries(Model model) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept = model.concepts.findByCode('Category');
    entries[concept.code] = new Categories(concept);
    concept = model.concepts.findByCode('Member');
    entries[concept.code] = new Members(concept);
    concept = model.concepts.findByCode('Comment');
    entries[concept.code] = new Comments(concept);
    concept = model.concepts.findByCode('Question');
    entries[concept.code] = new Questions(concept);
    return entries;
  }

  Entities newEntities(String conceptCode) {
    var concept = model.concepts.findByCode(conceptCode);
    if (concept == null) {
      throw new ConceptException('${conceptCode} concept does not exist.');
    }
    if (concept.code == 'Category') {
      return new Categories(concept);
    }
    if (concept.code == 'Comment') {
      return new Comments(concept);
    }
    if (concept.code == 'Member') {
      return new Members(concept);
    }
    if (concept.code == 'Question') {
      return new Questions(concept);
    }
    if (concept.code == 'Interest') {
      return new Interests(concept);
    }
    if (concept.code == 'WebLink') {
      return new WebLinks(concept);
    }
  }

  ConceptEntity newEntity(String conceptCode) {
    var concept = model.concepts.findByCode(conceptCode);
    if (concept == null) {
      throw new ConceptException('${conceptCode} concept does not exist.');
    }
    if (concept.code == 'Category') {
      return new Category(concept);
    }
    if (concept.code == 'Comment') {
      return new Comment(concept);
    }
    if (concept.code == 'Member') {
      return new Member(concept);
    }
    if (concept.code == 'Question') {
      return new Question(concept);
    }
    if (concept.code == 'Interest') {
      return new Interest(concept);
    }
    if (concept.code == 'WebLink') {
      return new WebLink(concept);
    }
  }

  fromJsonToData() {
    fromJson(categoryquestionLinkDataInJson);
  }

  Categories get categories() => getEntry('Category');
  Comments get comments() => getEntry('Comment');
  Members get members() => getEntry('Member');
  Questions get questions() => getEntry('Question');

}







//part of category_keyword;

// data/gen/category/keyword/entries.dart

class KeywordEntries extends ModelEntries {

  KeywordEntries(Model model) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept;
    concept = model.concepts.findByCode("Category");
    entries["Category"] = new Categories(concept);
    concept = model.concepts.findByCode("Keyword");
    entries["Keyword"] = new Keywords(concept);
    return entries;
  }

  Entities newEntities(String conceptCode) {
    var concept = model.concepts.findByCode(conceptCode);
    if (concept == null) {
      throw new ConceptException("${conceptCode} concept does not exist.") ;
    }
    if (concept.code == "Category") {
      return new Categories(concept);
    }
    if (concept.code == "Keyword") {
      return new Keywords(concept);
    }
    if (concept.code == "Tag") {
      return new Tags(concept);
    }
  }

  ConceptEntity newEntity(String conceptCode) {
    var concept = model.concepts.findByCode(conceptCode);
    if (concept == null) {
      throw new ConceptException("${conceptCode} concept does not exist.") ;
    }
    if (concept.code == "Category") {
      return new Category(concept);
    }
    if (concept.code == "Keyword") {
      return new Keyword(concept);
    }
    if (concept.code == "Tag") {
      return new Tag(concept);
    }
  }

  fromJsonToData() {
    fromJson(categoryKeywordDataJson);
  }

  Categories get categories => getEntry("Category");
  Keywords get keywords => getEntry("Keyword");

}

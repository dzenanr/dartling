//part of category_keyword;

// data/gen/category/keyword/keywords.dart

abstract class KeywordGen extends ConceptEntity<Keyword> {

  KeywordGen(Concept concept) : super.of(concept) {
    Concept tagConcept = concept.model.concepts.findByCode("Tag");
    setChild("tags", new Tags(tagConcept));
  }

  KeywordGen.withId(Concept concept, String word) : super.of(concept) {
    setAttribute("word", word);
    Concept tagConcept = concept.model.concepts.findByCode("Tag");
    setChild("tags", new Tags(tagConcept));
  }

  String get word => getAttribute("word");
  set word(String a) => setAttribute("word", a);

  Tags get tags => getChild("tags");

  Keyword newEntity() => new Keyword(concept);

  int wordCompareTo(Keyword other) {
    return word.compareTo(other.word);
  }

}

abstract class KeywordsGen extends Entities<Keyword> {

  KeywordsGen(Concept concept) : super.of(concept);

  Keywords newEntities() => new Keywords(concept);

}


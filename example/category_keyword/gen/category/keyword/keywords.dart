part of category_keyword; 
 
// lib/gen/category/keyword/keywords.dart 
 
abstract class KeywordGen extends ConceptEntity<Keyword> { 
 
  KeywordGen(Concept concept) { 
    this.concept = concept;
    Concept tagConcept = concept.model.concepts.singleWhereCode("Tag"); 
    setChild("tags", new Tags(tagConcept)); 
  } 
 
  KeywordGen.withId(Concept concept, String word) { 
    this.concept = concept;
    setAttribute("word", word); 
    Concept tagConcept = concept.model.concepts.singleWhereCode("Tag"); 
    setChild("tags", new Tags(tagConcept)); 
  } 
 
  String get word => getAttribute("word"); 
  set word(String a) => setAttribute("word", a); 
  
  Tags get tags => getChild("tags"); 
  
  Keyword newEntity() => new Keyword(concept); 
  Keywords newEntities() => new Keywords(concept); 
  
  int wordCompareTo(Keyword other) { 
    return word.compareTo(other.word); 
  } 
 
} 
 
abstract class KeywordsGen extends Entities<Keyword> { 
 
  KeywordsGen(Concept concept) {
    this.concept = concept;
  }
 
  Keywords newEntities() => new Keywords(concept); 
  Keyword newEntity() => new Keyword(concept); 
  
} 
 

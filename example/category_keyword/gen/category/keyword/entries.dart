part of category_keyword; 
 
// lib/gen/category/keyword/entries.dart 
 
class KeywordEntries extends ModelEntries { 
 
  KeywordEntries(Model model) : super(model); 
 
  Map<String, Entities> newEntries() { 
    var entries = new Map<String, Entities>(); 
    var concept; 
    concept = model.concepts.singleWhereCode("Category"); 
    entries["Category"] = new Categories(concept); 
    concept = model.concepts.singleWhereCode("Keyword"); 
    entries["Keyword"] = new Keywords(concept); 
    return entries; 
  } 
 
  Entities newEntities(String conceptCode) { 
    var concept = model.concepts.singleWhereCode(conceptCode); 
    if (concept == null) { 
      throw new ConceptError("${conceptCode} concept does not exist.") ; 
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
    return null; 
  } 
 
  ConceptEntity newEntity(String conceptCode) { 
    var concept = model.concepts.singleWhereCode(conceptCode); 
    if (concept == null) { 
      throw new ConceptError("${conceptCode} concept does not exist.") ; 
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
    return null; 
  } 
 
  Categories get categories => getEntry("Category"); 
  Keywords get keywords => getEntry("Keyword"); 
 
} 
 

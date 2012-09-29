
// src/data/gen/concept/attribute/entries.dart

class AttributeEntries extends ModelEntries {

  AttributeEntries(Model model) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept;
    concept = model.concepts.findByCode("City");
    entries["City"] = new Cities(concept);
    return entries;
  }

  Entities newEntities(String conceptCode) {
    var concept = model.concepts.findByCode(conceptCode);
    if (concept == null) {
      throw new ConceptException("${conceptCode} concept does not exist.") ;
    }
    if (concept.code == "City") {
      return new Cities(concept);
    }
  }

  ConceptEntity newEntity(String conceptCode) {
    var concept = model.concepts.findByCode(conceptCode);
    if (concept == null) {
      throw new ConceptException("${conceptCode} concept does not exist.") ;
    }
    if (concept.code == "City") {
      return new City(concept);
    }
  }

  fromJsonToData() {
    fromJson(conceptAttributeDataJson);
  }

  Cities get cities => getEntry("City");

}

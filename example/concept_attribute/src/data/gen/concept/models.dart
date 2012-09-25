
// src/data/gen/concept/models.dart

class ConceptModels extends DomainModels {

  ConceptModels(Domain domain) : super(domain) {
    add(fromJsonToAttributeEntries());
  }

  AttributeEntries fromJsonToAttributeEntries() {
    return new AttributeEntries(fromMagicBoxes(
      conceptAttributeModelJson,
      domain,
      ConceptRepo.conceptAttributeModelCode));
  }

}





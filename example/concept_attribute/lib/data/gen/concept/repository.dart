
// src/data/gen/concept/repository.dart

class ConceptRepo extends Repo {

  static final conceptDomainCode = "Concept";
  static final conceptAttributeModelCode = "Attribute";

  ConceptRepo([String code="ConceptRepo"]) : super(code) {
    _initConceptDomain();
  }

  _initConceptDomain() {
    var conceptDomain = new Domain(conceptDomainCode);
    domains.add(conceptDomain);
    add(new ConceptModels(conceptDomain));
  }

}




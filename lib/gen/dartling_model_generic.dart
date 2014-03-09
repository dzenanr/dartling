part of dartling;

String genEntries(Model model, String library) {
  Domain domain = model.domain;

  var sc = 'part of ${library}; \n';
  sc = '${sc} \n';
  sc = '${sc}// lib/gen/${domain.codeLowerUnderscore}/'
       '${model.codeLowerUnderscore}/entries.dart \n';
  sc = '${sc} \n';
  sc = '${sc}class ${model.code}Entries extends ModelEntries { \n';
  sc = '${sc} \n';
  sc = '${sc}  ${model.code}Entries(Model model) : super(model); \n';
  sc = '${sc} \n';
  sc = '${sc}  Map<String, Entities> newEntries() { \n';
  sc = '${sc}    var entries = new Map<String, Entities>(); \n';
  sc = '${sc}    var concept; \n';
  for (Concept entryConcept in model.entryConcepts) {
    sc = '${sc}    concept = model.concepts.singleWhereCode('
         '"${entryConcept.code}"); \n';
    sc = '${sc}    entries["${entryConcept.code}"] = '
         'new ${entryConcept.codes}(concept); \n';
  }
  sc = '${sc}    return entries; \n';
  sc = '${sc}  } \n';
  sc = '${sc} \n';

  sc = '${sc}  Entities newEntities(String conceptCode) { \n';
  sc = '${sc}    var concept = model.concepts.singleWhereCode(conceptCode); \n';
  sc = '${sc}    if (concept == null) { \n';
  sc = '${sc}      throw new ConceptError('
       '"\${conceptCode} concept does not exist.") ; \n';
  sc = '${sc}    } \n';
  for (Concept concept in model.concepts) {
    sc = '${sc}    if (concept.code == "${concept.code}") { \n';
    sc = '${sc}      return new ${concept.codes}(concept); \n';
    sc = '${sc}    } \n';
  }
  sc = '${sc}    return null; \n';
  sc = '${sc}  } \n';
  sc = '${sc} \n';

  sc = '${sc}  ConceptEntity newEntity(String conceptCode) { \n';
  sc = '${sc}    var concept = model.concepts.singleWhereCode(conceptCode); \n';
  sc = '${sc}    if (concept == null) { \n';
  sc = '${sc}      throw new ConceptError('
       '"\${conceptCode} concept does not exist.") ; \n';
  sc = '${sc}    } \n';
  for (Concept concept in model.concepts) {
    sc = '${sc}    if (concept.code == "${concept.code}") { \n';
    sc = '${sc}      return new ${concept.code}(concept); \n';
    sc = '${sc}    } \n';
  }
  sc = '${sc}    return null; \n';
  sc = '${sc}  } \n';
  sc = '${sc} \n';

  for (Concept entryConcept in model.entryConcepts) {
    sc = '${sc}  ${entryConcept.codes} get '
         '${entryConcept.codesFirstLetterLower}'
         ' => getEntry("${entryConcept.code}"); \n';
  }

  sc = '${sc} \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}


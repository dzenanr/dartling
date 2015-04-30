part of dartling;

const int ENTRY_ENTITIES_COUNT = 3;
const int CHILD_ENTITIES_COUNT = 2;

String genModel(Model model, String library) {
  Domain domain = model.domain;

  var sc = ' \n';
  sc = '${sc}part of ${library}; \n';
  sc = '${sc} \n';
  sc = '${sc}// lib/${domain.codeLowerUnderscore}/'
       '${model.codeLowerUnderscore}/model.dart \n';
  sc = '${sc} \n';
  sc = '${sc}class ${model.code}Model extends ${model.code}Entries { \n';
  sc = '${sc} \n';
  sc = '${sc}  ${model.code}Model(Model model) : super(model); \n';
  sc = '${sc} \n';
  for (Concept entryConcept in model.entryConcepts) {
    sc = '${sc}  void fromJsonTo${entryConcept.code}Entry() { \n';
    sc = '${sc}    fromJsonToEntry(${domain.codeFirstLetterLower}${model.code}'
         '${entryConcept.code}Entry); \n';
    sc = '${sc}  } \n';
    sc = '${sc} \n';
  }
  
  sc = '${sc}  void fromJsonToModel() { \n';
  sc = '${sc}    fromJson(${domain.codeFirstLetterLower}${model.code}Model); \n';
  sc = '${sc}  } \n';
  sc = '${sc} \n';

  // ordered by external parent count (from 0 to ...)
  var orderedEntryConcepts = model.orderedEntryConcepts;

  sc = '${sc}  void init() { \n';
  for (Concept entryConcept in orderedEntryConcepts) {
    var Entities = '${entryConcept.codePluralFirstLetterUpper}';
    sc = '${sc}    void init${Entities}(); \n';
  }
  sc = '${sc}  } \n';
  sc = '${sc} \n';

  for (Concept entryConcept in model.entryConcepts) {
    var Entities = '${entryConcept.codePluralFirstLetterUpper}';
    sc = '${sc}  void init${Entities}() { \n';
    var entitiesCreated = createInitEntryEntitiesRandomly(entryConcept);
    sc = '${sc}${entitiesCreated}';
    sc = '${sc}  } \n';
    sc = '${sc} \n'; 
  }  

  sc = '${sc}  // added after code gen - begin \n';
  sc = '${sc} \n';
  sc = '${sc}  // added after code gen - end \n';  
  sc = '${sc} \n';
  
  sc = '${sc}} \n';
  sc = '${sc} \n';
  
  return sc;
}






part of dartling;

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
    sc = '${sc}  fromJsonTo${entryConcept.code}Entry() { \n';
    sc = '${sc}    fromJsonToEntry(${domain.codeFirstLetterLower}${model.code}'
         '${entryConcept.code}Entry); \n';
    sc = '${sc}  } \n';
    sc = '${sc} \n';
  }
  
  sc = '${sc}  fromJsonToModel() { \n';
  sc = '${sc}    fromJson(${domain.codeFirstLetterLower}${model.code}Model); \n';
  sc = '${sc}  } \n';
  sc = '${sc} \n';

  // ordered by external parent count (from 0 to ...)
  var orderedEntryConcepts = model.orderedEntryConcepts;
  
  sc = '${sc}  fromMap(Map<String, Object> entriesMap) { \n';  
  for (Concept entryConcept in orderedEntryConcepts) {
    var entryMap = '${entryConcept.codeFirstLetterLower}EntryMap';
    sc = '${sc}    Map<String, Object> ${entryMap} = '
         'entriesMap["${entryConcept.code}"]; \n';
    sc = '${sc}    fromMapToEntry(${entryMap}); \n';
  }
  sc = '${sc}  } \n';
  sc = '${sc} \n';

  sc = '${sc}  init() { \n';
  for (Concept entryConcept in orderedEntryConcepts) {
    var Entities = '${entryConcept.codePluralFirstLetterUpper}';
    sc = '${sc}    init${Entities}(); \n';
  }
  sc = '${sc}  } \n';
  sc = '${sc} \n';

  for (Concept entryConcept in model.entryConcepts) {
    var Entities = '${entryConcept.codePluralFirstLetterUpper}';
    sc = '${sc}  init${Entities}() { \n';
    var entitiesCreated = createEntitiesRandomly(entryConcept, 3);
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

String createEntitiesRandomly(
    Concept concept, int count, [Concept parentConcept, String parent='']) {
  var sc = '';
  for (var i = 1; i < count + 1; i++) {
    var entity;
    var entities;
    if (parent == '') {
      entity = '${concept.codeFirstLetterLower}${i}';
      entities = '${concept.codesFirstLetterLower}';
      sc = '${sc}    var ${entity} = new ${concept.code}('   
           '${concept.codesFirstLetterLower}.concept); \n';
    } else {
      entity = '${parent}${concept.code}${i}';
      entities = '${concept.codesFirstLetterLower}';
      sc = '${sc}    var ${entity} = new ${concept.code}('   
           '${parent}.${concept.codesFirstLetterLower}.concept); \n';
    }
    var attributesSet = setAttributesRandomly(concept, entity);
    sc = '${sc}${attributesSet}';
    
    for (Parent externalRequiredParent in concept.externalRequiredParents) {
      var parent = '${externalRequiredParent.code}';
      var Parent = '${externalRequiredParent.codeFirstLetterUpper}';
      var parents = '${externalRequiredParent.destinationConcept.codePluralFirstLetterLower}';
      sc = '${sc}    var ${entity}${Parent} = ${parents}.random(); \n';
      sc = '${sc}    ${entity}.${parent} = ${entity}${Parent}; \n';
      //sc = '${sc}    ${entity}${Parent}.${entities}.add(${entity}); \n';
    }
    
    if (parent == '') {
      sc = '${sc}    ${entities}.add(${entity}); \n';     
    } else {
      sc = '${sc}    ${entity}.${parentConcept.codeFirstLetterLower} = '
           '${parent}; \n'; 
      sc = '${sc}    ${parent}.${entities}.add(${entity}); \n';    
    }
    
    for (Parent externalRequiredParent in concept.externalRequiredParents) {
      var parent = '${externalRequiredParent.code}';
      var Parent = '${externalRequiredParent.codeFirstLetterUpper}';
      var parents = '${externalRequiredParent.destinationConcept.codePluralFirstLetterLower}';
      //sc = '${sc}    var ${entity}${Parent} = ${parents}.random(); \n';
      //sc = '${sc}    ${entity}.${parent} = ${entity}${Parent}; \n';
      sc = '${sc}    ${entity}${Parent}.${entities}.add(${entity}); \n';
    }
    
    sc = '${sc} \n';
    for (Child child in concept.children) {
      if (child.internal) {
        Concept childConcept = child.destinationConcept;
        var entitiesCreated = 
            createEntitiesRandomly(childConcept, 2, concept, entity);
        sc = '${sc}${entitiesCreated}';
      }
    } // for child
  } // for var  
  return sc;
}

// tod do: check if random value should be unique

String setAttributesRandomly(Concept concept, String entity, [String end='']) {
  var sc = '';
  for (Attribute attribute in concept.attributes) {
    if (attribute.type.code == 'String') {     
      if (end == '') {
        sc = '${sc}    ${entity}.${attribute.code} = "${randomWord()}"; \n';
      } else {
        sc = '${sc}    ${entity}.${attribute.code} = "${randomWord()}${end}"; \n';
      }        
    } else if (attribute.type.code == 'num') {
      sc = '${sc}    ${entity}.${attribute.code} = ${randomNum(1000)}; \n';
    } else if (attribute.type.code == 'int') {
      sc = '${sc}    ${entity}.${attribute.code} = ${randomInt(10000)}; \n';
    } else if (attribute.type.code == 'double') {
      sc = '${sc}    ${entity}.${attribute.code} = ${randomDouble(100)}; \n';
    } else if (attribute.type.code == 'bool') {
      sc = '${sc}    ${entity}.${attribute.code} = ${randomBool()}; \n';
    } else if (attribute.type.code == 'DateTime') {
      sc = '${sc}    ${entity}.${attribute.code} = new DateTime.now(); \n';
    } else if (attribute.type.code == 'Uri') {
      sc = '${sc}    ${entity}.${attribute.code} = '
           'Uri.parse("${randomUri()}"); \n';
    } else if (attribute.type.code == 'Email') {
      sc = '${sc}    ${entity}.${attribute.code} = "${randomEmail()}"; \n';
    } else {
      sc = '${sc}    ${entity}.${attribute.code} = "${randomWord()}"; \n';
    }
  }
  return sc;
}



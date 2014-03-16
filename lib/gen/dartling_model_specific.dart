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
    var entitiesCreated = createEntryEntitiesRandomly(entryConcept);
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

String createEntryEntitiesRandomly(Concept entryConcept) {
  var sc = '';
  for (var i = 1; i < ENTRY_ENTITIES_COUNT + 1; i++) {
    var entryEntity = '${entryConcept.codeFirstLetterLower}${i}';
    var entryEntities = '${entryConcept.codesFirstLetterLower}';
    sc = '${sc}    var ${entryEntity} = new ${entryConcept.code}('   
         '${entryConcept.codesFirstLetterLower}.concept); \n';
    var attributesSet = setAttributesRandomly(entryConcept, entryEntity);
    sc = '${sc}${attributesSet}';
    
    for (Parent externalRequiredParent in entryConcept.externalRequiredParents) {
      var parent = '${externalRequiredParent.code}';
      var Parent = '${externalRequiredParent.codeFirstLetterUpper}';
      var parents = '${externalRequiredParent.destinationConcept.codePluralFirstLetterLower}';
      sc = '${sc}    var ${entryEntity}${Parent} = ${parents}.random(); \n';
      sc = '${sc}    ${entryEntity}.${parent} = ${entryEntity}${Parent}; \n';
    }
    
    sc = '${sc}    ${entryEntities}.add(${entryEntity}); \n';     
    
    for (Parent externalRequiredParent in entryConcept.externalRequiredParents) {
      var parent  = '${externalRequiredParent.code}';
      var Parent  = '${externalRequiredParent.codeFirstLetterUpper}';
      sc = '${sc}    ${entryEntity}${Parent}.'
           '${externalRequiredParent.opposite.code}.add('
           '${entryEntity}); \n';
    }
    
    sc = '${sc} \n';
    for (Child child in entryConcept.children) {
      if (child.internal) {
        String parentVar = entryEntity;
        String parentCode = child.opposite.code;
        Concept parentConcept = entryConcept;
        String childCode = child.code;
        Concept childConcept = child.destinationConcept;
        var entitiesCreated = createChildEntitiesRandomly(parentVar, 
              parentCode, parentConcept, childCode, childConcept);
        sc = '${sc}${entitiesCreated}';
      }
    } // for child
  } // for var  
  return sc;
}

String createChildEntitiesRandomly(String parentVar, 
    String parentCode, Concept parentConcept, 
    String childCode, Concept childConcept) {
  var sc = '';
  for (var i = 1; i < CHILD_ENTITIES_COUNT + 1; i++) {
    var childEntity = '${parentVar}${childCode}${i}';
    var childEntities = '${childCode}';
    sc = '${sc}    var ${childEntity} = new ${childConcept.code}('   
         '${parentVar}.${childCode}.concept); \n';
    var attributesSet = setAttributesRandomly(childConcept, childEntity);
    sc = '${sc}${attributesSet}';
    
    for (Parent externalRequiredParent in childConcept.externalRequiredParents) {
      var parent  = '${externalRequiredParent.code}';
      var Parent  = '${externalRequiredParent.codeFirstLetterUpper}';
      var parents = 
        '${externalRequiredParent.destinationConcept.codePluralFirstLetterLower}';
      sc = '${sc}    var ${childEntity}${Parent} = ${parents}.random(); \n';
      sc = '${sc}    ${childEntity}.${parent} = ${childEntity}${Parent}; \n';
    }
    
    sc = '${sc}    ${childEntity}.${parentCode} = ${parentVar}; \n'; 
    sc = '${sc}    ${parentVar}.${childEntities}.add(${childEntity}); \n';    
    
    for (Parent externalRequiredParent in childConcept.externalRequiredParents) {
      var parent  = '${externalRequiredParent.code}';
      var Parent  = '${externalRequiredParent.codeFirstLetterUpper}';   
      sc = '${sc}    ${childEntity}${Parent}.'
           '${externalRequiredParent.opposite.code}.add('
           '${childEntity}); \n';
    }
    
    sc = '${sc} \n';
    for (Child child in childConcept.children) {
      if (child.internal && !child.reflexive) {
        // the old child becomes a new parent
        String newParentVar = childEntity;
        String newParentCode = child.opposite.code;
        Concept newParentConcept = childConcept;
        // a new child is a grandchild of the old parent, or a child of a new parent
        String newChildCode = child.code;
        Concept newChildConcept = child.destinationConcept;
        var entitiesCreated = createChildEntitiesRandomly(newParentVar,
              newParentCode, newParentConcept, newChildCode, newChildConcept);
        sc = '${sc}${entitiesCreated}';
      }
    } // for child
  } // for var  
  return sc;
}

// to do: check if random value should be unique
String setAttributesRandomly(Concept concept, String entity) {
  var sc = '';
  //for (Attribute attribute in concept.requiredAttributes) {
  for (Attribute attribute in concept.attributes) {
    var attributeSet = setAttributeRandomly(attribute, entity);
    sc = '${sc}${attributeSet}';
  }
  return sc;
}

String setAttributeRandomly(Attribute attribute, String entity) {
  var sc = '';
  if (attribute.increment == null) {
    var value = genAttributeTextRandomly(attribute);
    sc = '${sc}      ${entity}.${attribute.code} = ${value}; \n';
  }
  return sc;
}

String genAttributeTextRandomly(Attribute attribute) {
  var value = '';
  if (attribute.type.code == 'String') {     
    value = "'${randomWord()}'";    
  }  else if (attribute.type.code == 'num') {
    value = "${randomNum(1000)}";
  } else if (attribute.type.code == 'int') {
    value = "${randomInt(10000)}";
  } else if (attribute.type.code == 'double') {
    value = "${randomDouble(100)}";
  } else if (attribute.type.code == 'bool') {
    value = "${randomBool()}";
  } else if (attribute.type.code == 'DateTime') {
    value = "new DateTime.now()";
  } else if (attribute.type.code == 'Uri') {
    value = "Uri.parse('${randomUri()}')";
  } else if (attribute.type.code == 'Email') {
    value = "'${randomEmail()}'";
  } else {
    value = "'${randomWord()}'";
  }
  return value;
}



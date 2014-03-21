part of dartling;

String genDartlingGen(Model model) {
  Domain domain = model.domain;

  var sc = ' \n';
  sc = '${sc}// test/${domain.codeLowerUnderscore}/${model.codeLowerUnderscore}/'
       '${domain.codeLowerUnderscore}_${model.codeLowerUnderscore}_gen.dart \n';
  sc = '${sc} \n';

  sc = '${sc}import "package:${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}/${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}.dart"; \n';
  sc = '${sc} \n';

  sc = '${sc}genCode(Repository repository) { \n';
  sc = '${sc}  repository.gen("${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}"); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  sc = '${sc}initData(Repository repository) { \n';
  sc = '${sc}   var ${domain.codeFirstLetterLower}Domain = '
       'repository.getDomainModels("${domain.code}"); \n';
  sc = '${sc}   var ${model.codeFirstLetterLower}Model = '
       '${domain.codeFirstLetterLower}Domain.'
       'getModelEntries("${model.code}"); \n';
  sc = '${sc}   ${model.codeFirstLetterLower}Model.init(); \n';
  sc = '${sc}   //${model.codeFirstLetterLower}Model.display(); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';
  
  sc = '${sc}void main() { \n';
  sc = '${sc}  var repository = new Repository(); \n';
  sc = '${sc}  genCode(repository); \n';
  sc = '${sc}  //initData(repository); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}

String genDartlingTest(Repo repo, Model model, Concept entryConcept) {
  Domain domain = model.domain;

  var sc = ' \n';
  sc = '${sc}// test/${domain.codeLowerUnderscore}/'
       '${model.codeLowerUnderscore}/${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}_${entryConcept.codeLowerUnderscore}_'
       'test.dart \n';
  sc = '${sc} \n';

  sc = '${sc}import "package:unittest/unittest.dart"; \n';
  sc = '${sc}import "package:dartling/dartling.dart"; \n';
  sc = '${sc}import "package:${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}/${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}.dart"; \n';
  sc = '${sc} \n';
  
  var entities = '${entryConcept.codePluralFirstLetterLower}';
  var entity   = '${entryConcept.codeFirstLetterLower}';
  var Entity   = '${entryConcept.code}';
  var Entities = '${entryConcept.codePluralFirstLetterUpper}';
  var entityConcept = '${entities}.concept';

  sc = '${sc}test${domain.code}${model.code}'
       '${entryConcept.codePluralFirstLetterUpper}( \n';
  sc = '${sc}    ${domain.code}Domain ${domain.codeFirstLetterLower}Domain, '
       '${model.code}Model ${model.codeFirstLetterLower}Model, '
       '${Entities} ${entities}) { \n';
  sc = '${sc}  DomainSession session; \n';
  sc = '${sc}  group("Testing ${domain.code}.${model.code}.${Entity}", () { \n';
  sc = '${sc}    session = ${domain.codeFirstLetterLower}Domain.newSession();  \n';
  sc = '${sc}    expect(${model.codeFirstLetterLower}Model.isEmpty, isTrue); \n';
  sc = '${sc}    setUp(() { \n';
  sc = '${sc}      ${model.codeFirstLetterLower}Model.init(); \n';
  sc = '${sc}    }); \n';
  sc = '${sc}    tearDown(() { \n';
  sc = '${sc}      ${model.codeFirstLetterLower}Model.clear(); \n';
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Not empty model", () { \n';
  sc = '${sc}      expect(${model.codeFirstLetterLower}Model.isEmpty, '
       'isFalse); \n';
  sc = '${sc}      expect(${entities}.isEmpty, isFalse); \n';
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Empty model", () { \n';
  sc = '${sc}      ${model.codeFirstLetterLower}Model.clear(); \n';
  sc = '${sc}      expect(${model.codeFirstLetterLower}Model.isEmpty, '
       'isTrue); \n';
  sc = '${sc}      expect(${entities}.isEmpty, isTrue); \n';
  sc = '${sc}      expect(${entities}.errors.isEmpty, isTrue); \n';
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("From model to JSON", () { \n';
  sc = '${sc}      var json = ${model.codeFirstLetterLower}Model.toJson(); \n';
  sc = '${sc}      expect(json, isNotNull); \n';
  sc = '${sc} \n';
  sc = '${sc}      print(json); \n';
  sc = '${sc}      //${model.codeFirstLetterLower}Model.displayJson(); \n';
  sc = '${sc}      //${model.codeFirstLetterLower}Model.display(); \n';
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("From JSON to model", () { \n';
  sc = '${sc}      var json = ${model.codeFirstLetterLower}Model.toJson(); \n';
  sc = '${sc}      ${model.codeFirstLetterLower}Model.clear(); \n';
  sc = '${sc}      expect(${model.codeFirstLetterLower}Model.isEmpty, '
       'isTrue); \n';
  sc = '${sc}      ${model.codeFirstLetterLower}Model.fromJson(json); \n';
  sc = '${sc}      expect(${model.codeFirstLetterLower}Model.isEmpty, '
       'isFalse); \n';
  sc = '${sc} \n';
  sc = '${sc}      ${model.codeFirstLetterLower}Model.display(); \n';
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("From model entry to JSON", () { \n';
  sc = '${sc}      var json = ${model.codeFirstLetterLower}Model.'
       'fromEntryToJson("${Entity}"); \n';
  sc = '${sc}      expect(json, isNotNull); \n';
  sc = '${sc} \n';
  sc = '${sc}      print(json); \n';
  sc = '${sc}      //${model.codeFirstLetterLower}Model.'
       'displayEntryJson("${Entity}"); \n';
  sc = '${sc}      //${model.codeFirstLetterLower}Model.displayJson(); \n';
  sc = '${sc}      //${model.codeFirstLetterLower}Model.display(); \n';
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("From JSON to model entry", () { \n';
  sc = '${sc}      var json = ${model.codeFirstLetterLower}Model.'
       'fromEntryToJson("${Entity}"); \n';
  sc = '${sc}      ${entities}.clear(); \n';
  sc = '${sc}      expect(${entities}.isEmpty, isTrue); \n';
  sc = '${sc}      ${model.codeFirstLetterLower}Model.fromJsonToEntry(json); \n';
  sc = '${sc}      expect(${entities}.isEmpty, isFalse); \n';
  sc = '${sc} \n';
  sc = '${sc}      ${entities}.display(title: "From JSON to model entry"); \n';
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Add ${entity} required error", () { \n';
  var requiredNonIdAttribute = findRequiredNonIdAttribute(entryConcept);
  if (requiredNonIdAttribute != null) {
    sc = '${sc}      var ${entity}Concept = ${entities}.concept; \n';
    sc = '${sc}      var ${entity}Count = ${entities}.length; \n';
    sc = '${sc}      var ${entity} = new ${Entity}(${entity}Concept); \n';
    sc = '${sc}      var added = ${entities}.add(${entity}); \n';
    sc = '${sc}      expect(added, isFalse); \n';
    sc = '${sc}      expect(${entities}.length, equals(${entity}Count)); \n';
    sc = '${sc}      expect(${entities}.errors.length, greaterThan(0)); \n';
    sc = '${sc}      expect(${entities}.errors.toList()[0].category, '
         'equals("required")); \n';
    sc = '${sc} \n';
    sc = '${sc}      ${entities}.errors.display(title: "Add ${entity} required '
         'error"); \n';
  } else {
    sc = '${sc}      // no required attribute that is not id \n';
  }
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Add ${entity} unique error", () { \n';
  var idAttribute = findIdAttribute(entryConcept);
  if (idAttribute != null) {
    if (idAttribute.increment == null) {
      sc = '${sc}      var ${entity}Concept = ${entities}.concept; \n';
      sc = '${sc}      var ${entity}Count = ${entities}.length; \n';
      sc = '${sc}      var ${entity} = new ${Entity}(${entity}Concept); \n';
      sc = '${sc}      var random${Entity} = ${entities}.random(); \n';
      sc = '${sc}      ${entity}.${idAttribute.code} = '
           'random${Entity}.${idAttribute.code}; \n';
      sc = '${sc}      var added = ${entities}.add(${entity}); \n';
      sc = '${sc}      expect(added, isFalse); \n';
      sc = '${sc}      expect(${entities}.length, equals(${entity}Count)); \n';
      sc = '${sc}      expect(${entities}.errors.length, greaterThan(0)); \n';
      sc = '${sc} \n';
      sc = '${sc}      ${entities}.errors.display(title: "Add ${entity} unique '
           'error"); \n'; 
    } else {
      sc = '${sc}      // id attribute defined as increment, cannot update it \n';
    }
  } else {
    sc = '${sc}      // no id attribute \n';
  }
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Not found ${entity} by new oid", () { \n';
  sc = '${sc}      var dartlingOid = new Oid.ts(1345648254063); \n';
  sc = '${sc}      var ${entity} = ${entities}.singleWhereOid(dartlingOid); \n';
  sc = '${sc}      expect(${entity}, isNull); \n';
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Find ${entity} by oid", () { \n';
  sc = '${sc}      var random${Entity} = ${entities}.random(); \n';
  sc = '${sc}      var ${entity} = '
       '${entities}.singleWhereOid(random${Entity}.oid); \n';
  sc = '${sc}      expect(${entity}, isNotNull); \n';
  sc = '${sc}      expect(${entity}, equals(random${Entity})); \n';
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Find ${entity} by attribute id", () { \n';
  if (idAttribute != null) {
    sc = '${sc}      var random${Entity} = ${entities}.random(); \n';
    sc = '${sc}      var ${entity} = \n';
    sc = '${sc}          ${entities}.singleWhereAttributeId('
         '"${idAttribute.code}", random${Entity}.${idAttribute.code}); \n';
    sc = '${sc}      expect(${entity}, isNotNull); \n';
    sc = '${sc}      expect(${entity}.${idAttribute.code}, '
         'equals(random${Entity}.${idAttribute.code})); \n';
  } else {
    sc = '${sc}      // no id attribute \n';
  }
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Find ${entity} by required attribute", () { \n';
  if (requiredNonIdAttribute != null) {
    sc = '${sc}      var random${Entity} = ${entities}.random(); \n';
    sc = '${sc}      var ${entity} = \n';
    sc = '${sc}          ${entities}.firstWhereAttribute('
         '"${requiredNonIdAttribute.code}", '
         'random${Entity}.${requiredNonIdAttribute.code}); \n';
    sc = '${sc}      expect(${entity}, isNotNull); \n';
    sc = '${sc}      expect(${entity}.${requiredNonIdAttribute.code}, '
         'equals(random${Entity}.${requiredNonIdAttribute.code})); \n';
    sc = '${sc}    }); \n';
  } else {
    sc = '${sc}      // no required attribute that is not id \n';
  }
  sc = '${sc} \n';
  
  sc = '${sc}    test("Find ${entity} by attribute", () { \n';
  var nonRequiredAttribute = findNonRequiredAttribute(entryConcept);
  if (nonRequiredAttribute != null) {
    sc = '${sc}      var random${Entity} = ${entities}.random(); \n';
    sc = '${sc}      var ${entity} = \n';
    sc = '${sc}          ${entities}.firstWhereAttribute('
         '"${nonRequiredAttribute.code}", random${Entity}.'
         '${nonRequiredAttribute.code}); \n';
    sc = '${sc}      expect(${entity}, isNotNull); \n';
    sc = '${sc}      expect(${entity}.${nonRequiredAttribute.code}, '
         'equals(random${Entity}.${nonRequiredAttribute.code})); \n';
  } else {
    sc = '${sc}      // no attribute that is not required \n';
  }
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Select ${entities} by attribute", () { \n';
  if (nonRequiredAttribute != null) {
    sc = '${sc}      var random${Entity} = ${entities}.random(); \n';
    sc = '${sc}      var selected${Entities} = \n';
    sc = '${sc}          ${entities}.selectWhereAttribute('
         '"${nonRequiredAttribute.code}", random${Entity}.'
         '${nonRequiredAttribute.code}); \n';
    sc = '${sc}      expect(selected${Entities}.isEmpty, isFalse); \n';
    sc = '${sc}      selected${Entities}.forEach((se) => \n';
    sc = '${sc}          expect(se.${nonRequiredAttribute.code}, '
         'equals(random${Entity}.${nonRequiredAttribute.code}))); \n';
    sc = '${sc} \n';
    sc = '${sc}      //selected${Entities}.display(title: "Select ${entities} by '
         '${nonRequiredAttribute.code}"); \n'; 
  } else {
    sc = '${sc}      // no attribute that is not required \n';
  }
  sc = '${sc}    }); \n';
  sc = '${sc} \n';

  sc = '${sc}    test("Select ${entities} by required attribute", () { \n';
  if (requiredNonIdAttribute != null) {
    sc = '${sc}      var random${Entity} = ${entities}.random(); \n';
    sc = '${sc}      var selected${Entities} = \n';
    sc = '${sc}          ${entities}.selectWhereAttribute('
         '"${requiredNonIdAttribute.code}", '
         'random${Entity}.${requiredNonIdAttribute.code}); \n';
    sc = '${sc}      expect(selected${Entities}.isEmpty, isFalse); \n';
    sc = '${sc}      selected${Entities}.forEach((se) => \n';
    sc = '${sc}          expect(se.${requiredNonIdAttribute.code}, '
         'equals(random${Entity}.${requiredNonIdAttribute.code}))); \n';
    sc = '${sc} \n';
    sc = '${sc}      //selected${Entities}.display(title: "Select ${entities} by '
         '${requiredNonIdAttribute.code}"); \n'; 
    sc = '${sc}    }); \n';
  } else {
    sc = '${sc}      // no required attribute that is not id \n';
  }
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Select ${entities} by attribute, then add", () { \n';
  var nonIdAttribute = findNonIdAttribute(entryConcept);
  if (nonIdAttribute != null) {
    sc = '${sc}      var random${Entity} = ${entities}.random(); \n';
    sc = '${sc}      var selected${Entities} = \n';
    sc = '${sc}          ${entities}.selectWhereAttribute('
         '"${nonIdAttribute.code}", random${Entity}.${nonIdAttribute.code}); \n';
    sc = '${sc}      expect(selected${Entities}.isEmpty, isFalse); \n';
    sc = '${sc}      expect(selected${Entities}.source.isEmpty, isFalse); \n';
    sc = '${sc}      var ${entities}Count = ${entities}.length; \n';
    sc = '${sc} \n';
    sc = '${sc}      var ${entity} = new ${Entity}(${entities}.concept); \n';
    var attributesSet = setAttributesRandomly(entryConcept, entity);
    sc = '${sc}${attributesSet}';
    sc = '${sc}      var added = selected${Entities}.add(${entity}); \n';
    sc = '${sc}      expect(added, isTrue); \n';
    sc = '${sc}      expect(${entities}.length, equals(++${entities}Count)); \n';
    sc = '${sc} \n';
    sc = '${sc}      //selected${Entities}.display(title: \n';
    sc = '${sc}      //  "Select ${entities} by attribute, then add"); \n';
    sc = '${sc}      //${entities}.display(title: "All ${entities}"); \n'; 
  } else {
    sc = '${sc}      // no attribute that is not id \n';
  }
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Select ${entities} by attribute, then remove", () { \n';
  if (nonIdAttribute != null) {
    sc = '${sc}      var random${Entity} = ${entities}.random(); \n';
    sc = '${sc}      var selected${Entities} = \n';
    sc = '${sc}          ${entities}.selectWhereAttribute('
         '"${nonIdAttribute.code}", random${Entity}.${nonIdAttribute.code}); \n';
    sc = '${sc}      expect(selected${Entities}.isEmpty, isFalse); \n';
    sc = '${sc}      expect(selected${Entities}.source.isEmpty, isFalse); \n';
    sc = '${sc}      var ${entities}Count = ${entities}.length; \n';
    sc = '${sc} \n';
    sc = '${sc}      var removed = selected${Entities}.remove(random${Entity}); \n';
    sc = '${sc}      expect(removed, isTrue); \n';
    sc = '${sc}      expect(${entities}.length, equals(--${entities}Count)); \n';
    sc = '${sc} \n';
    sc = '${sc}      random${Entity}.display(prefix: "removed"); \n';
    sc = '${sc}      //selected${Entities}.display(title: \n';
    sc = '${sc}      //  "Select ${entities} by attribute, then remove"); \n';
    sc = '${sc}      //${entities}.display(title: "All ${entities}"); \n'; 
  } else {
    sc = '${sc}      // no attribute that is not id \n';
  }
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Sort ${entities}", () { \n';
  if (idAttribute != null) {
    sc = '${sc}      ${entities}.sort(); \n';
    sc = '${sc} \n';
    sc = '${sc}      //${entities}.display(title: "Sort ${entities}"); \n';    
  } else {
    sc = '${sc}      // no id attribute \n';
    sc = '${sc}      // add compareTo method in the specific ${Entity} class \n';
    sc = '${sc}      /* \n';
    sc = '${sc}      ${entities}.sort(); \n';
    sc = '${sc} \n';
    sc = '${sc}      //${entities}.display(title: "Sort ${entities}"); \n';
    sc = '${sc}      */ \n';
  }
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Order ${entities}", () { \n';
  if (idAttribute != null) {
    sc = '${sc}      var ordered${Entities} = ${entities}.order(); \n';
    sc = '${sc}      expect(ordered${Entities}.isEmpty, isFalse); \n';
    sc = '${sc}      expect(ordered${Entities}.length, '
         'equals(${entities}.length)); \n';
    sc = '${sc}      expect(ordered${Entities}.source.isEmpty, isFalse); \n';
    sc = '${sc}      expect(ordered${Entities}.source.length, '
         'equals(${entities}.length)); \n';
    sc = '${sc}      expect(ordered${Entities}, isNot(same(${entities}))); \n';
    sc = '${sc} \n';
    sc = '${sc}      //ordered${Entities}.display(title: "Order ${entities}"); \n';    
  } else {
    sc = '${sc}      // no id attribute \n';
    sc = '${sc}      // add compareTo method in the specific ${Entity} class \n';
    sc = '${sc}      /* \n';
    sc = '${sc}      var ordered${Entities} = ${entities}.order(); \n';
    sc = '${sc}      expect(ordered${Entities}.isEmpty, isFalse); \n';
    sc = '${sc}      expect(ordered${Entities}.length, '
         'equals(${entities}.length)); \n';
    sc = '${sc}      expect(ordered${Entities}.source.isEmpty, isFalse); \n';
    sc = '${sc}      expect(ordered${Entities}.source.length, '
         'equals(${entities}.length)); \n';
    sc = '${sc}      expect(ordered${Entities}, isNot(same(${entities}))); \n';
    sc = '${sc} \n';
    sc = '${sc}      //ordered${Entities}.display(title: "Order ${entities}"); \n';    
    sc = '${sc}      */ \n';
  }
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Copy ${entities}", () { \n';
  sc = '${sc}      var copied${Entities} = ${entities}.copy(); \n';
  sc = '${sc}      expect(copied${Entities}.isEmpty, isFalse); \n';
  sc = '${sc}      expect(copied${Entities}.length, '
       'equals(${entities}.length)); \n';
  sc = '${sc}      expect(copied${Entities}, isNot(same(${entities}))); \n';
  sc = '${sc}      copied${Entities}.forEach((e) => \n';
  sc = '${sc}        expect(e, equals(${entities}.singleWhereOid(e.oid)))); \n';
  if (entryConcept.hasId) {
    sc = '${sc}      copied${Entities}.forEach((e) => \n';
    sc = '${sc}        expect(e, isNot(same(${entities}.singleWhereId(e.id))))); \n';    
  }
  sc = '${sc} \n';
  sc = '${sc}      //copied${Entities}.display(title: "Copy ${entities}"); \n';
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("True for every ${entity}", () { \n';
  if (requiredNonIdAttribute != null) {
    sc = '${sc}      expect(${entities}.every((e) => '
         'e.${requiredNonIdAttribute.code} != null), isTrue); \n';
  } else {
    sc = '${sc}      // no required attribute that is not id \n';
  }
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Random ${entity}", () { \n';
  sc = '${sc}      var ${entity}1 = ${entities}.random(); \n';
  sc = '${sc}      expect(${entity}1, isNotNull); \n';
  sc = '${sc}      var ${entity}2 = ${entities}.random(); \n';
  sc = '${sc}      expect(${entity}2, isNotNull); \n';
  sc = '${sc} \n';
  sc = '${sc}      //${entity}1.display(prefix: "random1"); \n';
  sc = '${sc}      //${entity}2.display(prefix: "random2"); \n';
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Update ${entity} id with try", () { \n';
  if (idAttribute != null) {
    if (idAttribute.increment == null) {
      sc = '${sc}      var random${Entity} = ${entities}.random(); \n';
      sc = '${sc}      var beforeUpdate = random${Entity}.${idAttribute.code}; \n';
      sc = '${sc}      try { \n';
      var attributeSet = setAttributeRandomly(idAttribute, 'random${Entity}');
      sc = '${sc}  ${attributeSet}';
      sc = '${sc}      } on UpdateError catch (e) { \n';
      sc = '${sc}        expect(random${Entity}.${idAttribute.code}, '
           'equals(beforeUpdate)); \n';   
      sc = '${sc}      } \n';      
    } else {
      sc = '${sc}      // id attribute defined as increment, cannot update it \n';       
    }
  } else {
    sc = '${sc}      // no id attribute \n';
  }
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Update ${entity} id without try", () { \n';
  if (idAttribute != null) {
    if (idAttribute.increment == null) {
      sc = '${sc}      var random${Entity} = ${entities}.random(); \n';
      sc = '${sc}      var beforeUpdateValue = '
           'random${Entity}.${idAttribute.code}; \n';
      var value = genAttributeTextRandomly(idAttribute); 
      sc = '${sc}      expect(() => random${Entity}.${idAttribute.code} = '
           '${value}, throws); \n';
      sc = '${sc}      expect(random${Entity}.${idAttribute.code}, '
           'equals(beforeUpdateValue)); \n';       
    } else {
      sc = '${sc}      // id attribute defined as increment, cannot update it \n';        
    } 
  } else {
    sc = '${sc}      // no id attribute \n';
  }
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Update ${entity} id with success", () { \n';
  if (idAttribute != null) {
    if (idAttribute.increment == null) {
      sc = '${sc}      var random${Entity} = ${entities}.random(); \n';
      sc = '${sc}      var afterUpdateEntity = random${Entity}.copy(); \n';
      sc = '${sc}      var attribute = random${Entity}.concept.attributes.'
           'singleWhereCode("${idAttribute.code}"); \n';
      sc = '${sc}      expect(attribute.update, isFalse); \n';
      sc = '${sc}      attribute.update = true; \n';
      var value = genAttributeTextRandomly(idAttribute); 
      sc = '${sc}      afterUpdateEntity.${idAttribute.code} = ${value}; \n';
      sc = '${sc}      expect(afterUpdateEntity.${idAttribute.code}, '
           'equals(${value})); \n'; 
      sc = '${sc}      attribute.update = false; \n';
      sc = '${sc}      var updated = ${entities}.update(random${Entity}, '
           'afterUpdateEntity); \n';
      sc = '${sc}      expect(updated, isTrue); \n';
      sc = '${sc} \n';
      sc = '${sc}      var entity = ${entities}.singleWhereAttributeId('
           '"${idAttribute.code}", ${value}); \n';
      sc = '${sc}      expect(entity, isNotNull); \n';
      sc = '${sc}      expect(entity.${idAttribute.code}, equals(${value})); \n';
      sc = '${sc} \n';
      sc = '${sc}      //${entities}.display("After update ${entity} id"); \n';      
    } else {
      sc = '${sc}      // id attribute defined as increment, cannot update it \n';     
    }
  } else {
    sc = '${sc}      // no id attribute \n';
  }
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Update ${entity} non id attribute with failure", () { \n';
  if (nonIdAttribute != null) {
    sc = '${sc}      var random${Entity} = ${entities}.random(); \n';
    sc = '${sc}      var beforeUpdateValue = '
         'random${Entity}.${nonIdAttribute.code}; \n';
    sc = '${sc}      var afterUpdateEntity = random${Entity}.copy(); \n';
    var value = genAttributeTextRandomly(nonIdAttribute); 
    sc = '${sc}      afterUpdateEntity.${nonIdAttribute.code} = ${value}; \n';
    sc = '${sc}      expect(afterUpdateEntity.${nonIdAttribute.code}, '
         'equals(${value})); \n'; 
    sc = '${sc}      // ${entities}.update can only be used if oid, code or '
         'id is set. \n';
    sc = '${sc}      expect(() => ${entities}.update(random${Entity}, '
         'afterUpdateEntity), throws); \n';
  } else {
    sc = '${sc}      // no attribute that is not id \n';
  }
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Copy Equality", () { \n';
  sc = '${sc}      var random${Entity} = ${entities}.random(); \n';
  sc = '${sc}      random${Entity}.display(prefix:"before copy: "); \n';
  sc = '${sc}      var random${Entity}Copy = random${Entity}.copy(); \n';
  sc = '${sc}      random${Entity}Copy.display(prefix:"after copy: "); \n';
  sc = '${sc}      expect(random${Entity}, equals(random${Entity}Copy)); \n';
  sc = '${sc}      expect(random${Entity}.oid, equals(random${Entity}Copy.oid)); \n';
  sc = '${sc}      expect(random${Entity}.code, '
       'equals(random${Entity}Copy.code)); \n';
  for (Attribute attribute in entryConcept.attributes) {
    sc = '${sc}      expect(random${Entity}.${attribute.code}, '
         'equals(random${Entity}Copy.${attribute.code})); \n';
  }
  sc = '${sc} \n';
  
  if (idAttribute != null) {
    sc = '${sc}      expect(random${Entity}.id, isNotNull); \n';
    sc = '${sc}      expect(random${Entity}Copy.id, isNotNull); \n';
    sc = '${sc}      expect(random${Entity}.id, equals(random${Entity}Copy.id)); \n';
    sc = '${sc} \n';    
    sc = '${sc}      var idsEqual = false; \n';
    sc = '${sc}      if (random${Entity}.id == random${Entity}Copy.id) { \n';
    sc = '${sc}        idsEqual = true; \n';
    sc = '${sc}      } \n';
    sc = '${sc}      expect(idsEqual, isTrue); \n';
    sc = '${sc} \n';  
    sc = '${sc}      idsEqual = false; \n';
    sc = '${sc}      if (random${Entity}.id.equals(random${Entity}Copy.id)) { \n';
    sc = '${sc}        idsEqual = true; \n';
    sc = '${sc}      } \n';
    sc = '${sc}      expect(idsEqual, isTrue); \n';
  }
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("New ${entity} action undo and redo", () { \n';
  sc = '${sc}      var ${entity}Concept = ${entities}.concept; \n';
  sc = '${sc}      var ${entity}Count = ${entities}.length; \n';
  sc = '${sc}      ${createEntryEntityRandomly(entryConcept, withChildren:false)}';
  sc = '${sc}      expect(${entities}.length, equals(++${entity}Count)); \n';
  sc = '${sc}      ${entities}.remove(${entity}); \n';
  sc = '${sc}      expect(${entities}.length, equals(--${entity}Count)); \n';
  sc = '${sc} \n';  
  sc = '${sc}      var action = new AddAction(session, ${entities}, ${entity}); \n';
  sc = '${sc}      action.doit(); \n';
  sc = '${sc}      expect(${entities}.length, equals(++${entity}Count)); \n';
  sc = '${sc} \n';
  sc = '${sc}      action.undo(); \n';
  sc = '${sc}      expect(${entities}.length, equals(--${entity}Count)); \n';
  sc = '${sc} \n';
  sc = '${sc}      action.redo(); \n';
  sc = '${sc}      expect(${entities}.length, equals(++${entity}Count)); \n';
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("New ${entity} session undo and redo", () { \n';
  sc = '${sc}      var ${entity}Concept = ${entities}.concept; \n';
  sc = '${sc}      var ${entity}Count = ${entities}.length; \n';
  sc = '${sc}      ${createEntryEntityRandomly(entryConcept, withChildren:false)}';
  sc = '${sc}      expect(${entities}.length, equals(++${entity}Count)); \n';
  sc = '${sc}      ${entities}.remove(${entity}); \n';
  sc = '${sc}      expect(${entities}.length, equals(--${entity}Count)); \n';
  sc = '${sc} \n';  
  sc = '${sc}      var action = new AddAction(session, ${entities}, ${entity}); \n';
  sc = '${sc}      action.doit(); \n';
  sc = '${sc}      expect(${entities}.length, equals(++${entity}Count)); \n';
  sc = '${sc} \n';
  sc = '${sc}      session.past.undo(); \n';
  sc = '${sc}      expect(${entities}.length, equals(--${entity}Count)); \n';
  sc = '${sc} \n';
  sc = '${sc}      session.past.redo(); \n';
  sc = '${sc}      expect(${entities}.length, equals(++${entity}Count)); \n';
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("${Entity} update undo and redo", () { \n';
  if (nonIdAttribute != null) {
    sc = '${sc}      var ${entity} = ${entities}.random(); \n';
    var value = genAttributeTextRandomly(nonIdAttribute); 
    sc = '${sc}      var action = new SetAttributeAction(session, '
         '${entity}, "${nonIdAttribute.code}", ${value}); \n';
    sc = '${sc}      action.doit(); \n';
    sc = '${sc} \n';
    sc = '${sc}      session.past.undo(); \n';
    sc = '${sc}      expect(${entity}.${nonIdAttribute.code}, '
         'equals(action.before)); \n';
    sc = '${sc} \n';
    sc = '${sc}      session.past.redo(); \n';
    sc = '${sc}      expect(${entity}.${nonIdAttribute.code}, '
         'equals(action.after)); \n';
  } else {
    sc = '${sc}      // no attribute that is not id \n';
  }
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
 
  sc = '${sc}    test("${Entity} action with multiple undos and redos", () { \n';
  sc = '${sc}      var ${entity}Count = ${entities}.length; \n';
  sc = '${sc}      var ${entity}1 = ${entities}.random(); \n';
  sc = '${sc} \n';  
  sc = '${sc}      var action1 = new RemoveAction(session, ${entities}, '
       '${entity}1); \n';
  sc = '${sc}      action1.doit(); \n';
  sc = '${sc}      expect(${entities}.length, equals(--${entity}Count)); \n';
  sc = '${sc} \n';
  sc = '${sc}      var ${entity}2 = ${entities}.random(); \n';
  sc = '${sc} \n';
  sc = '${sc}      var action2 = new RemoveAction(session, ${entities}, '
       '${entity}2); \n';
  sc = '${sc}      action2.doit(); \n';
  sc = '${sc}      expect(${entities}.length, equals(--${entity}Count)); \n';
  sc = '${sc} \n';
  sc = '${sc}      //session.past.display(); \n';
  sc = '${sc} \n';
  sc = '${sc}      session.past.undo(); \n';
  sc = '${sc}      expect(${entities}.length, equals(++${entity}Count)); \n';
  sc = '${sc} \n';
  sc = '${sc}      session.past.undo(); \n';
  sc = '${sc}      expect(${entities}.length, equals(++${entity}Count)); \n';
  sc = '${sc} \n';
  sc = '${sc}      //session.past.display(); \n';
  sc = '${sc} \n';
  sc = '${sc}      session.past.redo(); \n';
  sc = '${sc}      expect(${entities}.length, equals(--${entity}Count)); \n';
  sc = '${sc} \n';
  sc = '${sc}      session.past.redo(); \n';
  sc = '${sc}      expect(${entities}.length, equals(--${entity}Count)); \n';
  sc = '${sc} \n';
  sc = '${sc}      //session.past.display(); \n';
  sc = '${sc}    }); \n';
  sc = '${sc} \n';  
  
  sc = '${sc}    test("Transaction undo and redo", () { \n';
  sc = '${sc}      var ${entity}Count = ${entities}.length; \n';
  sc = '${sc}      var ${entity}1 = ${entities}.random(); \n';
  sc = '${sc}      var ${entity}2 = ${entities}.random(); \n';
  sc = '${sc}      while (${entity}1 == ${entity}2) { \n'; 
  sc = '${sc}        ${entity}2 = ${entities}.random();  \n';
  sc = '${sc}      } \n';
  sc = '${sc}      var action1 = new RemoveAction(session, ${entities}, '
       '${entity}1); \n';
  sc = '${sc}      var action2 = new RemoveAction(session, ${entities}, '
       '${entity}2); \n';
  sc = '${sc} \n';
  sc = '${sc}      var transaction = '
       'new Transaction("two removes on ${entities}", session); \n';
  sc = '${sc}      transaction.add(action1); \n';
  sc = '${sc}      transaction.add(action2); \n';
  sc = '${sc}      transaction.doit(); \n';
  sc = '${sc}      ${entity}Count = ${entity}Count - 2; \n';   
  sc = '${sc}      expect(${entities}.length, equals(${entity}Count)); \n'; 
  sc = '${sc} \n';
  sc = '${sc}      ${entities}.display(title:"Transaction Done"); \n';
  sc = '${sc} \n';  
  sc = '${sc}      session.past.undo(); \n';
  sc = '${sc}      ${entity}Count = ${entity}Count + 2; \n';
  sc = '${sc}      expect(${entities}.length, equals(${entity}Count)); \n';
  sc = '${sc} \n';
  sc = '${sc}      ${entities}.display(title:"Transaction Undone"); \n';
  sc = '${sc} \n'; 
  sc = '${sc}      session.past.redo(); \n';
  sc = '${sc}      ${entity}Count = ${entity}Count - 2; \n';
  sc = '${sc}      expect(${entities}.length, equals(${entity}Count)); \n';
  sc = '${sc} \n';
  sc = '${sc}      ${entities}.display(title:"Transaction Redone"); \n';
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Transaction with one action error", () { \n';
  sc = '${sc}      var ${entity}Count = ${entities}.length; \n';
  sc = '${sc}      var ${entity}1 = ${entities}.random(); \n';
  sc = '${sc}      var ${entity}2 = ${entity}1; \n';
  sc = '${sc}      var action1 = new RemoveAction(session, ${entities}, '
       '${entity}1); \n';
  sc = '${sc}      var action2 = new RemoveAction(session, ${entities}, '
       '${entity}2); \n';
  sc = '${sc} \n';
  sc = '${sc}      var transaction = new Transaction( \n';
  sc = '${sc}        "two removes on ${entities}, with an error on the second", '
       'session); \n';
  sc = '${sc}      transaction.add(action1); \n';
  sc = '${sc}      transaction.add(action2); \n';
  sc = '${sc}      var done = transaction.doit(); \n';
  sc = '${sc}      expect(done, isFalse); \n';   
  sc = '${sc}      expect(${entities}.length, equals(${entity}Count)); \n'; 
  sc = '${sc} \n';
  sc = '${sc}      //${entities}.display(title:"Transaction with an error"); \n';
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  sc = '${sc}    test("Reactions to ${entity} actions", () { \n';
  sc = '${sc}      var ${entity}Concept = ${entities}.concept; \n';
  sc = '${sc}      var ${entity}Count = ${entities}.length; \n';
  sc = '${sc} \n'; 
  sc = '${sc}      var reaction = new ${Entity}Reaction(); \n';
  sc = '${sc}      expect(reaction, isNotNull); \n';
  sc = '${sc} \n';
  sc = '${sc}      ${domain.codeFirstLetterLower}Domain.startActionReaction(reaction); \n'; 
  sc = '${sc}      ${createEntryEntityRandomly(entryConcept, withChildren:false)}';
  sc = '${sc}      expect(${entities}.length, equals(++${entity}Count)); \n';  
  sc = '${sc}      ${entities}.remove(${entity}); \n';
  sc = '${sc}      expect(${entities}.length, equals(--${entity}Count)); \n';   
  sc = '${sc} \n';  
  sc = '${sc}      var session = ${domain.codeFirstLetterLower}Domain.newSession(); \n';
  sc = '${sc}      var addAction = new AddAction(session, ${entities}, '
       '${entity}); \n';
  sc = '${sc}      addAction.doit(); \n';
  sc = '${sc}      expect(${entities}.length, equals(++${entity}Count)); \n';
  sc = '${sc}      expect(reaction.reactedOnAdd, isTrue); \n';
  sc = '${sc} \n';
  if (nonIdAttribute != null) {
    var value = genAttributeTextRandomly(nonIdAttribute); 
    sc = '${sc}      var setAttributeAction = new SetAttributeAction( \n';
    sc = '${sc}        session, ${entity}, "${nonIdAttribute.code}", ${value}); \n';
    sc = '${sc}      setAttributeAction.doit(); \n';
    sc = '${sc}      expect(reaction.reactedOnUpdate, isTrue); \n';
    sc = '${sc}      ${domain.codeFirstLetterLower}Domain.cancelActionReaction(reaction); \n';   
  } else {
    sc = '${sc}      // no attribute that is not id \n';
  }
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  
  // after the last test
  
  sc = '${sc}  }); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';
  
  sc = '${sc}class ${Entity}Reaction implements ActionReactionApi { \n';
  sc = '${sc}  bool reactedOnAdd    = false; \n'; 
  sc = '${sc}  bool reactedOnUpdate = false; \n';
  sc = '${sc} \n';
  sc = '${sc}  react(BasicAction action) { \n';
  sc = '${sc}    if (action is EntitiesAction) { \n';  
  sc = '${sc}      reactedOnAdd = true; \n';
  sc = '${sc}    } else if (action is EntityAction) { \n';
  sc = '${sc}      reactedOnUpdate = true; \n';
  sc = '${sc}    } \n';
  sc = '${sc}  } \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  sc = '${sc}void main() { \n';
  sc = '${sc}  var repository = new Repository(); \n';
  sc = '${sc}  var ${domain.codeFirstLetterLower}Domain = '
       'repository.getDomainModels("${domain.code}");   \n';
  sc = '${sc}  assert(${domain.codeFirstLetterLower}Domain != null); \n';
  sc = '${sc}  var ${model.codeFirstLetterLower}Model = '
       '${domain.codeFirstLetterLower}Domain.getModelEntries("${model.code}");  \n';
  sc = '${sc}  assert(${model.codeFirstLetterLower}Model != null); \n';
  sc = '${sc}  var ${entities} = '
       '${model.codeFirstLetterLower}Model.${entities}; \n';
  sc = '${sc}  test${domain.code}${model.code}'
       '${entryConcept.codePluralFirstLetterUpper}('
       '${domain.codeFirstLetterLower}Domain, '
       '${model.codeFirstLetterLower}Model, ${entities}); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';
  
  return sc;
}

Attribute findNonIdAttribute(Concept concept) {
  for (Attribute attribute in concept.attributes) {
    if (!attribute.identifier) {
      return attribute;
    }
  }
  return null;
}

Attribute findNonRequiredAttribute(Concept concept) {
  for (Attribute attribute in concept.attributes) {
    if (!attribute.required) {
      return attribute;
    }
  }
  return null;
}

Attribute findRequiredNonIdAttribute(Concept concept) {
  for (Attribute attribute in concept.attributes) {
    if (attribute.required && !attribute.identifier) {
      return attribute;
    }
  }
  return null;
}

Attribute findIdAttribute(Concept concept) {
  for (Attribute attribute in concept.attributes) {
    if (attribute.identifier) {
      return attribute;
    }
  }
  return null;
}





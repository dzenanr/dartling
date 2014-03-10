part of dartling;

String genConceptGen(Concept concept, String library) {
  Model model = concept.model;
  Domain domain = model.domain;

  var sc = 'part of ${library}; \n';
  sc = '${sc} \n';
  sc = '${sc}// lib/gen/${domain.codeLowerUnderscore}'
       '/${model.codeLowerUnderscore}/${concept.codesLowerUnderscore}.dart \n';
  sc = '${sc} \n';
  sc = '${sc}abstract class ${concept.code}Gen extends '
       'ConceptEntity<${concept.code}> { \n';
  sc = '${sc} \n';
  if (concept.children.isEmpty) {
    sc = '${sc}  ${concept.code}Gen(Concept concept) : super.of(concept); \n';
  } else {
    sc = '${sc}  ${concept.code}Gen(Concept concept) : super.of(concept) { \n';
    var generatedConcepts = new List<Concept>();
    for (Child child in concept.children) {
      Concept destinationConcept = child.destinationConcept;
      if (!generatedConcepts.contains(destinationConcept)) {
        generatedConcepts.add(destinationConcept);
        sc = '${sc}    Concept ${destinationConcept.codeFirstLetterLower}'
        'Concept = concept.model.concepts.singleWhereCode('
        '"${destinationConcept.code}"); \n';
      }
      sc = '${sc}    setChild("${child.code}", new ${destinationConcept.codes}('
           '${destinationConcept.codeFirstLetterLower}Concept)); \n';
    }
    sc = '${sc}  } \n';
  }

  sc = '${sc} \n';

  Id id = concept.id;
  if (id.length > 0) {
    sc = '${sc}  ${concept.code}Gen.withId(Concept concept';
    if (id.parentLength > 0) {
      for (Parent parent in concept.parents) {
        if (parent.identifier) {
          Concept destinationConcept = parent.destinationConcept;
          sc = '${sc}, ${destinationConcept.code} ${parent.code}';
        }
      }
    }
    if (id.attributeLength > 0) {
      for (Attribute attribute in concept.attributes) {
        if (attribute.identifier) {
          sc = '${sc}, ${attribute.type.base} ${attribute.code}';
        }
      }
    }
    sc = '${sc}) : super.of(concept) { \n';
    if (id.parentLength > 0) {
      for (Parent parent in concept.parents) {
        if (parent.identifier) {
          sc = '${sc}    setParent("${parent.code}", ${parent.code}); \n';
        }
      }
    }
    if (id.attributeLength > 0) {
      for (Attribute attribute in concept.attributes) {
        if (attribute.identifier) {
          sc = '${sc}    setAttribute("${attribute.code}", '
               '${attribute.code}); \n';
        }
      }
    }
    var generatedConcepts = new List<Concept>();
    for (Child child in concept.children) {
      Concept destinationConcept = child.destinationConcept;
      if (!generatedConcepts.contains(destinationConcept)) {
        generatedConcepts.add(destinationConcept);
        sc = '${sc}    Concept ${destinationConcept.codeFirstLetterLower}'
        'Concept = concept.model.concepts.singleWhereCode('
        '"${destinationConcept.code}"); \n';
      }
      sc = '${sc}    setChild("${child.code}", new ${destinationConcept.codes}('
           '${destinationConcept.codeFirstLetterLower}Concept)); \n';
    }
    sc = '${sc}  } \n';
    sc = '${sc} \n';
  }

  for (Parent parent in concept.parents) {
    Concept destinationConcept = parent.destinationConcept;
    sc = '${sc}  ${destinationConcept.code} get ${parent.code} => '
         'getParent("${parent.code}"); \n ';
    sc = '${sc} set ${parent.code}(${destinationConcept.code} p) => '
         'setParent("${parent.code}", p); \n ';
    sc = '${sc} \n';
  }
  for (Attribute attribute in concept.attributes) {
    sc = '${sc}  ${attribute.type.base} get ${attribute.code} => '
         'getAttribute("${attribute.code}"); \n ';
    sc = '${sc} set ${attribute.code}(${attribute.type.base} a) => '
         'setAttribute("${attribute.code}", a); \n ';
    sc = '${sc} \n';
  }
  for (Child child in concept.children) {
    Concept destinationConcept = child.destinationConcept;
    sc = '${sc}  ${destinationConcept.codes} get ${child.code} => '
         'getChild("${child.code}"); \n ';
    // set child?
    sc = '${sc} \n';
  }

  sc = '${sc}  ${concept.code} newEntity() => new ${concept.code}(concept); \n';
  sc = '${sc}  ${concept.codes} newEntities() => '
       'new ${concept.codes}(concept); \n ';
  sc = '${sc} \n';

  if (id.attributeLength == 1) {
    for (Attribute attribute in concept.attributes) {
      if (attribute.identifier) {
        sc = '${sc}  int ${attribute.code}CompareTo(${concept.code} other) { \n';
        if (attribute.type.code == 'Uri') {
          sc = '${sc}    return ${attribute.code}.toString().compareTo('
          'other.${attribute.code}.toString()); \n';
        } else {
          sc = '${sc}    return ${attribute.code}.compareTo('
          'other.${attribute.code}); \n';
        }
        sc = '${sc}  } \n';
        sc = '${sc} \n';
      }
    }
  }

  sc = '${sc}} \n';
  sc = '${sc} \n';

  sc = '${sc}abstract class ${concept.codes}Gen extends '
       'Entities<${concept.code}> { \n';
  sc = '${sc} \n';
  sc = '${sc}  ${concept.codes}Gen(Concept concept) : super.of(concept); \n';
  sc = '${sc} \n';
  sc = '${sc}  ${concept.codes} newEntities() => '
       'new ${concept.codes}(concept); \n';
  sc = '${sc}  ${concept.code} newEntity() => new ${concept.code}(concept); \n ';
  sc = '${sc} \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}

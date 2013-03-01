part of dartling;

String genInitDomainModel(Model model, String library) {
  Domain domain = model.domain;

  var sc = 'part of ${library}; \n';
  sc = '${sc} \n';
  sc = '${sc}// lib/${domain.codeLowerUnderscore}/'
       '${model.codeLowerUnderscore}/init.dart \n';
  sc = '${sc} \n';
  sc = '${sc}init${domain.code}${model.code}(var entries) { \n';
  for (Concept entryConcept in model.entryConcepts) {
    sc = '${sc}  _init${entryConcept.codes}(entries); \n';
  }
  sc = '${sc}} \n';
  sc = '${sc} \n';

  for (Concept entryConcept in model.entryConcepts) {
    sc = '${sc}_init${entryConcept.codes}(var entries) { \n';
    sc = '${sc}  ${entryConcept.code} ${entryConcept.codeFirstLetterLower} = ';
    sc = '${sc}new ${entryConcept.code}';
    sc = '${sc}(entries.${entryConcept.codesFirstLetterLower}.concept); \n';
    for (var attribute in entryConcept.attributes) {
      if (attribute.type.code == 'String') {
        sc = '  ${sc}  ${entryConcept.codeFirstLetterLower}.${attribute.code} = ';
        sc = '${sc}"${attribute.code} value"; \n';
      }
    }
    sc = '${sc}  entries.${entryConcept.codesFirstLetterLower}.';
    sc = '${sc}add(${entryConcept.codeFirstLetterLower}); \n';
    sc = '${sc} \n';
    sc = '${sc}} \n';
    sc = '${sc} \n';
  }

  return sc;
}

String genConcept(Concept concept, String library) {
  Model model = concept.model;
  Domain domain = model.domain;

  var sc = 'part of ${library}; \n';
  sc = '${sc} \n';
  sc = '${sc}// lib/${domain.codeLowerUnderscore}/'
       '${model.codeLowerUnderscore}/${concept.codesLowerUnderscore}.dart \n';
  sc = '${sc} \n';
  sc = '${sc}class ${concept.code} extends ${concept.code}Gen { \n';
  sc = '${sc} \n';
  sc = '${sc}  ${concept.code}(Concept concept) : super(concept); \n';
  sc = '${sc} \n';

  Id id = concept.id;
  if (id.length > 0) {
    sc = '${sc}  ${concept.code}.withId(Concept concept';
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
    sc = '${sc}) : \n';
    sc = '${sc}    super.withId(concept';
    if (id.parentLength > 0) {
      for (Parent parent in concept.parents) {
        if (parent.identifier) {
          sc = '${sc}, ${parent.code}';
        }
      }
    }
    if (id.attributeLength > 0) {
      for (Attribute attribute in concept.attributes) {
        if (attribute.identifier) {
          sc = '${sc}, ${attribute.code}';
        }
      }
    }
    sc = '${sc}); \n';
    sc = '${sc} \n';
  }

  sc = '${sc}} \n';
  sc = '${sc} \n';

  sc = '${sc}class ${concept.codes} extends ${concept.codes}Gen { \n';
  sc = '${sc} \n';
  sc = '${sc}  ${concept.codes}(Concept concept) : super(concept); \n';
  sc = '${sc} \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}

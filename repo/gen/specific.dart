
String genSpecificInitDomainModelData(Model model) {
  Domain domain = model.domain;
  var sc = ' \n';
  sc = '${sc}// repo/code/specific/${domain.codeLowerUnderscore}/'
       '${model.codeLowerUnderscore}/init.dart \n';
  sc = '${sc} \n';
  sc = '${sc}init${domain.code}${model.code}(var entries) { \n';
  for (Concept entryConcept in model.entryConcepts) {
    sc = '${sc}   //_init${entryConcept.codes}(); \n';
  }
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}

String genSpecificConcept(Concept concept) {
  Model model = concept.model;
  Domain domain = model.domain;
  var sc = ' \n';
  sc = '// repo/code/specific/${domain.codeLowerUnderscore}/'
       '${model.codeLowerUnderscore}/${concept.codesLowerUnderscore}.dart \n';
  sc = '${sc} \n';
  sc = '${sc}class ${concept.code} extends ${concept.code}Gen { \n';
  sc = '${sc} \n';
  sc = '${sc}  ${concept.code}(Concept concept) : super(concept); \n';
  sc = '${sc} \n';

  Id id = concept.id;
  if (id.count > 0) {
    sc = '${sc}  ${concept.code}.withId(Concept concept';
    if (id.parentCount > 0) {
      for (Parent parent in concept.parents) {
        if (parent.identifier) {
          Concept destinationConcept = parent.destinationConcept;
          sc = '${sc}, ${destinationConcept.code} ${parent.code}';
        }
      }
    }
    if (id.attributeCount > 0) {
      for (Attribute attribute in concept.attributes) {
        if (attribute.identifier) {
          sc = '${sc}, ${attribute.type.base} ${attribute.code}';
        }
      }
    }
    sc = '${sc}) : \n';
    sc = '${sc}    super.withId(concept';
    if (id.parentCount > 0) {
      for (Parent parent in concept.parents) {
        if (parent.identifier) {
          sc = '${sc}, ${parent.code}';
        }
      }
    }
    if (id.attributeCount > 0) {
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

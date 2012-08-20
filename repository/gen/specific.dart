
String genSpecificConcept(String domain, String model, Concept concept) {
  var sc = ' \n';
  sc = '// specific/${domain}/${model}'
       '/${concept.codeInPlural.toLowerCase()}.dart \n';
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
    sc = '${sc}) : super.withId(concept';
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

  sc = '${sc}class ${concept.codeInPlural} extends ${concept.codeInPlural}Gen { \n';
  sc = '${sc} \n';
  sc = '${sc}  ${concept.codeInPlural}(Concept concept) : super(concept); \n';
  sc = '${sc} \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}

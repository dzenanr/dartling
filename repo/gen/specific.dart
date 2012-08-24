
String genSpecificDomainModelRepository(String domainCode, Model model) {
  var sc = ' \n';
  sc = '${sc}// repo/code/specific/${domainCode.toLowerCase()}/'
       '${model.code.toLowerCase()}/repository.dart \n';
  sc = '${sc} \n';
  sc = '${sc}class ${domainCode}${model.code}Repo extends DartlingRepo { \n';
  sc = '${sc} \n';
  sc = '${sc}  ${model.code}Entries entries; \n';
  sc = '${sc} \n';
  sc = '${sc}  ${domainCode}${model.code}Repo('
       '[String code="${domainCode}${model.code}"]) : super(code); \n';
  sc = '${sc} \n';
  sc = '${sc}  init() { \n';
  sc = '${sc}    var models = getDomainModels(DartlingRepo.'
       '${domainCode.toLowerCase()}DomainCode); \n';
  sc = '${sc}    entries = models.getModelEntries(DartlingRepo.'
       '${domainCode.toLowerCase()}${model.code}ModelCode); \n';
  sc = '${sc} \n';
  for (Concept entryConcept in model.entryConcepts) {
    sc = '${sc}   //_init${entryConcept.codeInPlural}(); \n';
  }
  sc = '${sc}  } \n';
  sc = '${sc} \n';
  sc = '${sc}  display() { \n';
  for (Concept entryConcept in model.entryConcepts) {
    sc = '${sc}    entries.${entryConcept.codeInPlural.toLowerCase()}.'
         'display("${entryConcept.codeInPlural}"); \n';
  }
  sc = '${sc}  } \n';

  sc = '${sc} \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}

String genSpecificConcept(String domain, String model, Concept concept) {
  var sc = ' \n';
  sc = '// repo/code/specific/${domain}/${model}'
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

  sc = '${sc}class ${concept.codeInPlural} extends ${concept.codeInPlural}Gen { \n';
  sc = '${sc} \n';
  sc = '${sc}  ${concept.codeInPlural}(Concept concept) : super(concept); \n';
  sc = '${sc} \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}

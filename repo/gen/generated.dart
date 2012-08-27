

String genGeneratedRepository(Domain domain) {
  var sc = ' \n';
  sc = '${sc}// repo/code/generated/${domain.codeWithCamelCaseInLowerCaseUnderscore}/'
       'repository.dart \n';
  sc = '${sc} \n';
  sc = '${sc}class ${domain.code}Repo extends Repo { \n';
  sc = '${sc} \n';
  sc = '${sc}  static final ${domain.codeWithFirstLetterInLowerCase}DomainCode = '
       '"${domain.code}"; \n';
  for (Model model in domain.models) {
    sc = '${sc}  static final ${domain.codeWithFirstLetterInLowerCase}'
         '${model.code}ModelCode = "${model.code}"; \n';
  }
  sc = '${sc} \n';
  sc = '${sc}  ${domain.code}Repo([String code="${domain.code}Repo"]) : '
       'super(code) { \n';
  sc = '${sc}    _init${domain.code}Domain(); \n';
  sc = '${sc}  } \n';
  sc = '${sc} \n';

  sc = '${sc}  _init${domain.code}Domain() { \n';
  sc = '${sc}    var ${domain.codeWithFirstLetterInLowerCase}Domain = '
       'new Domain(${domain.codeWithFirstLetterInLowerCase}DomainCode); \n';
  sc = '${sc}    domains.add(${domain.codeWithFirstLetterInLowerCase}'
       'Domain); \n';
  sc = '${sc}    add(new ${domain.code}Models('
       '${domain.codeWithFirstLetterInLowerCase}Domain)); \n';
  sc = '${sc}  } \n';

  sc = '${sc} \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}

String genGeneratedModels(Domain domain) {
  var sc = ' \n';
  sc = '${sc}// repo/code/generated/${domain.codeWithCamelCaseInLowerCaseUnderscore}/'
       'models.dart \n';
  sc = '${sc} \n';
  sc = '${sc}class ${domain.code}Models extends DomainModels { \n';
  sc = '${sc} \n';
  sc = '${sc}  ${domain.code}Models(Domain domain) : super(domain) { \n';
  for (Model model in domain.models) {
    sc = '${sc}    add(fromJsonTo${model.code}Entries()); \n';
  }
  sc = '${sc}  } \n';
  sc = '${sc} \n';

  for (Model model in domain.models) {
    sc = '${sc}  ${model.code}Entries fromJsonTo${model.code}Entries() { \n';
    sc = '${sc}    return new ${model.code}Entries(fromMagicBoxes( \n';
    sc = '${sc}      ${domain.codeWithFirstLetterInLowerCase}${model.code}'
         'ModelInJson, \n';
    sc = '${sc}      domain, \n';
    sc = '${sc}      DartlingRepo.${domain.codeWithFirstLetterInLowerCase}'
         '${model.code}ModelCode)); \n';
    sc = '${sc}  } \n';
    sc = '${sc} \n';
  }

  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}


String genGeneratedEntries(Domain domain, Model model) {
  var sc = ' \n';
  sc = '${sc}// repo/code/generated/${domain.codeWithCamelCaseInLowerCaseUnderscore}/'
       '${model.codeWithCamelCaseInLowerCaseUnderscore}/entries.dart \n';
  sc = '${sc} \n';
  sc = '${sc}class ${model.code}Entries extends ModelEntries { \n';
  sc = '${sc} \n';
  sc = '${sc}  ${model.code}Entries(Model model) : super(model); \n';
  sc = '${sc} \n';
  sc = '${sc}  Map<String, Entities> newEntries() { \n';
  sc = '${sc}    var entries = new Map<String, Entities>(); \n';
  sc = '${sc}    var concept; \n';
  for (Concept entryConcept in model.entryConcepts) {
    var concept = model.concepts.findByCode('Project');
    sc = '${sc}    concept = model.concepts.findByCode('
         '"${entryConcept.code}"); \n';
    sc = '${sc}    entries["${entryConcept.code}"] = '
         'new ${entryConcept.codeInPlural}(concept); \n';
  }
  sc = '${sc}    return entries; \n';
  sc = '${sc}  } \n';
  sc = '${sc} \n';

  sc = '${sc}  Entities newEntities(String conceptCode) { \n';
  sc = '${sc}    var concept = model.concepts.findByCode(conceptCode); \n';
  sc = '${sc}    if (concept == null) { \n';
  sc = '${sc}      throw new ConceptException('
       '"\${conceptCode} concept does not exist.") ; \n';
  sc = '${sc}    } \n';
  for (Concept concept in model.concepts) {
    sc = '${sc}    if (concept.code == "${concept.code}") { \n';
    sc = '${sc}      return new ${concept.codeInPlural}(concept); \n';
    sc = '${sc}    } \n';
  }
  sc = '${sc}  } \n';
  sc = '${sc} \n';

  sc = '${sc}  ConceptEntity newEntity(String conceptCode) { \n';
  sc = '${sc}    var concept = model.concepts.findByCode(conceptCode); \n';
  sc = '${sc}    if (concept == null) { \n';
  sc = '${sc}      throw new ConceptException('
       '"\${conceptCode} concept does not exist.") ; \n';
  sc = '${sc}    } \n';
  for (Concept concept in model.concepts) {
    sc = '${sc}    if (concept.code == "${concept.code}") { \n';
    sc = '${sc}      return new ${concept.code}(concept); \n';
    sc = '${sc}    } \n';
  }
  sc = '${sc}  } \n';
  sc = '${sc} \n';

  sc = '${sc}  fromJsonToData() { \n';
  sc = '${sc}    fromJson(${domain.code}${model.code}DataInJson); \n';
  sc = '${sc}  } \n';
  sc = '${sc} \n';

  for (Concept entryConcept in model.entryConcepts) {
    sc = '${sc}  ${entryConcept.codeInPlural} get '
         '${entryConcept.camelCaseToLowerCaseUnderscore(entryConcept.codeInPlural)}'
         '() => getEntry("${entryConcept.code}"); \n';
  }

  sc = '${sc} \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}

String genGeneratedConcept(Domain domain, Model model, Concept concept) {
  var sc = ' \n';
  sc = '${sc}// repo/code/generated/'
       '${domain.codeWithCamelCaseInLowerCaseUnderscore}/'
       '${model.codeWithCamelCaseInLowerCaseUnderscore}'
       '/${concept.camelCaseToLowerCaseUnderscore(concept.codeInPlural)}.dart \n';
  sc = '${sc} \n';
  sc = '${sc}abstract class ${concept.code}Gen extends '
       'ConceptEntity<${concept.code}> { \n';
  sc = '${sc} \n';
  if (concept.children.empty) {
    sc = '${sc}  ${concept.code}Gen(Concept concept) : super.of(concept); \n';
  } else {
    sc = '${sc}  ${concept.code}Gen(Concept concept) : super.of(concept) { \n';
    for (Child child in concept.children) {
      Concept destinationConcept = child.destinationConcept;
      sc = '${sc}    Concept ${destinationConcept.codeWithFirstLetterInLowerCase}'
           'Concept = '
           'concept.model.concepts.findByCode("${destinationConcept.code}"); \n';
      sc = '${sc}    setChild("${child.code}", '
           'new ${destinationConcept.codeInPlural}('
           '${destinationConcept.codeWithFirstLetterInLowerCase}Concept)); \n';
    }
    sc = '${sc}  } \n';
  }

  sc = '${sc} \n';

  Id id = concept.id;
  if (id.count > 0) {
    sc = '${sc}  ${concept.code}Gen.withId(Concept concept';
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
    sc = '${sc}) : super.of(concept) { \n';
    if (id.parentCount > 0) {
      for (Parent parent in concept.parents) {
        if (parent.identifier) {
          sc = '${sc}    setParent("${parent.code}", ${parent.code}); \n';
        }
      }
    }
    if (id.attributeCount > 0) {
      for (Attribute attribute in concept.attributes) {
        if (attribute.identifier) {
          sc = '${sc}    setAttribute("${attribute.code}", '
               '${attribute.code}); \n';
        }
      }
    }
    for (Child child in concept.children) {
      Concept destinationConcept = child.destinationConcept;
      sc = '${sc}    Concept ${destinationConcept.codeWithFirstLetterInLowerCase}'
           'Concept = '
           'concept.model.concepts.findByCode("${destinationConcept.code}"); \n';
      sc = '${sc}    setChild("${child.code}", '
           'new ${destinationConcept.codeInPlural}('
           '${destinationConcept.codeWithFirstLetterInLowerCase}Concept)); \n';
    }
    sc = '${sc}  } \n';
    sc = '${sc} \n';
  }

  for (Parent parent in concept.parents) {
    Concept destinationConcept = parent.destinationConcept;
    sc = '${sc}  ${destinationConcept.code} get ${parent.code}() => '
    'getParent("${parent.code}"); \n ';
    sc = '${sc} set ${parent.code}(${destinationConcept.code} p) => '
    'setParent("${parent.code}", p); \n ';
    sc = '${sc} \n';
  }
  for (Attribute attribute in concept.attributes) {
    sc = '${sc}  ${attribute.type.base} get ${attribute.code}() => '
    'getAttribute("${attribute.code}"); \n ';
    sc = '${sc} set ${attribute.code}(${attribute.type.base} a) => '
    'setAttribute("${attribute.code}", a); \n ';
    sc = '${sc} \n';
  }
  for (Child child in concept.children) {
    Concept destinationConcept = child.destinationConcept;
    sc = '${sc}  ${destinationConcept.codeInPlural} get ${child.code}() => '
    'getChild("${child.code}"); \n ';
    /*
    sc = '${sc} set ${child.code}(${destinationConcept.codeInPlural} p) => '
    'setChild("${child.code}", p); \n ';
    */
    sc = '${sc} \n';
  }

  sc = '${sc}  ${concept.code} newEntity() => new ${concept.code}(concept); \n ';
  sc = '${sc} \n';

  if (id.attributeCount == 1) {
    for (Attribute attribute in concept.attributes) {
      if (attribute.identifier) {
        sc = '${sc}  int ${attribute.code}CompareTo(${concept.code} other) { \n';
        sc = '${sc}    return ${attribute.code}.compareTo('
             'other.${attribute.code}); \n';
        sc = '${sc}  } \n';
        sc = '${sc} \n';
      }
    }
  }

  sc = '${sc}} \n';
  sc = '${sc} \n';

  sc = '${sc}abstract class ${concept.codeInPlural}Gen extends '
       'Entities<${concept.code}> { \n';
  sc = '${sc} \n';
  sc = '${sc}  ${concept.codeInPlural}Gen(Concept concept) : '
       'super.of(concept); \n';
  sc = '${sc} \n';
  sc = '${sc}  ${concept.codeInPlural} newEntities() => '
       'new ${concept.codeInPlural}(concept); \n ';
  sc = '${sc} \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}
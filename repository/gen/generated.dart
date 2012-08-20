

String genGeneratedRepository(Repo repo) {
  var sc = ' \n';
  sc = '${sc}// code generated for the ${repo.code} repository \n';
  sc = '${sc} \n';
  sc = '${sc}// generated/repository.dart \n';
  sc = '${sc} \n';
  sc = '${sc}class ${repo.code}Repo extends Repo { \n';
  sc = '${sc} \n';
  for (Domain domain in repo.domains) {
    sc = '${sc}  static final ${domain.code.toLowerCase()}DomainCode = '
         '"${domain.code}"; \n';
    for (Model model in domain.models) {
      sc = '${sc}  static final ${domain.code.toLowerCase()}'
           '${model.code}ModelCode = "${model.code}"; \n';
    }
    sc = '${sc} \n';
  }
  sc = '${sc}  ${repo.code}Repo([String code="Dartling"]) : '
       'super(code, new Domains()) { \n';
  sc = '${sc}    _init(); \n';
  sc = '${sc}  } \n';
  sc = '${sc} \n';

  for (Domain domain in repo.domains) {
    sc = '${sc}  _ini${domain.code}Domain() { \n';
    sc = '${sc}    var ${domain.code.toLowerCase()}Domain = '
         'new Domain(${domain.code.toLowerCase()}DomainCode); \n';
    sc = '${sc}    domains.add(${domain.code.toLowerCase()}Domain); \n';
    sc = '${sc}    add(new ${domain.code}Models('
         '${domain.code.toLowerCase()}Domain)); \n';
    sc = '${sc}  } \n';
    sc = '${sc} \n';
  }

  sc = '${sc}  _init() { \n';
  for (Domain domain in repo.domains) {
    sc = '${sc}    _init${domain.code}Domain(); \n';
  }
  sc = '${sc}  } \n';


  sc = '${sc} \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}

String genGeneratedModels(Domain domain) {
  var sc = ' \n';
  sc = '${sc}// generated/${domain.code.toLowerCase()}/models.dart \n';
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
    sc = '${sc}      ${domain.code.toLowerCase()}${model.code}ModelInJson, \n';
    sc = '${sc}      domain, \n';
    sc = '${sc}      DartlingRepo.${domain.code.toLowerCase()}'
         '${model.code}ModelCode)); \n';
    sc = '${sc}  } \n';
    sc = '${sc} \n';
  }

  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}


String genGeneratedEntries(String domain, Model model) {
  var sc = ' \n';
  sc = '${sc}// generated/${domain}/${model.code.toLowerCase()}/entries.dart \n';
  sc = '${sc} \n';
  sc = '${sc}class ${model.code}Entries extends ModelEntries { \n';
  sc = '${sc} \n';
  sc = '${sc}  ${model.code}Entries(Model model) : super(model); \n';
  sc = '${sc} \n';
  sc = '${sc}  Map<String, Entities> newEntries() { \n';
  sc = '${sc}    var entries = new Map<String, Entities>(); \n';
  for (Concept entryConcept in model.entryConcepts) {
    var concept = model.concepts.findByCode('Project');
    sc = '${sc}    var concept = model.concepts.findByCode('
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

  sc = '${sc}  Entity newEntity(String conceptCode) { \n';
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
  sc = '${sc}    fromJson(${domain}${model.code}DataInJson); \n';
  sc = '${sc}  } \n';
  sc = '${sc} \n';

  for (Concept entryConcept in model.entryConcepts) {
    sc = '${sc}  ${entryConcept.codeInPlural} get '
         '${entryConcept.codeInPlural.toLowerCase()}() => '
         'getEntry("${entryConcept.code}"); \n';
  }

  sc = '${sc} \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}

String genGeneratedConcept(String domain, String model, Concept concept) {
  var sc = ' \n';
  sc = '${sc}// generated/${domain}/${model}'
       '/${concept.codeInPlural.toLowerCase()}.dart \n';
  sc = '${sc} \n';
  sc = '${sc}abstract class ${concept.code}Gen extends '
       'Entity<${concept.code}> { \n';
  sc = '${sc} \n';
  sc = '${sc}  ${concept.code}Gen(Concept concept) : super.of(concept); \n';
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
          sc = '${sc}    setAttribute("${attribute.code}", ${attribute.code}); \n';
        }
      }
    }
    sc = '${sc}  } \n';
    sc = '${sc} \n';
  }

  if (id.parentCount > 0) {
    for (Parent parent in concept.parents) {
      Concept destinationConcept = parent.destinationConcept;
      sc = '${sc}  ${destinationConcept.code} get ${parent.code}() => '
           'getParent("${parent.code}"); \n ';
      sc = '${sc} set ${parent.code}(${destinationConcept.code} p) => '
           'setParent("${parent.code}, p"); \n ';
      sc = '${sc} \n';
    }
  }
  if (id.attributeCount > 0) {
    for (Attribute attribute in concept.attributes) {
      sc = '${sc}  ${attribute.type.base} get ${attribute.code}() => '
           'getAttribute("${attribute.code}"); \n ';
      sc = '${sc} set ${attribute.code}(${attribute.type.base} a) => '
           'setAttribute("${attribute.code}, a"); \n ';
      sc = '${sc} \n';
    }
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

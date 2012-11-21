part of default_project;

// data/gen/default/project/entries.dart

class ProjectEntries extends ModelEntries {

  ProjectEntries(Model model) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept;
    concept = model.concepts.findByCode("Project");
    entries["Project"] = new Projects(concept);
    return entries;
  }

  Entities newEntities(String conceptCode) {
    var concept = model.concepts.findByCode(conceptCode);
    if (concept == null) {
      throw new ConceptError("${conceptCode} concept does not exist.") ;
    }
    if (concept.code == "Project") {
      return new Projects(concept);
    }
  }

  ConceptEntity newEntity(String conceptCode) {
    var concept = model.concepts.findByCode(conceptCode);
    if (concept == null) {
      throw new ConceptError("${conceptCode} concept does not exist.") ;
    }
    if (concept.code == "Project") {
      return new Project(concept);
    }
  }

  fromJsonToData() {
    fromJson(defaultProjectDataJson);
  }

  Projects get projects => getEntry("Project");

}
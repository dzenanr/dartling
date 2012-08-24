
class ProjectEntries extends ModelEntries {

  ProjectEntries(Model model) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept = model.concepts.findByCode('Project');
    entries[concept.code] = new Projects(concept);
    return entries;
  }

  Entities newEntities(String conceptCode) {
    var concept = model.concepts.findByCode(conceptCode);
    if (concept == null) {
      throw new ConceptException('${concept.code} concept does not exist.');
    }
    if (concept.code == 'Project') {
      return new Projects(concept);
    }
  }

  ConceptEntity newEntity(String conceptCode) {
    var concept = model.concepts.findByCode(conceptCode);
    if (concept == null) {
      throw new ConceptException('${concept.code} concept does not exist.');
    }
    if (concept.code == 'Project') {
      return new Project(concept);
    }
  }

  fromJsonToData() {
    fromJson(defaultProjectDataInJson);
  }

  Projects get projects() => getEntry('Project');

}





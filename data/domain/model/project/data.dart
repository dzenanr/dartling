
class ProjectData extends ModelData {

  ProjectData(Model model) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept = model.concepts.findByCode('Project');
    entries[concept.code] = new Projects(concept);
    return entries;
  }

  Projects get projects() => getEntry('Project');

  Concept get projectConcept() => projects.concept;

}
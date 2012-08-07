
class ProjectEntry extends Entry {

  ProjectEntry(Domain domain) : super(domain);

  Map<String, Data> newData() {
    var data = new Map<String, Data>();
    var model = domain.models.getEntityByCode('default');
    data[model.code] = new ProjectData(model, this);
    return data;
  }

  ProjectData get data() => getData('default');

}

class ProjectData extends Data {

  ProjectEntry entry;

  ProjectData(Model model, this.entry) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept = model.concepts.getEntityByCode('Project');
    entries[concept.code] = new Projects(concept);
    return entries;
  }

  Projects get projects() => getEntry('Project');

  Concept get projectConcept() => projects.concept;

}
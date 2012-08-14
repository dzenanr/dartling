
ProjectEntries fromJsonToProjectEntries(Domain domain, String modelCode) {
  /**
   *  || Project
   *  id name
   *  at description
   */
  var modelInJson = '''
      {"width":990,"height":580,
       "lines":[],
       "boxes":[
        {"entry":true,"name":"Project",
         "x":179,"y":226,"width":120,"height":120,
         "items":[
          {"sequence":10,"category":"identifier","name":"name",
           "type":"String","init":""
          },
          {"sequence":20,"category":"attribute","name":"description",
           "type":"String","init":""
          }]
        }]
      }
  ''';
  return new ProjectEntries(fromMagicBoxes(modelInJson, domain, modelCode));
}

class ProjectEntries extends ModelEntries {

  ProjectEntries(Model model) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept = model.concepts.findByCode('Project');
    entries[concept.code] = new Projects(concept);
    return entries;
  }

  Entity newEntity(String conceptCode) {
    var concept = model.concepts.findByCode(conceptCode);
    if (concept.code == 'Project') {
      return new Project(concept);
    } else {
      throw new ConceptException('${concept.code} concept does not exist.');
    }
  }

  Projects get projects() => getEntry('Project');

  Concept get projectConcept() => projects.concept;

}
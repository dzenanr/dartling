
ProjectData fromJsonToProjectData(Domain domain, [String modelCode = 'default']) {
  /**
   *  || Project
   *  id name
   *  at description
   */
  var _json = '''
      {"width":990,"height":580,"lines":[],
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
  return new ProjectData(fromMagicBoxes(_json, domain, modelCode));
}

class ProjectData extends ModelEntries {

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
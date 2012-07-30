
class ProjectData {

  Concept projectConcept;

  Projects projects;

  /**
   *  || Project
   *  id name
   *  at description
   */
  var _json = '''
      {"width":990,"lines":[],"height":580,"boxes":[{"entry":true,
      "name":"Project","x":179,"y":226,"width":120,"height":120,
      "items":[{"sequence":10,"category":"identifier","name":"name",
      "type":"String","init":""},{"sequence":20,"category":"attribute",
      "name":"description","type":"String","init":""}]}]}
  ''';

  ProjectData() {
    Domain domain = fromMagicBoxes(_json);
    Model model = domain.model;
    projectConcept = model.concepts.getEntityByCode('Project');
    projects = new Projects(projectConcept);
  }

}

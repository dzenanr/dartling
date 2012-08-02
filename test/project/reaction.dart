
class ProjectReaction implements Reaction {

  String name;
  bool reacted = false;

  var projects;

  ProjectReaction(this.name, this.projects);

  addProject(String projectName) {
    var project = new Project(projects.concept);
    project.name = projectName;

    projects.start(this);
    projects.add(project);
    projects.cancel(this);

    assert(projects.getEntityByAttribute('name', projectName) != null);
  }

  updateProjectDescription(String projectName, String projectDescription) {
    var project = projects.getEntityByAttribute('name', projectName);
    assert(project != null);

    project.start(this);
    project.description = projectDescription;
    project.cancel(this);
  }

  react(Action action) {
    if (action is EntitiesAction) {
      Projects ps = action.entities;
      if (ps.errors.count > 0) {
        ps.errors.display();
      } else {
        ps.display('Projects with Reaction');
      }
    } else if (action is EntityAction) {
      Project p = action.entity;
      print('Dartling Project with After Update Description');
      print('');
      p.display();
    }
    print('!!! Action Reaction for ${projects.concept.pluralName} by $name !!!');
    print('');
    print('$action');
    print('');
    reacted = true;
  }

}


class ProjectReaction implements ActionReaction {

  String name;
  bool reactedOnAdd = false;
  bool reactedOnUpdate = false;

  var projects;

  ProjectReaction(this.name, this.projects);

  addProject(String projectName) {
    var project = new Project(projects.concept);
    project.name = projectName;

    projects.startReaction(this);
    projects.add(project);
    projects.cancelReaction(this);

    projects.lastAction.undo();
    projects.lastAction.undo();

    assert(projects.getEntityByAttribute('name', projectName) != null);
  }

  updateProjectDescription(String projectName, String projectDescription) {
    var project = projects.getEntityByAttribute('name', projectName);
    assert(project != null);

    project.startReaction(this);
    project.description = projectDescription;
    project.cancelReaction(this);
  }

  react(Action action) {
    if (action is EntitiesAction) {
      Projects ps = action.entities;
      if (ps.errors.count > 0) {
        ps.errors.display();
      } else {
        ps.display('Projects with Reaction');
        reactedOnAdd = true;
      }
    } else if (action is EntityAction) {
      Project p = action.entity;
      print('Dartling Project with After Update Description');
      print('');
      p.display();
      reactedOnUpdate = true;
    }
    print('!!! Action Reaction for ${projects.concept.pluralName} by $name !!!');
    print('');
    print('$action');
    print('');
  }

}

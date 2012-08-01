
class ProjectReactor implements Reactor {
  
  String name;
  bool reacted = false;
  
  var projects;
  
  ProjectReactor(this.name, this.projects);
  
  addProject(String projectName) {
    var project = new Project(projects.concept);
    project.accept(this);
    project.name = projectName;
    
    Action aa = new Action('create');
    aa.description = 'Project with the ${project.name} name created.';
    aa.entity = project;
    project.notifyReactors(aa);
    project.cancel(this);
    
    projects.accept(this);
    projects.add(project);
    assert(projects.getEntityByAttribute('name', projectName) != null);
    
    Action esa = new Action('add');
    esa.description = 'Project with the ${project.name} name added.';
    esa.entities = projects;
    esa.entity = project;
    projects.notifyReactors(esa);
    projects.cancel(this);
  }
  
  react(Action action) {
    Project p = action.entity;
    Projects ps = action.entities;
    if (ps != null) {
      if (ps.errors.count > 0) {
        ps.errors.display();
      } else {
        ps.display('Projects with Reaction');
      }
    }
    print('!!! Action Reaction for ${projects.concept.pluralName} by $name !!!');
    print('');
    print('$action');
    reacted = true;
  }
  
}

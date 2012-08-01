
class ProjectReporter implements Listener {
  
  String name;
  bool reacted = false;
  
  var projects;
  
  ProjectReporter(this.name, this.projects) {
    projects.accept(this);
  }
  
  addProject(String projectName) {
    var project = new Project(projects.concept);
    project.name = projectName;
    projects.add(project);
    projects.notifyListeners('Project with the ${project.name} name added.');
  }
  
  react(Projects source, Object message) {
    if (projects.errors.count > 0) {
      projects.errors.display();
    } else {
      projects.display('Projects');
    }
    print('!!! Event Reporting for ${source.concept.pluralName} by $name !!!');
    print('');
    print('Event: $message');
    source.cancel(this);
    reacted = true;
  }
  
}

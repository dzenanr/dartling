part of default_project; 
 
// lib/default/project/projects.dart 
 
class Project extends ProjectGen { 
 
  Project(Concept concept): super(concept); 
 
  Project.withId(Concept concept, String name): super.withId(concept, name); 
 
  // added after code gen - begin 
  
  bool get onProgramming =>
      description.contains('Programming') || 
      description.contains('programming') ? true : false;
 
  // added after code gen - end 
 
} 
 
class Projects extends ProjectsGen { 
  
  Projects(Concept concept): super(concept);
 
  // added after code gen - begin 
 
  Project findByNameId(String name) {
    return singleWhereId(new Id(concept)..setAttribute('name', name));
  }

  bool preAdd(Project project) {
    bool validation = super.preAdd(project);
    if (validation) {
      validation = project.name.length <= 32;
      if (!validation) {
        var error = new ValidationException('pre');
        error.message =
            '${concept.codePlural}.preAdd rejects the "${project.name}" '
            'name that is longer than 32.';
        exceptions.add(error);
      }
    }
    return validation;
  }

  // added after code gen - end 
 
} 
 

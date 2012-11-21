part of default_project;

// data/default/project/projects.dart

class Project extends ProjectGen {

  Project(Concept concept) : super(concept);

  Project.withId(Concept concept, String name) :
    super.withId(concept, name);

  bool get onProgramming =>
      description.contains('Programming') ? true : false;

}

class Projects extends ProjectsGen {

  Projects(Concept concept) : super(concept);

  Project findByNameId(String name) {
    return findById(new Id(concept)..setAttribute('name', name));
  }

  bool preAdd(Project project) {
    bool validation = super.preAdd(project);
    if (validation) {
      validation = project.name.length <= 32;
      if (!validation) {
        var error = new ValidationError('pre');
        error.message =
            '${concept.codePlural}.preAdd rejects the "${project.name}" '
            'name that is longer than 32.';
        errors.add(error);
      }
    }
    return validation;
  }

}


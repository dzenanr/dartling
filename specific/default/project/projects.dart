
class Project extends ProjectGen {

  Project(Concept concept) : super(concept);

  Project.withId(Concept concept, String name) : super.withId(concept, name);

  bool get onProgramming() =>
      description.contains('Programming') ? true : false;

}

class Projects extends ProjectsGen {

  Projects(Concept concept) : super(concept);

  Project findByNameId(String name) {
    return findById(new Id(concept)..setAttribute('name', name));
  }

}

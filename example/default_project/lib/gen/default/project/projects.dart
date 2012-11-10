part of default_project;

// data/gen/default/project/projects.dart

abstract class ProjectGen extends ConceptEntity<Project> {

  ProjectGen(Concept concept) : super.of(concept);

  ProjectGen.withId(Concept concept, String name) : super.of(concept) {
    setAttribute("name", name);
  }

  String get name => getAttribute("name");
  set name(String a) => setAttribute("name", a);

  String get description => getAttribute("description");
  set description(String a) => setAttribute("description", a);

  Project newEntity() => new Project(concept);

  int nameCompareTo(Project other) {
    return name.compareTo(other.name);
  }

}

abstract class ProjectsGen extends Entities<Project> {

  ProjectsGen(Concept concept) : super.of(concept);

  Projects newEntities() => new Projects(concept);

}
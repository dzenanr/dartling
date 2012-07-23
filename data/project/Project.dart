
class Project extends Entity<Project> {

  Project(Concept concept) : super.of(concept);

  String get name() => getAttribute('name');
  set name(String a) => setAttribute('name', a);

  String get description() => getAttribute('description');
  set description(String a) => setAttribute('description', a);

  bool isOnProgramming() => description.contains('Programming') ? true : false;

}

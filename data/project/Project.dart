
class Project extends Entity<Project> {

  Project(Concept concept) : super.of(concept);
  
  Project.withId(Concept concept, String name) : super.of(concept) {
    setAttribute('name', name);
  }

  String get name() => getAttribute('name');
  set name(String a) => setAttribute('name', a);

  String get description() => getAttribute('description');
  set description(String a) => setAttribute('description', a);

  bool isOnProgramming() => description.contains('Programming') ? true : false;

  /**
   * Compares two projects based on name.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareName(Project other) {
    return name.compareTo(other.name);
  }
}

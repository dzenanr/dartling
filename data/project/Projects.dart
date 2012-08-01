
class Projects extends Entities<Project> {

  Projects(Concept concept) : super.of(concept);
  
  Projects newEntities() => new Projects(concept);

}

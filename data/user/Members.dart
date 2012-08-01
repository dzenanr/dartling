
class Members extends Entities<Member> {

  Members(Concept concept) : super.of(concept);
  
  Members newEntities() => new Members(concept);

}

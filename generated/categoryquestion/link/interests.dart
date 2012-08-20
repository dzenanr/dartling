
abstract class InterestGen extends Entity<Interest> {

  InterestGen(Concept concept) : super.of(concept);

  InterestGen.withId(Concept concept,
      Member member, Category category) : super.of(concept) {
    setParent('member', member);
    setParent('category', category);
  }

  Member get member() => getParent('member');
  set member(Member p) => setParent('member', p);

  Category get category() => getParent('category');
  set category(Category p) => setParent('category', p);

  String get description() => getAttribute('description');
  set description(String a) => setAttribute('description', a);

  Interest newEntity() => new Interest(concept);

}

abstract class InterestsGen extends Entities<Interest> {

  InterestsGen(Concept concept) : super.of(concept);

  Interests newEntities() => new Interests(concept);

}


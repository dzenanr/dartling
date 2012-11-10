part of category_question_link;

// data/gen/category_question/link/interests.dart

abstract class InterestGen extends ConceptEntity<Interest> {

  InterestGen(Concept concept) : super.of(concept);

  InterestGen.withId(Concept concept, Category category, Member member) : super.of(concept) {
    setParent("category", category);
    setParent("member", member);
  }

  Category get category => getParent("category");
  set category(Category p) => setParent("category", p);

  Member get member => getParent("member");
  set member(Member p) => setParent("member", p);

  String get description => getAttribute("description");
  set description(String a) => setAttribute("description", a);

  Interest newEntity() => new Interest(concept);

}

abstract class InterestsGen extends Entities<Interest> {

  InterestsGen(Concept concept) : super.of(concept);

  Interests newEntities() => new Interests(concept);

}


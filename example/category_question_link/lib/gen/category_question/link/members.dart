//part of category_question_link;

part of category_question_link;

// data/gen/category_question/link/members.dart

abstract class MemberGen extends ConceptEntity<Member> {

  MemberGen(Concept concept) : super.of(concept) {
    Concept interestConcept = concept.model.concepts.findByCode("Interest");
    setChild("interests", new Interests(interestConcept));
  }

  MemberGen.withId(Concept concept, String email) : super.of(concept) {
    setAttribute("email", email);
    Concept interestConcept = concept.model.concepts.findByCode("Interest");
    setChild("interests", new Interests(interestConcept));
  }

  String get email => getAttribute("email");
  set email(String a) => setAttribute("email", a);

  String get firstName => getAttribute("firstName");
  set firstName(String a) => setAttribute("firstName", a);

  String get lastName => getAttribute("lastName");
  set lastName(String a) => setAttribute("lastName", a);

  Date get startedOn => getAttribute("startedOn");
  set startedOn(Date a) => setAttribute("startedOn", a);

  bool get receiveEmail => getAttribute("receiveEmail");
  set receiveEmail(bool a) => setAttribute("receiveEmail", a);

  String get password => getAttribute("password");
  set password(String a) => setAttribute("password", a);

  String get role => getAttribute("role");
  set role(String a) => setAttribute("role", a);

  num get karma => getAttribute("karma");
  set karma(num a) => setAttribute("karma", a);

  String get about => getAttribute("about");
  set about(String a) => setAttribute("about", a);

  Interests get interests => getChild("interests");

  Member newEntity() => new Member(concept);

  int emailCompareTo(Member other) {
    return email.compareTo(other.email);
  }

}

abstract class MembersGen extends Entities<Member> {

  MembersGen(Concept concept) : super.of(concept);

  Members newEntities() => new Members(concept);

}


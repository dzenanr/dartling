
abstract class MemberGen extends Entity<Member> {

  MemberGen(Concept concept) : super.of(concept) {
    Concept interestConcept = concept.model.concepts.findByCode('Interest');
    setChild('interests', new Interests(interestConcept));
  }

  MemberGen.withIds(Concept concept,
      String code, String email) : super.of(concept) {
    this.code = code;
    setAttribute('email', email);
    Concept interestConcept = concept.model.concepts.findByCode('Interest');
    setChild('interests', new Interests(interestConcept));
  }

  String get email() => getAttribute('email');
  set email(String a) => setAttribute('email', a);

  String get firstName() => getAttribute('firstName');
  set firstName(String a) => setAttribute('firstName', a);

  String get lastName() => getAttribute('lastName');
  set lastName(String a) => setAttribute('lastName', a);

  Date get started() => getAttribute('started');
  set started(Date a) => setAttribute('started', a);

  bool get receiveEmail() => getAttribute('receiveEmail');
  set receiveEmail(bool a) => setAttribute('receiveEmail', a);

  String get password() => getAttribute('password');
  set password(String a) => setAttribute('password', a);

  String get role() => getAttribute('role');
  set role(String a) => setAttribute('role', a);

  num get karma() => getAttribute('karma');
  set karma(num a) => setAttribute('karma', a);

  String get about() => getAttribute('about');
  set about(String a) => setAttribute('about', a);

  Interests get interests() => getChild('interests');

  Member newEntity() => new Member(concept);

}

abstract class MembersGen extends Entities<Member> {

  MembersGen(Concept concept) : super.of(concept);

  Members newEntities() => new Members(concept);

}



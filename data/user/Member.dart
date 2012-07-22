
class Member extends Entity<Member> {

  Member(Concept concept) : super.of(concept);

  String get firstName() => getAttribute('firstName');
  set firstName(String a) => setAttribute('firstName', a);

  String get lastName() => getAttribute('lastName');
  set lastName(String a) => setAttribute('lastName', a);

  String get email() => getAttribute('email');
  set email(String a) => setAttribute('email', a);

  /*
  String get password() => getAttribute('password');
  set password(String a) => setAttribute('password', a);
  */

}


class Member extends Entity<Member> {

  Member(Concept concept) : super.of(concept);
  
  Member.withIds(Concept concept, String code, String email) : super.of(concept) {
    this.code = code;
    setAttribute('email', email);
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
  
  Member newEntity() => new Member(concept);

  bool get ridjanovic() => lastName.contains('Ridjanovic') ? true : false;

  /**
   * Compares two members based on the last and first names.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(Member other) {
    var c = lastName.compareTo(other.lastName);
    if (c == 0) {
      return firstName.compareTo(other.firstName);
    }
    return c;
  }

  /**
   * Compares two members based on code.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareCode(Member other) {
    return code.compareTo(other.code);
  }

}

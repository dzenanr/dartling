
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

  /**
   * Compares two entities based on the last and first names.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(Member other) {
    var last = lastName.compareTo(other.lastName);
    if (last == 0) {
      return firstName.compareTo(other.firstName);
    }
    return last;
  }

}

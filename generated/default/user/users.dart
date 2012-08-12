
abstract class UserGen extends Entity<User> {

  UserGen(Concept concept) : super.of(concept);

  UserGen.withIds(Concept concept, String code, String email) : super.of(concept) {
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

  User newEntity() => new User(concept);

}

abstract class UsersGen extends Entities<User> {

  UsersGen(Concept concept) : super.of(concept);

  Users newEntities() => new Users(concept);

}



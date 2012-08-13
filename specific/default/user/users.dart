
class User extends UserGen {

  User(Concept concept) : super(concept);

  User.withIds(Concept concept, String code, String email) :
    super.withIds(concept, code, email);

  bool get ridjanovic() => lastName.contains('Ridjanovic') ? true : false;

  /**
   * Compares two users based on the last and first names.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(User other) {
    var c = lastName.compareTo(other.lastName);
    if (c == 0) {
      return firstName.compareTo(other.firstName);
    }
    return c;
  }

  /**
   * Compares two users based on code.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareCode(User other) {
    return code.compareTo(other.code);
  }

}

class Users extends UsersGen {

  Users(Concept concept) : super(concept);

  bool preAdd(User user) {
    bool validation = super.preAdd(user);
    if (validation) {
      List<String> roles = ['regular', 'manager', 'admin'];
      validation = roles.some((r) => r == user.role);
      if (!validation) {
        Error error = new Error('pre');
        error.message =
            '${concept.plural}.preAdd rejects the ${user.role} role.';
        errors.add(error);
      }
    }
    return validation;
  }

}


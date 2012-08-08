
class Ecoles extends Entities<Ecole> {

  Ecoles(Concept concept) : super.of(concept);

  Ecoles newEntities() => new Ecoles(concept);

  bool preAdd(Ecole ecole) {
    bool validation = super.preAdd(ecole);
    if (validation) {
      List<String> roles = ['regular', 'manager', 'admin'];
      validation = roles.some((r) => r == ecole.role);
      if (!validation) {
        Error error = new Error('pre');
        error.message =
            '${concept.pluralName}.preAdd rejects the ${ecole.role} role.';
        errors.add(error);
      }
    }
    return validation;
  }

}

class Ecole extends Entity<Ecole> {

  Ecole(Concept concept) : super.of(concept);

  Ecole.withIds(Concept concept, String code, String email) : super.of(concept) {
    this.code = code;
    setAttribute('email', email);
  }

  int get numeroEcole() => getAttribute('nemeroEcole');
  set numeroEcole(int a) => setAttribute('numeroEcole', a);

  String get nomEcole() => getAttribute('nomEcole');
  set nomEcole(String a) => setAttribute('nomEcole', a);


  Ecole newEntity() => new Ecole(concept);

 
  /**
   * Compares two members based on the last and first names.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(Ecole other) {
    var c = numeroEcole.compareTo(other.numeroEcole);
    if (c == 0) {
      return nomEcole.compareTo(other.nomEcole);
    }
    return c;
  }

  /**
   * Compares two members based on code.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareCode(Ecole other) {
    return code.compareTo(other.code);
  }

}

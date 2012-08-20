
class Ecole extends EcoleGen {

  Ecole(Concept concept) : super(concept);

  Ecole.withId(Concept concept, int numero) : super.withId(concept, numero);

  /**
   * Compares two ecoles based on adress.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareAdress(Ecole other) {
    return nom.compareTo(other.adress);
  }

}

class Ecoles extends EcolesGen {

  Ecoles(Concept concept) : super(concept);

}

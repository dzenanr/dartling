
class Ecoles extends Entities<Ecole> {

  Ecoles(Concept concept) : super.of(concept);

  Ecoles newEntities() => new Ecoles(concept);

}

class Ecole extends Entity<Ecole> {

  Ecole(Concept concept) : super.of(concept);

  int get numero() => getAttribute('numero');
  set numero(int a) => setAttribute('numero', a);

  String get nom() => getAttribute('nom');
  set nom(String a) => setAttribute('nom', a);

  Ecole newEntity() => new Ecole(concept);


  /**
   * Compares two ecoles based on the numero.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(Ecole other) {
    return numero.compareTo(other.numero);
  }

  /**
   * Compares two ecoles based on nom.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareNom(Ecole other) {
    return nom.compareTo(other.nom);
  }

}

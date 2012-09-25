
// src/data/gen/concept/attribute/cities.dart

abstract class CityGen extends ConceptEntity<City> {

  CityGen(Concept concept) : super.of(concept);

  CityGen.withId(Concept concept, String name) : super.of(concept) {
    setAttribute("name", name);
  }

  String get name => getAttribute("name");
  set name(String a) => setAttribute("name", a);

  City newEntity() => new City(concept);

  int nameCompareTo(City other) {
    return name.compareTo(other.name);
  }

}

abstract class CitiesGen extends Entities<City> {

  CitiesGen(Concept concept) : super.of(concept);

  Cities newEntities() => new Cities(concept);

}

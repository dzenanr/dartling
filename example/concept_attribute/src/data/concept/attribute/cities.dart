
// src/data/concept/attribute/cities.dart

class City extends CityGen {

  City(Concept concept) : super(concept);

  City.withId(Concept concept, String name) :
    super.withId(concept, name);

}

class Cities extends CitiesGen {

  Cities(Concept concept) : super(concept);

}



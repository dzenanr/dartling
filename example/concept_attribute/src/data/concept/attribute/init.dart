
// src/data/concept/attribute/init.dart

initConceptAttribute(var entries) {
  _initCities(entries);
}

_initCities(var entries) {
  Cities cities = entries.cities;
  Concept cityConcept = cities.concept;

  City torontoCity = new City(cityConcept);
  torontoCity.name = 'Toronto';
  cities.add(torontoCity);

  City quebecCity = new City(cityConcept);
  quebecCity.name = 'Québec';
  cities.add(quebecCity);

  City montrealCity = new City(cityConcept);
  montrealCity.name = 'Montréal';
  cities.add(montrealCity);
}




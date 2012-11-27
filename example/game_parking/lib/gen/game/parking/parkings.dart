part of game_parking;

// data/gen/game/parking/parkings.dart

abstract class ParkingGen extends ConceptEntity<Parking> {

  ParkingGen(Concept concept) : super.of(concept) {
    Concept carConcept = concept.model.concepts.findByCode("Car");
    setChild("cars", new Cars(carConcept));
  }

  ParkingGen.withId(Concept concept, Area area, int number) : super.of(concept) {
    setParent("area", area);
    setAttribute("number", number);
    Concept carConcept = concept.model.concepts.findByCode("Car");
    setChild("cars", new Cars(carConcept));
  }

  Area get area => getParent("area");
  set area(Area p) => setParent("area", p);

  int get number => getAttribute("number");
  set number(int a) => setAttribute("number", a);

  Cars get cars => getChild("cars");

  Parking newEntity() => new Parking(concept);

  int numberCompareTo(Parking other) {
    return number.compareTo(other.number);
  }

}

abstract class ParkingsGen extends Entities<Parking> {

  ParkingsGen(Concept concept) : super.of(concept);

  Parkings newEntities() => new Parkings(concept);

}

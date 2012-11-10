part of game_parking;

// data/gen/game/parking/areas.dart

abstract class AreaGen extends ConceptEntity<Area> {

  AreaGen(Concept concept) : super.of(concept) {
    Concept parkingConcept = concept.model.concepts.findByCode("Parking");
    setChild("parkings", new Parkings(parkingConcept));
  }

  AreaGen.withId(Concept concept, String name) : super.of(concept) {
    setAttribute("name", name);
    Concept parkingConcept = concept.model.concepts.findByCode("Parking");
    setChild("parkings", new Parkings(parkingConcept));
  }

  String get name => getAttribute("name");
  set name(String a) => setAttribute("name", a);

  Parkings get parkings => getChild("parkings");

  Area newEntity() => new Area(concept);

  int nameCompareTo(Area other) {
    return name.compareTo(other.name);
  }

}

abstract class AreasGen extends Entities<Area> {

  AreasGen(Concept concept) : super.of(concept);

  Areas newEntities() => new Areas(concept);

}

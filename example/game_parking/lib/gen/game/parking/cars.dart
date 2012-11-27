part of game_parking;

// data/gen/game/parking/cars.dart

abstract class CarGen extends ConceptEntity<Car> {

  CarGen(Concept concept) : super.of(concept);

  CarGen.withId(Concept concept, Parking parking, Brand brand) : super.of(concept) {
    setParent("parking", parking);
    setParent("brand", brand);
  }

  Parking get parking => getParent("parking");
  set parking(Parking p) => setParent("parking", p);

  Brand get brand => getParent("brand");
  set brand(Brand p) => setParent("brand", p);

  String get orientation => getAttribute("orientation");
  set orientation(String a) => setAttribute("orientation", a);

  int get startRow => getAttribute("startRow");
  set startRow(int a) => setAttribute("startRow", a);

  int get startColumn => getAttribute("startColumn");
  set startColumn(int a) => setAttribute("startColumn", a);

  int get currentRow => getAttribute("currentRow");
  set currentRow(int a) => setAttribute("currentRow", a);

  int get currentColumn => getAttribute("currentColumn");
  set currentColumn(int a) => setAttribute("currentColumn", a);

  bool get selected => getAttribute("selected");
  set selected(bool a) => setAttribute("selected", a);

  Car newEntity() => new Car(concept);

}

abstract class CarsGen extends Entities<Car> {

  CarsGen(Concept concept) : super.of(concept);

  Cars newEntities() => new Cars(concept);

}

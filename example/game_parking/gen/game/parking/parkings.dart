part of game_parking; 
 
// lib/gen/game/parking/parkings.dart 
 
abstract class ParkingGen extends ConceptEntity<Parking> { 
 
  ParkingGen(Concept concept) { 
    this.concept = concept;
    Concept carConcept = concept.model.concepts.singleWhereCode("Car"); 
    setChild("cars", new Cars(carConcept)); 
  } 
 
  ParkingGen.withId(Concept concept, Area area, int number) { 
    this.concept = concept;
    setParent("area", area); 
    setAttribute("number", number); 
    Concept carConcept = concept.model.concepts.singleWhereCode("Car"); 
    setChild("cars", new Cars(carConcept)); 
  } 
 
  Area get area => getParent("area"); 
  set area(Area p) => setParent("area", p); 
  
  int get number => getAttribute("number"); 
  set number(int a) => setAttribute("number", a); 
  
  Cars get cars => getChild("cars"); 
  
  Parking newEntity() => new Parking(concept); 
  Parkings newEntities() => new Parkings(concept); 
  
  int numberCompareTo(Parking other) { 
    return number.compareTo(other.number); 
  } 
 
} 
 
abstract class ParkingsGen extends Entities<Parking> { 
 
  ParkingsGen(Concept concept) {
    this.concept = concept;
  }
 
  Parkings newEntities() => new Parkings(concept); 
  Parking newEntity() => new Parking(concept); 
  
}


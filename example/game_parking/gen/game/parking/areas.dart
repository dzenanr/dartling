part of game_parking; 
 
// lib/gen/game/parking/areas.dart 
 
abstract class AreaGen extends ConceptEntity<Area> { 
 
  AreaGen(Concept concept) { 
    this.concept = concept;
    Concept parkingConcept = concept.model.concepts.singleWhereCode("Parking"); 
    setChild("parkings", new Parkings(parkingConcept)); 
  } 
 
  AreaGen.withId(Concept concept, String name) { 
    this.concept = concept;
    setAttribute("name", name); 
    Concept parkingConcept = concept.model.concepts.singleWhereCode("Parking"); 
    setChild("parkings", new Parkings(parkingConcept)); 
  } 
 
  String get name => getAttribute("name"); 
  void set name(String a) { setAttribute("name", a); }
  
  Parkings get parkings => getChild("parkings"); 
  
  Area newEntity() => new Area(concept); 
  Areas newEntities() => new Areas(concept); 
  
  int nameCompareTo(Area other) { 
    return name.compareTo(other.name); 
  } 
 
} 
 
abstract class AreasGen extends Entities<Area> { 
 
  AreasGen(Concept concept) {
    this.concept = concept;
  }
 
  Areas newEntities() => new Areas(concept); 
  Area newEntity() => new Area(concept); 
  
}


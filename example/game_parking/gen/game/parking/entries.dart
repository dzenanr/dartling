part of game_parking; 
 
// lib/gen/game/parking/entries.dart 
 
class ParkingEntries extends ModelEntries { 
 
  ParkingEntries(Model model) : super(model); 
 
  Map<String, Entities> newEntries() { 
    var entries = new Map<String, Entities>(); 
    var concept; 
    concept = model.concepts.singleWhereCode("Area"); 
    entries["Area"] = new Areas(concept); 
    concept = model.concepts.singleWhereCode("Brand"); 
    entries["Brand"] = new Brands(concept); 
    concept = model.concepts.singleWhereCode("Parking"); 
    entries["Parking"] = new Parkings(concept); 
    return entries; 
  } 
 
  Entities newEntities(String conceptCode) { 
    var concept = model.concepts.singleWhereCode(conceptCode); 
    if (concept == null) { 
      throw new ConceptError("${conceptCode} concept does not exist.") ; 
    } 
    if (concept.code == "Area") { 
      return new Areas(concept); 
    } 
    if (concept.code == "Brand") { 
      return new Brands(concept); 
    } 
    if (concept.code == "Parking") { 
      return new Parkings(concept); 
    } 
    if (concept.code == "Car") { 
      return new Cars(concept); 
    } 
    return null;
  } 
 
  ConceptEntity newEntity(String conceptCode) { 
    var concept = model.concepts.singleWhereCode(conceptCode); 
    if (concept == null) { 
      throw new ConceptError("${conceptCode} concept does not exist.") ; 
    } 
    if (concept.code == "Area") { 
      return new Area(concept); 
    } 
    if (concept.code == "Brand") { 
      return new Brand(concept); 
    } 
    if (concept.code == "Parking") { 
      return new Parking(concept); 
    } 
    if (concept.code == "Car") { 
      return new Car(concept); 
    } 
    return null;
  } 
 
  void fromJsonToData() { 
    fromJson(gameParkingDataJson); 
  } 
 
  Areas get areas => getEntry("Area"); 
  Brands get brands => getEntry("Brand"); 
  Parkings get parkings => getEntry("Parking"); 
 
} 


part of game_parking; 
 
// lib/gen/game/parking/brands.dart 
 
abstract class BrandGen extends ConceptEntity<Brand> { 
 
  BrandGen(Concept concept) { 
    this.concept = concept;
    Concept carConcept = concept.model.concepts.singleWhereCode("Car"); 
    setChild("cars", new Cars(carConcept)); 
  } 
 
  BrandGen.withId(Concept concept, String name) { 
    this.concept = concept;
    setAttribute("name", name); 
    Concept carConcept = concept.model.concepts.singleWhereCode("Car"); 
    setChild("cars", new Cars(carConcept)); 
  } 
 
  String get name => getAttribute("name"); 
  set name(String a) => setAttribute("name", a); 
  
  int get length => getAttribute("length"); 
  set length(int a) => setAttribute("length", a); 
  
  String get colorName => getAttribute("colorName"); 
  set colorName(String a) => setAttribute("colorName", a); 
  
  String get color => getAttribute("color"); 
  set color(String a) => setAttribute("color", a); 
  
  int get red => getAttribute("red"); 
  set red(int a) => setAttribute("red", a); 
  
  int get green => getAttribute("green"); 
  set green(int a) => setAttribute("green", a); 
  
  int get blue => getAttribute("blue"); 
  set blue(int a) => setAttribute("blue", a); 
  
  Cars get cars => getChild("cars"); 
  
  Brand newEntity() => new Brand(concept); 
  Brands newEntities() => new Brands(concept); 
  
  int nameCompareTo(Brand other) { 
    return name.compareTo(other.name); 
  } 
 
} 
 
abstract class BrandsGen extends Entities<Brand> { 
 
  BrandsGen(Concept concept) {
    this.concept = concept;
  }
 
  Brands newEntities() => new Brands(concept); 
  Brand newEntity() => new Brand(concept); 
  
}


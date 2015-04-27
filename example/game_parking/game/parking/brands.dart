part of game_parking;

// data/game/parking/brands.dart

class Brand extends BrandGen {

  Brand(Concept concept) : super(concept);

  Brand.withId(Concept concept, String name) :
    super.withId(concept, name);

}

class Brands extends BrandsGen {

  Brands(Concept concept) : super(concept);
  
  // specific code from here

  Brand getBrand(String name) {
    return singleWhereAttributeId("name", name);
  }

}


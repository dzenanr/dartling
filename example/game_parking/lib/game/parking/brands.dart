
// data/game/parking/brands.dart

class Brand extends BrandGen {

  Brand(Concept concept) : super(concept);

  Brand.withId(Concept concept, String name) :
    super.withId(concept, name);

}

class Brands extends BrandsGen {

  Brands(Concept concept) : super(concept);

  Brand getBrand(String name) {
    return findByAttributeId("name", name);
  }

}


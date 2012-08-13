
class Category extends CategoryGen {

  Category(Concept concept) : super(concept);

  Category.withId(Concept concept, String name) : super.withId(concept, name);

}

class Categories extends CategoriesGen {

  Categories(Concept concept) : super(concept);

}


part of category_keyword;

// data/category/keyword/categories.dart

class Category extends CategoryGen {

  Category(Concept concept) : super(concept);

  Category.withId(Concept concept, String namePath) :
    super.withId(concept, namePath);

  set nameAndPath(String categoryName) {
    name = categoryName;
    if (this.category == null) {
      namePath = name;
    } else {
      namePath = '${category.namePath}/${name}';
    }
  }

}

class Categories extends CategoriesGen {

  Categories(Concept concept) : super(concept);

  Category findInTree(String attributeName, String attributeValue) {
    Category category = findByAttribute(attributeName, attributeValue);
    if (category == null) {
      for (Category c in this) {
        category = c.categories.findInTree(attributeName, attributeValue);
        if (category != null) {
          break;
        }
      }
    }
    return category;
  }

}


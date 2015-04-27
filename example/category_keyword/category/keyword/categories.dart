part of category_keyword; 
 
// lib/category/keyword/categories.dart 
 
class Category extends CategoryGen { 
 
  Category(Concept concept) : super(concept); 
 
  Category.withId(Concept concept, String namePath) : 
    super.withId(concept, namePath); 
 
  // added after code gen - begin 
 
  set nameAndPath(String categoryName) {
    name = categoryName;
    if (this.category == null) {
      namePath = name;
    } else {
      namePath = '${category.namePath}/${name}';
    }
  }
  
  // added after code gen - end 
 
} 
 
class Categories extends CategoriesGen { 
 
  Categories(Concept concept) : super(concept); 
 
  // added after code gen - begin 
 
  // added after code gen - end 
 
} 
 

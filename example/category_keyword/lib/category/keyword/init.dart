//part of category_keyword;

// data/category/keyword/init.dart

initCategoryKeyword(var entries) {
  _initCategories(entries);
  _initKeywords(entries);
  _initTags(entries);
}

_initCategories(var entries) {
  Categories categories = entries.categories;
  Concept categoryConcept = categories.concept;

  Category dartCategory = new Category(categoryConcept);
  dartCategory.nameAndPath = 'Dart';
  categories.add(dartCategory);

  Category learningDartCategory = new Category(categoryConcept);
  learningDartCategory.category = dartCategory;
  learningDartCategory.nameAndPath = 'Learning Dart';
  dartCategory.categories.add(learningDartCategory);

  Category dartCanvasCategory = new Category(categoryConcept);
  dartCanvasCategory.category = dartCategory;
  dartCanvasCategory.nameAndPath = 'Dart Canvas';
  dartCategory.categories.add(dartCanvasCategory);
}

_initKeywords(var entries) {
  Keywords keywords = entries.keywords;
  Concept keywordConcept = keywords.concept;

  Keyword functionKeyword = new Keyword.withId(keywordConcept, 'function');
  keywords.add(functionKeyword);

  Keyword ooKeyword = new Keyword.withId(keywordConcept, 'oo');
  keywords.add(ooKeyword);

  Keyword typeKeyword = new Keyword.withId(keywordConcept, 'type');
  keywords.add(typeKeyword);

  Keyword variableKeyword = new Keyword.withId(keywordConcept, 'variable');
  keywords.add(variableKeyword);
}

_initTags(var entries) {
  Categories categories = entries.categories;
  Keywords keywords = entries.keywords;
  Concept tagConcept = entries.getConcept('Tag');

  Category dartCategory = categories.findInTree('name', 'Dart');
  assert(dartCategory != null);
  Keyword ooKeyword = keywords.findByAttributeId('word', 'oo');
  assert(ooKeyword != null);
  if (ooKeyword != null && dartCategory != null) {
    Tag ooDartTag =
        new Tag.withId(tagConcept, ooKeyword, dartCategory);
    dartCategory.tags.add(ooDartTag);
    ooKeyword.tags.add(ooDartTag);
  }

  Keyword functionKeyword = keywords.findByAttributeId('word', 'function');
  assert(functionKeyword != null);
  if (functionKeyword != null && dartCategory != null) {
    Tag functionDartTag =
        new Tag.withId(tagConcept, functionKeyword, dartCategory);
    dartCategory.tags.add(functionDartTag);
    functionKeyword.tags.add(functionDartTag);
  }

  Category dartCanvasCategory = categories.findInTree('name', 'Dart Canvas');
  assert(dartCanvasCategory != null);
  if (dartCanvasCategory != null && functionKeyword != null) {
    Tag functionDartCanvasTag =
        new Tag.withId(tagConcept, functionKeyword, dartCanvasCategory);
    dartCanvasCategory.tags.add(functionDartCanvasTag);
    functionKeyword.tags.add(functionDartCanvasTag);
  }
}



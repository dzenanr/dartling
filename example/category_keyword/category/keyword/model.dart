 
part of category_keyword; 
 
// lib/category/keyword/model.dart 
 
class KeywordModel extends KeywordEntries { 
 
  KeywordModel(Model model) : super(model); 
 
  fromJsonToCategoryEntry() { 
    fromJsonToEntry(categoryKeywordCategoryEntry); 
  } 
 
  fromJsonToKeywordEntry() { 
    fromJsonToEntry(categoryKeywordKeywordEntry); 
  } 
 
  fromJsonToModel() { 
    fromJson(categoryKeywordModel); 
  } 
 
  init() { 
    initCategories(); 
    initKeywords(); 
  } 
 
  initCategories() { 
    var category1 = new Category(categories.concept); 
    category1.name = "drink"; 
    category1.namePath = "photo"; 
    categories.add(category1); 
 
    var category1categories1 = new Category(category1.categories.concept); 
    category1categories1.name = "security"; 
    category1categories1.namePath = "unit"; 
    category1categories1.category = category1; 
    category1.categories.add(category1categories1); 
 
    var category1categories2 = new Category(category1.categories.concept); 
    category1categories2.name = "wave"; 
    category1categories2.namePath = "park"; 
    category1categories2.category = category1; 
    category1.categories.add(category1categories2); 
 
    var category2 = new Category(categories.concept); 
    category2.name = "test"; 
    category2.namePath = "question"; 
    categories.add(category2); 
 
    var category2categories1 = new Category(category2.categories.concept); 
    category2categories1.name = "energy"; 
    category2categories1.namePath = "series"; 
    category2categories1.category = category2; 
    category2.categories.add(category2categories1); 
 
    var category2categories2 = new Category(category2.categories.concept); 
    category2categories2.name = "school"; 
    category2categories2.namePath = "tension"; 
    category2categories2.category = category2; 
    category2.categories.add(category2categories2); 
 
    var category3 = new Category(categories.concept); 
    category3.name = "sin"; 
    category3.namePath = "done"; 
    categories.add(category3); 
 
    var category3categories1 = new Category(category3.categories.concept); 
    category3categories1.name = "professor"; 
    category3categories1.namePath = "house"; 
    category3categories1.category = category3; 
    category3.categories.add(category3categories1); 
 
    var category3categories2 = new Category(category3.categories.concept); 
    category3categories2.name = "brad"; 
    category3categories2.namePath = "tent"; 
    category3categories2.category = category3; 
    category3.categories.add(category3categories2); 
 
  } 
 
  initKeywords() { 
    var keyword1 = new Keyword(keywords.concept); 
    keyword1.word = "hot"; 
    keywords.add(keyword1); 
 
    var keyword1tags1 = new Tag(keyword1.tags.concept); 
    var keyword1tags1Category = categories.random(); 
    keyword1tags1.category = keyword1tags1Category; 
    keyword1tags1.keyword = keyword1; 
    keyword1.tags.add(keyword1tags1); 
    keyword1tags1Category.tags.add(keyword1tags1); 
 
    var keyword1tags2 = new Tag(keyword1.tags.concept); 
    var keyword1tags2Category = categories.random(); 
    keyword1tags2.category = keyword1tags2Category; 
    keyword1tags2.keyword = keyword1; 
    keyword1.tags.add(keyword1tags2); 
    keyword1tags2Category.tags.add(keyword1tags2); 
 
    var keyword2 = new Keyword(keywords.concept); 
    keyword2.word = "thing"; 
    keywords.add(keyword2); 
 
    var keyword2tags1 = new Tag(keyword2.tags.concept); 
    var keyword2tags1Category = categories.random(); 
    keyword2tags1.category = keyword2tags1Category; 
    keyword2tags1.keyword = keyword2; 
    keyword2.tags.add(keyword2tags1); 
    keyword2tags1Category.tags.add(keyword2tags1); 
 
    var keyword2tags2 = new Tag(keyword2.tags.concept); 
    var keyword2tags2Category = categories.random(); 
    keyword2tags2.category = keyword2tags2Category; 
    keyword2tags2.keyword = keyword2; 
    keyword2.tags.add(keyword2tags2); 
    keyword2tags2Category.tags.add(keyword2tags2); 
 
    var keyword3 = new Keyword(keywords.concept); 
    keyword3.word = "paper"; 
    keywords.add(keyword3); 
 
    var keyword3tags1 = new Tag(keyword3.tags.concept); 
    var keyword3tags1Category = categories.random(); 
    keyword3tags1.category = keyword3tags1Category; 
    keyword3tags1.keyword = keyword3; 
    keyword3.tags.add(keyword3tags1); 
    keyword3tags1Category.tags.add(keyword3tags1); 
 
    var keyword3tags2 = new Tag(keyword3.tags.concept); 
    var keyword3tags2Category = categories.random(); 
    keyword3tags2.category = keyword3tags2Category; 
    keyword3tags2.keyword = keyword3; 
    keyword3.tags.add(keyword3tags2); 
    keyword3tags2Category.tags.add(keyword3tags2); 
 
  } 
 
  // added after code gen - begin 
 
  // added after code gen - end 
 
} 
 

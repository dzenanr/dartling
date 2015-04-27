part of category_keyword; 
 
// lib/gen/category/models.dart 
 
class CategoryModels extends DomainModels { 
 
  CategoryModels(Domain domain) : super(domain) { 
    // fromJsonToModel function from dartling/lib/domain/model/transfer.json.dart 
 
    Model model = fromJsonToModel(categoryKeywordModelJson, domain, "Keyword"); 
    KeywordModel keywordModel = new KeywordModel(model); 
    add(keywordModel); 
 
  } 
 
} 
 

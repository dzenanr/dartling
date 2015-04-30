import 'category_keyword.dart';  
 
void genCode(Repository repository) { 
  repository.gen("category_keyword"); 
} 
 
void initData(Repository repository) { 
   var categoryDomain = repository.getDomainModels("Category"); 
   var keywordModel = categoryDomain.getModelEntries("Keyword"); 
   keywordModel.init(); 
   //keywordModel.display(); 
} 
 
void main() { 
  var repository = new Repository(); 
  genCode(repository); 
  //initData(repository); 
} 
 

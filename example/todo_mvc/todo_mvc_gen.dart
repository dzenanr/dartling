import 'todo_mvc.dart';
 
genCode(Repository repository) { 
  repository.gen("todo_mvc"); 
} 
 
initData(Repository repository) { 
   var todoDomain = repository.getDomainModels("Todo"); 
   var mvcModel = todoDomain.getModelEntries("Mvc"); 
   mvcModel.init(); 
   //mvcModel.display(); 
} 
 
void main() { 
  var repository = new Repository(); 
  genCode(repository); 
  //initData(repository); 
} 
 

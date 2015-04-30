import 'default_project.dart';
 
void genCode(Repository repository) { 
  repository.gen("default_project"); 
} 
 
void initData(Repository repository) { 
   var defaultDomain = repository.getDomainModels("Default"); 
   var projectModel = defaultDomain.getModelEntries("Project"); 
   projectModel.init(); 
   //projectModel.display(); 
} 
 
void main() { 
  var repository = new Repository(); 
  genCode(repository); 
  //initData(repository); 
} 
 

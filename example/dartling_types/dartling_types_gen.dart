import 'dartling_types.dart';

void genCode(Repository repository) { 
  repository.gen("dartling_types"); 
} 
 
void initData(Repository repository) { 
   var dartlingDomain = repository.getDomainModels("Dartling"); 
   var typesModel = dartlingDomain.getModelEntries("Types"); 
   typesModel.init(); 
   //typesModel.display(); 
} 
 
void main() { 
  var repository = new Repository(); 
  genCode(repository); 
  //initData(repository); 
} 
 

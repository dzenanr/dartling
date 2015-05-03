import 'dartling_types.dart';
import 'dartling_types_app.dart';

void main() {
  var repository = new Repository(); 
  DartlingModels domain = repository.getDomainModels('Dartling');
  new TypesApp(domain);
}
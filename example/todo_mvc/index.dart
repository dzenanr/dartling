import 'todo_mvc.dart';
import 'todo_mvc_app.dart';

void main() {
  var repository = new Repository();
  var domain = repository.getDomainModels('Todo');
  new TodoApp(domain);
}




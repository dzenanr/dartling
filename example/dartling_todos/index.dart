import 'todo_mvc.dart';
import 'todo_mvc_app.dart';

void main() {
  var repo = new TodoRepo();
  TodoModels domain = repo.getDomainModels(TodoRepo.todoDomainCode);
  new TodoApp(domain);
}




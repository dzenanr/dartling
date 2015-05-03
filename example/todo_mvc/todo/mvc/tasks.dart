part of todo_mvc; 
 
// lib/todo/mvc/tasks.dart 
 
class Task extends TaskGen { 
 
  Task(Concept concept) : super(concept); 
 
  Task.withId(Concept concept, String title) : 
    super.withId(concept, title); 
 
  // added after code gen - begin 
  
  bool get left => !completed;
  bool get generate =>
      title.contains('generate') ? true : false; 
  
  // added after code gen - end 
 
} 
 
class Tasks extends TasksGen { 
 
  Tasks(Concept concept) : super(concept); 
 
  // added after code gen - begin 

  Tasks get completed => selectWhere((task) => task.completed);
  Tasks get left => selectWhere((task) => task.left);

  bool preAdd(Task task) {
    bool validation = super.preAdd(task);
    if (validation) {
      validation = task.title.length <= 64;
      if (!validation) {
        var error = new ValidationError('pre');
        error.message =
            'The "${task.title}" title should not be longer than 64.';
        errors.add(error);
      }
    }
    return validation;
  }
  
  // added after code gen - end 
 
} 
 

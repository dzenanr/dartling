 
part of todo_mvc; 
 
// lib/todo/mvc/model.dart 
 
class MvcModel extends MvcEntries { 
 
  MvcModel(Model model) : super(model); 
 
  fromJsonToTaskEntry() { 
    fromJsonToEntry(todoMvcTaskEntry); 
  } 
 
  fromJsonToModel() { 
    fromJson(todoMvcModel); 
  } 
 
  init() { 
    initTasks(); 
  } 
 
  initTasks() { 
    var task1 = new Task(tasks.concept); 
      task1.title = 'distance'; 
      task1.completed = true;  
      tasks.add(task1); 
 
    var task2 = new Task(tasks.concept); 
      task2.title = 'message'; 
      task2.completed = true; 
      tasks.add(task2); 
 
    var task3 = new Task(tasks.concept); 
      task3.title = 'ship'; 
      task3.completed = false;  
      tasks.add(task3); 
 
  } 
 
  // added after code gen - begin 
 
  // added after code gen - end 
 
} 
 

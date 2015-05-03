part of todo_mvc;

// lib/gen/todo/mvc/tasks.dart

abstract class TaskGen extends ConceptEntity<Task> {

  TaskGen(Concept concept) {
    this.concept = concept;
  }

  String get title => getAttribute("title");
  void set title(String a) { setAttribute("title", a); }

  bool get completed => getAttribute("completed");
  void set completed(bool a) { setAttribute("completed", a); }

  Task newEntity() => new Task(concept);
  Tasks newEntities() => new Tasks(concept);

}

abstract class TasksGen extends Entities<Task> {

  TasksGen(Concept concept) {
    this.concept = concept;
  }

  Tasks newEntities() => new Tasks(concept);
  Task newEntity() => new Task(concept);

}
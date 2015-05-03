part of todo_mvc;

// lib/gen/todo/models.dart

class TodoModels extends DomainModels {

  TodoModels(Domain domain) : super(domain) {
    add(fromJsonToMvcEntries());
  }

  MvcEntries fromJsonToMvcEntries() {
    return new MvcEntries(fromJsonToModel(
      todoMvcModelJson,
      domain,
      TodoRepo.todoMvcModelCode));
  }

}






part of todo_mvc;

// lib/gen/todo/repository.dart

class TodoRepo extends Repo {

  static final todoDomainCode = "Todo";
  static final todoMvcModelCode = "Mvc";

  TodoRepo([String code="TodoRepo"]) : super(code) {
    _initTodoDomain();
  }

  _initTodoDomain() {
    var todoDomain = new Domain(todoDomainCode);
    domains.add(todoDomain);
    add(new TodoModels(todoDomain));
  }

}





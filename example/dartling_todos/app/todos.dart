part of todo_mvc_app;

class Todos {
  TodoApp _todoApp;
  List<Todo> _todoList = new List<Todo>();
  Element _todoElements = querySelector('#todo-list');
  Element _allElements = querySelector('#filters a[href="#/"]');
  Element _leftElements = querySelector('#filters a[href="#/left"]');
  Element _completedElements = querySelector('#filters a[href="#/completed"]');

  Todos(this._todoApp) {
    window.onHashChange.listen((e) => updateFilter());
  }

  Todo _find(Task task) {
    for (Todo todo in _todoList) {
      if (todo.task == task) {
        return todo;
      }
    }
    return null;
  }

  void add(Task task) {
    var todo = new Todo(_todoApp, task);
    _todoList.add(todo);
    _todoElements.nodes.add(todo.create());
  }

  void remove(Task task) {
    var todo = _find(task);
    if (todo != null) {
      _todoList.remove(todo);
      todo.remove();
    }
  }

  void complete(Task task) {
    var todo = _find(task);
    if (todo != null) {
      todo.complete(task.completed);
    }
  }

  void retitle(Task task) {
    var todo = _find(task);
    if (todo != null) {
      todo.retitle(task.title);
    }
  }

  void updateFilter() {
    switch(window.location.hash) {
      case '#/left':
        showLeft();
        break;
      case '#/completed':
        showCompleted();
        break;
      default:
        showAll();
        break;
    }
  }

  void showAll() {
    _setSelectedFilter(_allElements);
    for (Todo todo in _todoList) {
      todo.visible = true;
    }
  }

  void showLeft() {
    _setSelectedFilter(_leftElements);
    for (Todo todo in _todoList) {
      todo.visible = todo.task.left;
    }
  }

  void showCompleted() {
    _setSelectedFilter(_completedElements);
    for (Todo todo in _todoList) {
      todo.visible = todo.task.completed;
    }
  }

  void _setSelectedFilter(Element e) {
    _allElements.classes.remove('selected');
    _leftElements.classes.remove('selected');
    _completedElements.classes.remove('selected');
    e.classes.add('selected');
  }

}



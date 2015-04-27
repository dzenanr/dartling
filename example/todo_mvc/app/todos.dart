part of todo_mvc_app;

class Todos implements ActionReactionApi {
  TodoApp _todoApp;

  List<Todo> _todoList = new List<Todo>();
  Element _todoElements = querySelector('#todo-list');

  Todos(this._todoApp) {
    _todoApp.domain.startActionReaction(this);
    DomainSession session = _todoApp.session;
    Tasks tasks = _todoApp.clientTasks;

    InputElement newTodo = querySelector('#new-todo');
    newTodo.onKeyPress.listen((KeyboardEvent e) {
      if (e.keyCode == KeyCode.ENTER) {
        var title = newTodo.value.trim();
        if (title != '') {
          var task = new Task(tasks.concept);
          task.title = title;
          newTodo.value = '';
          new AddAction(session, tasks, task).doit();
          _todoApp.possibleErrors();
        }
      }
    });
  }

  Iterator<Todo> get iterator => _todoList.iterator;

  add(Task task) {
    var todo = new Todo(_todoApp, task);
    _todoList.add(todo);
    _todoElements.nodes.add(todo.element);
  }

  Todo _find(Task task) {
    for (Todo todo in _todoList) {
      if (todo.task == task) {
        return todo;
      }
    }
    return null;
  }

  _complete(Task task) {
    var todo = _find(task);
    if (todo != null) {
      todo.complete(task.completed);
      _todoApp.footer.updateFilter();
    }
  }

  _retitle(Task task) {
    var todo = _find(task);
    if (todo != null) {
      todo.retitle(task.title);
    }
  }

  _remove(Task task) {
    var todo = _find(task);
    if (todo != null) {
      _todoList.remove(todo);
      todo.remove();
    }
  }

  react(ActionApi action) {
    updateTodo(SetAttributeAction action) {
      if (action.property == 'completed') {
        _complete(action.entity);
      } else if (action.property == 'title') {
        _retitle(action.entity);
      }
    }

    if (action is Transaction) {
      for (var transactionAction in action.past.actions) {
        if (transactionAction is SetAttributeAction) {
          updateTodo(transactionAction);
        } else if (transactionAction is RemoveAction) {
          if (transactionAction.undone) {
            add(transactionAction.entity);
          } else {
            _remove(transactionAction.entity);
          }
        } else if (transactionAction is AddAction) {
          if (transactionAction.undone) {
            _remove(transactionAction.entity);
          } else {
            add(transactionAction.entity);
          }
        }
      }
    } else if (action is AddAction) {
      if (action.undone) {
        _remove(action.entity);
      } else {
        add(action.entity);
      }
    } else if (action is RemoveAction) {
      if (action.undone) {
        add(action.entity);
      } else {
        _remove(action.entity);
      }
    } else if (action is SetAttributeAction) {
      updateTodo(action);
    }

    _todoApp.updateDisplay();
    _todoApp.save();
  }
}



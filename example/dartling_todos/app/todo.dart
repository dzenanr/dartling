part of todo_mvc_app;

class Todo {
  Task task;

  Tasks _tasks;
  DomainSession _session;

  Element _todo;
  InputElement _completed;
  Element _title;

  Todo(TodoApp todoApp, this.task) {
    _session = todoApp.session;
    _tasks = todoApp.tasks;
  }

  Element create() {
    _todo = new Element.html('''
      <li ${task.completed ? 'class="completed"' : ''}>
        <div class='view'>
          <input class='completed' type='checkbox'
            ${task.completed ? 'checked' : ''}>
          <label id='title'>${task.title}</label>
          <button class='remove'></button>
        </div>
        <input class='edit' value='${task.title}'>
      </li>
    ''');

    _title = _todo.querySelector('#title');
    InputElement edit = _todo.querySelector('.edit');

    _title.onDoubleClick.listen((MouseEvent e) {
      _todo.classes.add('editing');
      edit.select();
    });

    edit.onKeyPress.listen((KeyboardEvent e) {
      if (e.keyCode == KeyCode.ENTER) {
        var value = edit.value.trim();
        if (value != '') {
          new SetAttributeAction(_session, task, 'title', value).doit();
        }
      }
    });

    _completed = _todo.querySelector('.completed');
    _completed.onClick.listen((MouseEvent e) {
      new SetAttributeAction(_session, task, 'completed',
          !task.completed).doit();
    });

    _todo.querySelector('.remove').onClick.listen((MouseEvent e) {
      new RemoveAction(_session, _tasks, task).doit();
    });

    return _todo;
  }

  remove() {
    _todo.remove();
  }

  complete(bool completed) {
    _completed.checked = completed;
    if (completed) {
      _todo.classes.add('completed');
    } else {
      _todo.classes.remove('completed');
    }
  }

  retitle(String newTitle) {
    _title.text = newTitle;
    _todo.classes.remove('editing');
  }

  set visible(bool visible) {
    _todo.style.display = visible ? 'block' : 'none';
  }

}

part of todo_mvc_app;

class Todo {
  Task task;

  Element element;
  InputElement _completed;
  Element _title;

  Todo(TodoApp todoApp, this.task) {
    DomainSession session = todoApp.session;
    Tasks tasks = todoApp.clientTasks;

    element = new Element.html('''
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

    _completed = element.querySelector('.completed');
    _completed.onClick.listen((MouseEvent e) {
      new SetAttributeAction(session, task, 'completed',
          !task.completed).doit();
    });

    _title = element.querySelector('#title');
    InputElement edit = element.querySelector('.edit');

    _title.onDoubleClick.listen((MouseEvent e) {
      element.classes.add('editing');
      edit.select();
    });

    edit.onKeyPress.listen((KeyboardEvent e) {
      if (e.keyCode == KeyCode.ENTER) {
        var value = edit.value.trim();
        if (value != '') {
          var transaction = new Transaction('edit-title', session);
          transaction.add(new RemoveAction(session, tasks, task));
          var updatedTask = new Task.withId(task.concept, value);
          updatedTask.completed = task.completed;
          transaction.add(new AddAction(session, tasks, updatedTask));
          transaction.doit();
        }
      }
    });

    element.querySelector('.remove').onClick.listen((MouseEvent e) {
      new RemoveAction(session, tasks, task).doit();
    });
  }

  complete(bool completed) {
    _completed.checked = completed;
    if (completed) {
      element.classes.add('completed');
    } else {
      element.classes.remove('completed');
    }
  }

  retitle(String title) {
    _title.text = title;
    element.classes.remove('editing');
  }

  remove() {
    element.remove();
  }

  set visible(bool visible) {
    element.style.display = visible ? 'block' : 'none';
  }
}

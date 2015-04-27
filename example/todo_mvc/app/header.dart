part of todo_mvc_app;

class Header implements PastReactionApi {
  Tasks _tasks;

  InputElement _completeAll = querySelector('#complete-all');
  Element _undo = querySelector('#undo');
  Element _redo = querySelector('#redo');

  Header(TodoApp todoApp) {
    DomainSession session = todoApp.session;
    session.past.startPastReaction(this);
    _tasks = todoApp.clientTasks;

    _undo.style.display = 'none';
    _undo.onClick.listen((MouseEvent e) {
      session.past.undo();
    });

    _redo.style.display = 'none';
    _redo.onClick.listen((MouseEvent e) {
      session.past.redo();
    });

    _completeAll.onClick.listen((Event e) {
      var transaction = new Transaction('complete-all', session);
      if (_tasks.left.length == 0) {
        for (Task task in _tasks) {
          transaction.add(
              new SetAttributeAction(session, task, 'completed', false));
        }
      } else {
        for (Task task in _tasks.left) {
          transaction.add(
              new SetAttributeAction(session, task, 'completed', true));
        }
      }
      transaction.doit();
    });
  }

  updateDisplay() {
    var display = _tasks.length == 0 ? 'none' : 'block';
    _completeAll.style.display = display;
    var completedLength = _tasks.completed.length;
    _completeAll.checked = (completedLength == _tasks.length);
  }

  reactCannotUndo() {
    _undo.style.display = 'none';
  }

  reactCanUndo() {
    _undo.style.display = 'block';
  }

  reactCanRedo() {
    _redo.style.display = 'block';
  }

  reactCannotRedo() {
    _redo.style.display = 'none';
  }
}
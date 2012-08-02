
class History {

  int cursor = 0;

  List<Action> _actions;

  History() {
    _actions = new List<Action>();
  }

  add(Action action) {
    _removeRightOfCursor();
    _actions.add(action);
    _moveCursorForward();
  }

  _removeRightOfCursor() {
    for (int i = _actions.length - 1; i >= cursor; i--) {
      _actions.removeRange(i, 1);
    }
  }

  _moveCursorForward() {
    cursor++;
  }

  _moveCursorBackward() {
    if (cursor > 0) {
      --cursor;
    }
  }

  empty() {
    cursor = 0;
    _actions.removeRange(0, _actions.length);
  }

  bool undo() {
    if (_actions.length > 0) {
      _moveCursorBackward();
      Action action = _actions[cursor];
      return action.undo();
    }
    return false;
  }

  bool undoAll() {
    while (cursor > 0) {
      if (!undo()) {
        return false;
      }
    }
    return true;
  }

  bool redo() {
    if (_actions.length > 0) {
      _moveCursorBackward();
      Action action = _actions[cursor];
      return action.redo();
    }
    return false;
  }

  bool redoAll() {
    cursor = 0;
    while (cursor < _actions.length) {
      if (!redo()) {
        return false;
      }
    }
    return true;
  }

  display([String title='History']) {
    print('');
    print('======================================');
    print('$title                                ');
    print('======================================');
    print('');
    print('cursor: $cursor');
    for (Action action in _actions) {
      print('$action');
    }
    print('');
  }

}

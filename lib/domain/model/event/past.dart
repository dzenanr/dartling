part of dartling;

abstract class PastApi implements SourceOfPastReactionApi {

  add(ActionApi action);
  List<ActionApi> get actions;
  clear();
  bool get empty;
  bool get undoLimit;
  bool get redoLimit;

  bool doit();
  bool undo();
  bool redo();

}

class Past implements PastApi {

  int cursor = 0;
  List<BasicAction> _actions;

  List<PastReactionApi> _pastReactions;

  Past() {
    _actions = new List<BasicAction>();
    _pastReactions = new List<PastReactionApi>();
  }

  List<BasicAction> get actions => _actions;

  bool get empty => _actions.isEmpty;
  bool get undoLimit => empty || cursor == 0;
  bool get redoLimit => empty || cursor == _actions.length;

  add(BasicAction action) {
    _removeRightOfCursor();
    _actions.add(action);
    _moveCursorForward();
  }

  _removeRightOfCursor() {
    for (int i = _actions.length - 1; i >= cursor; i--) {
      _actions.removeRange(i, i + 1);
    }
  }

  _notifyUndoRedo() {
    if (undoLimit) {
      notifyCannotUndo();
    } else {
      notifyCanUndo();
    }
    if (redoLimit) {
      notifyCannotRedo();
    } else {
      notifyCanRedo();
    }
  }

  _moveCursorForward() {
    cursor++;
    _notifyUndoRedo();
  }

  _moveCursorBackward() {
    if (cursor > 0) {
      cursor--;
    }
    _notifyUndoRedo();
  }

  clear() {
    cursor = 0;
    _actions.clear();
    _notifyUndoRedo();
  }

  bool doit() {
    bool done = false;
    if (!empty) {
      BasicAction action = _actions[cursor];
      done = action.doit();
      _moveCursorForward();
    }
    return done;
  }

  bool undo() {
    bool undone = false;
    if (!empty) {
      _moveCursorBackward();
      BasicAction action = _actions[cursor];
      undone = action.undo();
    }
    return undone;
  }

  bool redo() {
    bool redone = false;
    if (!empty && !redoLimit) {
      BasicAction action = _actions[cursor];
      redone = action.redo();
      _moveCursorForward();
    }
    return redone;
  }

  bool doAll() {
    bool allDone = true;
    cursor = 0;
    while (cursor < _actions.length) {
      if (!doit()) {
        allDone = false;
      }
    }
    return allDone;
  }

  bool undoAll() {
    bool allUndone = true;
    while (cursor > 0) {
      if (!undo()) {
        allUndone = false;
      }
    }
    return allUndone;
  }

  bool redoAll() {
    bool allRedone = true;
    cursor = 0;
    while (cursor < _actions.length) {
      if (!redo()) {
        allRedone = false;
      }
    }
    return allRedone;
  }

  startPastReaction(PastReactionApi reaction) => _pastReactions.add(reaction);
  cancelPastReaction(PastReactionApi reaction) {
    _pastReactions.remove(reaction);
  }

  notifyCannotUndo() {
    for (PastReactionApi reaction in _pastReactions) {
      reaction.reactCannotUndo();
    }
  }

  notifyCanUndo() {
    for (PastReactionApi reaction in _pastReactions) {
      reaction.reactCanUndo();
    }
  }

  notifyCanRedo() {
    for (PastReactionApi reaction in _pastReactions) {
      reaction.reactCanRedo();
    }
  }

  notifyCannotRedo() {
    for (PastReactionApi reaction in _pastReactions) {
      reaction.reactCannotRedo();
    }
  }

  display([String title='Past Actions']) {
    print('');
    print('======================================');
    print('$title                                ');
    print('======================================');
    print('');
    print('cursor: $cursor');
    for (BasicAction action in _actions) {
      action.display();
    }
    print('');
  }

}

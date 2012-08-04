
abstract class Action {

  String name;
  String category;
  String state = 'started';
  String description;

  Action(this.name) {
    category = name;
  }

  abstract bool doit();
  abstract bool undo();
  abstract bool redo();

  toString() => 'action: $name; state: $state -- description: $description';

  display([String title='Action']) {
    print('');
    print('======================================');
    print('$title                                ');
    print('======================================');
    print('');
    print('$this');
    print('');
  }

}

class EntitiesAction extends Action {

  EntitiesAction(String name) : super(name);

  Entities entities;
  Entity entity;

  bool doit() {
    bool done = false;
    if (state == 'started') {
      if (name == 'add') {
        done = entities.add(entity);
      } else if (name == 'remove') {
        done = entities.remove(entity);
      } else {
        throw new ActionException(
        'Allowed actions on entities for execute are add or remove.');
      }
      if (done) {
        state = 'done';
        entities.past.add(this);
      }
    }
    return done;
  }

  bool undo() {
    bool undone = false;
    if (state == 'done' || state == 'redone') {
      if (name == 'add') {
        undone = entities.remove(entity);
      } else if (name == 'remove') {
        undone = entities.add(entity);
      } else {
        throw new ActionException(
          'Allowed actions on entities for undo are add or remove.');
      }
      if (undone) {
        state = 'undone';
      }
    }
    return undone;
  }

  bool redo() {
    bool redone = false;
    if (state == 'undone') {
      if (name == 'add') {
        redone = entities.add(entity);
      } else if (name == 'remove') {
        redone = entities.remove(entity);
      } else {
        throw new ActionException(
        'Allowed actions on entities for redo are add or remove.');
      }
      if (redone) {
        state = 'redone';
      }
    }
    return redone;
  }

}

class EntityAction extends Action {

  EntityAction(String name) : super(name);

  Entity entity;

  String property;
  Object before;
  Object after;

  bool doit() {
    bool done = false;
    if (state == 'started') {
      if (name == 'set' && category == 'attribute') {
        done = entity.setAttribute(property, after);
      } else if (name == 'set' && category == 'parent') {
        done = entity.setParent(property, after);
      } else if (name == 'set' && category == 'child') {
        done = entity.setChild(property, after);
      } else {
        throw new ActionException(
          'Allowed actions on entity for execute are set attribute, parent or child.');
      }
      if (done) {
        state = 'done';
        entity.past.add(this);
      }
    }
    return done;
  }

  bool undo() {
    bool undone = false;
    if (state == 'done' || state == 'redone') {
      if (name == 'set' && category == 'attribute') {
        undone = entity.setAttribute(property, before);
      } else if (name == 'set' && category == 'parent') {
        undone = entity.setParent(property, before);
      } else if (name == 'set' && category == 'child') {
        undone = entity.setChild(property, before);
      } else {
        throw new ActionException(
          'Allowed actions on entity for undo are set attribute, parent or child.');
      }
      if (undone) {
        state = 'undone';
      }
    }
    return undone;
  }

  bool redo() {
    bool redone = false;
    if (state == 'undone') {
      if (name == 'set' && category == 'attribute') {
        redone = entity.setAttribute(property, after);
      } else if (name == 'set' && category == 'parent') {
        redone = entity.setParent(property, after);
      } else if (name == 'set' && category == 'child') {
        redone = entity.setChild(property, after);
      } else {
        throw new ActionException(
          'Allowed actions on entity for redo are set attribute, parent or child.');
      }
      if (redone) {
        state = 'redone';
      }
    }
    return redone;
  }

  toString() => 'action: $name; category: $category; state: $state -- '
                'property: $property; before: $before; after: $after';

}

class Past {

  int cursor = 0;

  List<Action> _actions;
  List<PastReaction> _reactions;

  Past() {
    _actions = new List<Action>();
    _reactions = new List<PastReaction>();
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
    if (cursor == 1) {
      notifyYesPast();
    }
  }

  _moveCursorBackward() {
    if (cursor > 0) {
      cursor--;
    }
    if (cursor == 0) {
      notifyNoPast();
    }
  }

  clear() {
    cursor = 0;
    _actions.clear();
    notifyNoPast();
  }

  bool get empty() => _actions.isEmpty();

  bool undo() {
    bool undone = false;
    if (!empty) {
      _moveCursorBackward();
      Action action = _actions[cursor];
      undone = action.undo();
    }
    return undone;
  }

  bool redo() {
    bool redone = false;
    if (!empty) {
      Action action = _actions[cursor];
      redone = action.redo();
      _moveCursorForward();
    }
    return redone;
  }

  bool doAll() {
    bool allExecuted = true;
    cursor = 0;
    while (cursor < _actions.length) {
      if (!redo()) {
        allExecuted = false;
        break;
      }
    }
    return allExecuted;
  }

  bool undoAll() {
    bool allUndone = true;
    while (cursor > 0) {
      if (!undo()) {
        allUndone = false;
        break;
      }
    }
    return allUndone;
  }

  startReaction(PastReaction reaction) => _reactions.add(reaction);
  cancelReaction(PastReaction reaction) {
    int index = _reactions.indexOf(reaction, 0);
    _reactions.removeRange(index, 1);
  }

  notifyNoPast() {
    for (PastReaction reaction in _reactions) {
      reaction.reactNoPast();
    }
  }

  notifyYesPast() {
    for (PastReaction reaction in _reactions) {
      reaction.reactYesPast();
    }
  }

  display([String title='Past Actions']) {
    print('');
    print('======================================');
    print('$title                                ');
    print('======================================');
    print('');
    print('cursor: $cursor');
    for (Action action in _actions) {
      action.display();
    }
    print('');
  }

}





abstract class ActionApi {

  abstract bool doit();
  abstract bool undo();
  abstract bool redo();

}

abstract class TransactionApi extends ActionApi {

  abstract add(ActionApi action);

}

abstract class PastApi implements SourceOfPastReactionApi {

  abstract add(ActionApi action);
  abstract clear();
  abstract bool get empty;

  abstract bool doit();
  abstract bool undo();
  abstract bool redo();

}

abstract class Action implements ActionApi {

  String name;
  String category;
  String state = 'started';
  String description;

  DomainSession session;

  bool partOfTransaction = false;

  Action(this.name, this.session);

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

abstract class EntitiesAction extends Action {

  Entities entities;
  ConceptEntity entity;

  EntitiesAction(String name, DomainSession session,
                 this.entities, this.entity) : super(name, session);

  bool doit() {
    bool done = false;
    if (state == 'started') {
      if (name == 'add') {
        done = entities.add(entity);
      } else if (name == 'remove') {
        done = entities.remove(entity);
      } else {
        throw new ActionException(
        'Allowed actions on entities for doit are add or remove.');
      }
      if (done) {
        state = 'done';
        if (!partOfTransaction) {
          session.past.add(this);
          session.domainModels.notifyActionReactions(this);
        }
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
        if (!partOfTransaction) {
          session.domainModels.notifyActionReactions(this);
        }
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
        if (!partOfTransaction) {
          session.domainModels.notifyActionReactions(this);
        }
      }
    }
    return redone;
  }

}

class AddAction extends EntitiesAction {

  AddAction(DomainSession session, Entities entities,
            ConceptEntity entity) : super('add', session, entities, entity) {
    category = 'entity';
  }

}

class RemoveAction extends EntitiesAction {

  RemoveAction(DomainSession session, Entities entities,
               ConceptEntity entity) : super('remove', session, entities, entity) {
    category = 'entity';
  }

}

abstract class EntityAction extends Action {

  ConceptEntity entity;
  String property;
  Object before;
  Object after;

  EntityAction(DomainSession session, this.entity, this.property, this.after) :
    super('set', session) {
    before = entity.getAttribute(property);
  }

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
          'Allowed actions on entity for doit are set attribute, parent or child.');
      }
      if (done) {
        state = 'done';
        if (!partOfTransaction) {
          session.past.add(this);
          session.domainModels.notifyActionReactions(this);
        }
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
        if (!partOfTransaction) {
          session.domainModels.notifyActionReactions(this);
        }
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
        if (!partOfTransaction) {
          session.domainModels.notifyActionReactions(this);
        }
      }
    }
    return redone;
  }

  toString() => 'action: $name; category: $category; state: $state -- '
                'property: $property; before: $before; after: $after';

}

class SetAttributeAction extends EntityAction {

  SetAttributeAction(DomainSession session, ConceptEntity entity,
                     String property, Object after) :
    super(session, entity, property, after) {
    category = 'attribute';
  }

}

class SetParentAction extends EntityAction {

  SetParentAction(DomainSession session, ConceptEntity entity,
                  String property, Object after) :
    super(session, entity, property, after) {
    category = 'parent';
  }

}

class SetChildAction extends EntityAction {

  SetChildAction(DomainSession session, ConceptEntity entity,
                 String property, Object after) :
    super(session, entity, property, after) {
    category = 'child';
  }

}

class Transaction extends Action implements TransactionApi {

  Past _actions;

  Transaction(String name, DomainSession session) : super(name, session) {
    _actions = new Past();
  }

  add(Action action) {
    _actions.add(action);
    action.partOfTransaction = true;
  }

  bool doit() {
    bool done = false;
    if (state == 'started') {
      done = _actions.doAll();
      if (done) {
        state = 'done';
        session.past.add(this);
        session.domainModels.notifyActionReactions(this);
      } else {
        var undone = _actions.undoAll();
      }
    }
    return done;
  }

  bool undo() {
    bool undone = false;
    if (state == 'done' || state == 'redone') {
      undone = _actions.undoAll();
      if (undone) {
        state = 'undone';
        session.domainModels.notifyActionReactions(this);
      } else {
        _actions.doAll();
      }
    }
    return undone;
  }

  bool redo() {
    bool redone = false;
    if (state == 'undone') {
      redone = _actions.redoAll();
      if (redone) {
        state = 'redone';
        session.domainModels.notifyActionReactions(this);
      } else {
        _actions.undoAll();
      }
    }
    return redone;
  }

}

class Past implements PastApi {

  int cursor = 0;
  List<Action> _actions;

  List<PastReactionApi> _pastReactions;

  Past() {
    _actions = new List<Action>();
    _pastReactions = new List<PastReactionApi>();
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

  bool get empty => _actions.isEmpty();

  bool doit() {
    bool done = false;
    if (!empty) {
      Action action = _actions[cursor];
      done = action.doit();
      _moveCursorForward();
    }
    return done;
  }

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
    int index = _pastReactions.indexOf(reaction, 0);
    _pastReactions.removeRange(index, 1);
  }

  notifyNoPast() {
    for (PastReactionApi reaction in _pastReactions) {
      reaction.reactNoPast();
    }
  }

  notifyYesPast() {
    for (PastReactionApi reaction in _pastReactions) {
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



part of dartling;

abstract class ActionApi {

  bool get done;
  bool get undone;
  bool get redone;

  bool doit();
  bool undo();
  bool redo();

}

abstract class TransactionApi extends ActionApi {

  add(ActionApi action);
  PastApi get past;

}

abstract class BasicAction implements ActionApi {

  String name;
  String category;
  String state = 'started';
  String description;

  DomainSession session;

  bool partOfTransaction = false;

  BasicAction(this.name, this.session);

  bool doit();
  bool undo();
  bool redo();

  bool get started => state == 'started' ? true : false;
  bool get done => state == 'done' ? true : false;
  bool get undone => state == 'undone' ? true : false;
  bool get redone => state == 'redone' ? true : false;

  toString() => 'action: $name; state: $state -- description: $description';

  display({String title: 'BasicAction'}) {
    print('');
    print('======================================');
    print('$title                                ');
    print('======================================');
    print('');
    print('$this');
    print('');
  }

}

abstract class EntitiesAction extends BasicAction {

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
        throw new ActionError(
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
        throw new ActionError(
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
        throw new ActionError(
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

abstract class EntityAction extends BasicAction {

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
        throw new ActionError(
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
        throw new ActionError(
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
        throw new ActionError(
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

class Transaction extends BasicAction implements TransactionApi {

  Past _actions;

  Transaction(String name, DomainSession session) : super(name, session) {
    _actions = new Past();
  }

  Past get past => _actions;

  add(BasicAction action) {
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





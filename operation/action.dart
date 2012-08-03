
abstract class Action {

  String name;
  String category;
  String description;

  Action(this.name) {
    category = name;
  }

  abstract bool undo();

  toString() => 'action: $name -- description: $description';

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

  bool undo() {
    bool undone = false;
    if (name == 'add') {
      undone = entities.remove(entity);
    } else if (name == 'remove') {
      undone = entities.add(entity);
    } else {
      throw new ActionException(
        'Allowed actions on entities for undo are add or remove.');
    }
    return undone;
  }

}

class EntityAction extends Action {

  EntityAction(String name) : super(name);

  Entity entity;

  String property;
  Object before;
  Object after;

  bool undo() {
    bool undone = false;
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
    return undone;
  }

  toString() => 'action: $name; category: $category -- '
                'property: $property; before: $before; after: $after';

}



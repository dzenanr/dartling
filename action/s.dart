
abstract class Action {

  String name;
  String category;
  String state = 'done';
  String description;

  Action(this.name) {
    category = name;
  }

  toString() => 'action: $name; description: $description';

}

class EntitiesAction extends Action {

  EntitiesAction(String name) : super(name);

  Entities entities;
  Entity entity;

}

class EntityAction extends Action {

  EntityAction(String name) : super(name);

  Entity entity;

  String property;
  Object before;
  Object after;

  toString() => 'action: $name; category: $category property; '
                'property: $property; before: $before; after: $after';

}

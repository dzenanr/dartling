
class Action {
  
  String name;
  String status = 'started';
  String description;
  
  Action(this.name);
  
  Entities entities;
  Entity entity;
  
  toString() => 'action: $name; description: $description';
  
}



Dartling
3-clause license ("New BSD License" or "Modified BSD License")

Dartling (https://github.com/dzenanr/Dartling) is a domain model framework for web application prototypes. A model consists of concepts, concept attributes and concept neighbors (two neighbors make a relationship between two concepts). 

A graphical model designed in MagicBoxes (https://github.com/dzenanr/MagicBoxes) is transformed into JSON (http://www.json.org/, http://jsonformatter.curiousconcept.com/) representation, imported to Dartling and converted to the meta model. Then, the model may be used without almost any additional programming for quick prototypes.

Dartling API

To understand what you can do with Dartling examine its API defined in EntitiesApi and EntityApi abstract classes.

abstract class EntitiesApi<T extends Entity<T>> 
    implements Iterable<T> {
  abstract Entities<T> newEntities();
  abstract Concept get concept();
  abstract Entities<T> get source();
  abstract Errors get errors();
  abstract int get count();
  abstract bool get empty();

  abstract bool preAdd(T entity);
  abstract bool add(T entity);
  abstract bool preRemove(T entity);
  abstract bool remove(T entity);

  abstract Iterator<T> iterator();
  abstract void forEach(Function f);
  abstract bool every(Function f);
  abstract bool some(Function f);

  abstract bool contains(T entity);
  abstract T last();
  abstract T find(Oid oid);
  abstract T findByCode(String code);
  abstract T findById(Id id);
  abstract T findByAttributeId(String code, Object attribute);
  abstract T findByAttribute(String code, Object attribute);

  abstract Entities<T> select(Function f);
  abstract Entities<T> selectByParent(String code, 
    Object parent);
  abstract Entities<T> selectByAttribute(String code, 
    Object attribute);
  abstract Entities<T> order();
  abstract Entities<T> orderByFunction(Function f);

  abstract void clear();
  abstract Entities<T> copy();
  abstract List<T> get list();
}

abstract class EntityApi<T extends Entity<T>> 
    implements Comparable {
  abstract Entity<T> newEntity();
  abstract Concept get concept();
  abstract Oid get oid();
  abstract String get code();
  abstract void set code(String code);

  abstract Object getAttribute(String name);
  abstract bool setAttribute(String name, Object value);
  abstract String getStringFromAttribute(String name);
  abstract bool setStringToAttribute(String name, 
    String string);
  abstract Entity getParent(String name);
  abstract bool setParent(String name, Entity entity);
  abstract Entities getChild(String name);
  abstract bool setChild(String name, Entities entities);

  abstract Id get id();
  abstract T copy();
  abstract bool equalOids(T entity);
  abstract bool equals(other);
  abstract int compareTo(T entity);
  abstract String toString();
}

abstract class ActionApi {
  abstract bool doit();
  abstract bool undo();
  abstract bool redo();
}

The following short examples show how the API is used for the Project concept that has only two attributes: name and description. The name attribute is also an identifier.

A subset of projects that relate to programming may be obtained by the onProgramming bool function.

Projects programmingProjects = projects.select((p) => p.onProgramming);

A project is found quickly by its id.

Project project = projects.findByAttributeId('name', 'Dartling');

Projects may be sorted by using the compareName int function.

Projects orderedProjects =
    projects.orderByFunction((m,n) => m.compareName(n));

Dartling has actions and transactions to support unrestricted undos and redos. A transaction is an action that contains other actions.

var product = new Project(projectConcept);
product.name = 'Dartling';
product.description = 'Programming Dartling.';
var action = new AddAction(session, projects, product);
action.doit();
action.undo();
action.redo();

Advanced Example

The domain (CategoryQuestion) model (Link) has the most commonly used patterns:

  optional relationship (0..N -- 0..1);
  mandatory relationship (0..N -- 1..1);
  id dependent relationship (0..N -- 1..1 id);
  reflexive relationship (0..N -- 0..1 on the same concept);
  twin relationships (0..N -- 1..1 id - 2 relationships 
    between the same 2 concepts).

From the graphical model (https://dl.dropbox.com/u/161496/dart/mb/model/CategoryQuestion_Link.png), 
the JSON text 
(https://dl.dropbox.com/u/161496/dart/mb/model/CategoryQuestionLink.txt) 
is generated in MagicBoxes and used in Dartling to create its meta model. The meta model is used in almost all methods of the Dartling’s API.

Dartling Project Structure

The Dartling project has three generic and two specific folders. Code in the generated folder will be generated soon. It will be generated from a domain model. The specific folder is a place for the customization of the domain model. Tests are created in the test folder.

Dartling
  generated
    default
      project
        entries.dart
        projects.dart
  meta
    attributes.dart
    children.dart
    concepts.dart
    domains.dart
    models.dart
    neighbor.dart
    parents.dart
    property.dart
    types.dart
  repository
    domain
      model
        event
          actions.dart
          reactions.dart
        exception
          errors.dart
          exceptions.dart
        transfer
          json.dart
        entities.dart
        entity.dart
        entries.dart
        id.dart
        oid.dart
      models.dart
      session.dart
    repository.dart
  specific
    default
      project
        projects.dart
  test
    specific
      default
        project
          data.dart
  Dartling.dart

More details: http://goo.gl/7YGAq


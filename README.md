# ![Alt dartling](https://raw.github.com/dzenanr/dartling/master/resources/dartling.png)

[dartling](http://pub.dartlang.org/packages/dartling) is a model-driven data framework 
for design, code generation and use of Dart models.
Its open source license is the 3-clause BSD license --
["New BSD License" or "Modified BSD License"](http://en.wikipedia.org/wiki/BSD_license).

dartling model consists of concepts, concept attributes and concept neighbors.
Two neighbors make a relationship between two concepts. A relationship has two
directions, each direction going from one concept to another neighbor concept.
Standard one-to-many and many-to-many relationships are supported. When both
concepts are the same, the relationship is reflexive. When there are two
relationships between the same but different concepts, the relationships are
twins.

A graphical model designed in
[Model Concepts](https://github.com/dzenanr/model_concepts) is transformed into
[json](http://www.json.org/) representation that is imported to
[dartling_gen](https://github.com/dzenanr/dartling_gen).
In dartling_gen, the json document is used to generate code for the model and
its context project.
[dartling_default_app](http://pub.dartlang.org/packages/dartling_default_app)
is used to interpret a dartling model and navigate through the model,
starting by its entry points.

**What Can You Do with dartling?**

* design a domain model in Model Concepts
* transform the model into a json representation
* generate code from the json representation for a new dartling project in
  [dartling_gen](https://github.com/dzenanr/dartling_gen)
* init your model with some data
* test your model with some data
* add some specific code if you wish
* run the default application that interprets the model

**What Could You Do with dartling in Future?**

* [research projects](https://docs.google.com/document/d/15rvqT1QOEusUniqNJOad-vwJDwRLombVmG3X87T6xkM/edit?usp=sharing)
* let me know what you would like to see in dartling?
* join me, as a regular project member, in making dartling a darling of the Dart community
* if you are a student
  [work with me](https://docs.google.com/document/d/1cZWkOlzy8lqHhe_0q0mEyQlvI-Xjc8q07BwLaWqqyE8/edit?usp=sharing)
  on making dartling easier to learn

## dartling API

dartling repository may have several domains. A domain may have several models.
A model has entry points that are entities. From an entity in one of entry
entities, child entities may be obtained. Data navigation is done by following
parent or child neighbors.

A dartling model has access to actions, action pre and post validations,
error handling, select data views, view update propagations, reaction events,
transactions, sessions with the trans(action) past,
so that undos and redos on the model may be done.
You can add, remove, update, validate, find, select and order data. Actions or
transactions may be used to support unrestricted undos and redos in a domain
session. A transaction is an action that contains other actions. The domain
allows any object to react to actions in its models.

To understand what else you can do with dartling examine its API defined in
abstract classes with Api at the end of their names. The two most important ones
are EntitiesApi (in lib/domain/model/entities.dart) and EntityApi
(in lib/domain/model/entity.dart).

## Examples

dartling has several examples, all at [dzenanr](https://github.com/dzenanr),
which show how different web applications may be developed quickly based on a
domain model generated from the json representation of a graphical model. One
of them is [art_pen](https://github.com/dzenanr/art_pen) (DArt.Pen), which is
a version of the Logo programming language for children.
Other examples are:
[dartling_examples](https://github.com/dzenanr/dartling_examples) (3 typical models),
[dartling_tasks](https://github.com/dzenanr/dartling_tasks) (a many-to-many relationship),
[game_parking](https://github.com/dzenanr/game_parking) (a game based on Rush Hour),
[travel_impressions](https://github.com/dzenanr/travel_impressions) (with the focus on data modeling or model design),
[concept_attribute](https://github.com/dzenanr/concept_attribute) (with different categories of test data that can be used in the generation of tests),
[dartling_todos](https://github.com/dzenanr/dartling_todos) (with action undos),
[dartling_dwt_todo_mvc_spirals](https://github.com/dzenanr/dartling_dwt_todo_mvc_spirals) (with Dart Web Toolkit),
[todo_mysql](https://github.com/dzenanr/todo_mysql) (todo client - mysql server),
[todo_mongodb](https://github.com/dzenanr/todo_mongodb) (todo client - mongodb server),
[dartling_types](https://github.com/dzenanr/dartling_types) (a generic web component done by meta-programming in dartling).

### Models

* [default_project](https://dl.dropbox.com/u/161496/dart/models/default_project.png)
* [art_pen](https://dl.dropbox.com/u/161496/dart/models/art_pen.png)
* [game_parking](https://dl.dropbox.com/u/161496/dart/models/game_parking.png)
* [category_keyword](https://dl.dropbox.com/u/161496/dart/models/category_keyword.png)
* [category_question_link](https://dl.dropbox.com/u/161496/dart/models/category_question_link.png)

## dartling Project Structure##

The dartling project has three folders: lib, test and web. The lib folder has
the gen subfolder where the code is generated from a domain model and
regenerated if the model changes. A programmer should not change anything in
the gen folder.

The domain (your domain name) folder has the model (your model name) folder
that contains the json folder with json representations of the model and its
data. The model.dart file in the model folder contains a model from Model Concepts.
The data.dart file in the json folder contains data of the model.

## More Details

[**dartling: Domain Model Framework**](http://goo.gl/Fd08zZ)

[**On Dart g+ page**](https://plus.google.com/+OndartMe)

[**On Dart blog**](http://dzenanr.github.io/)

[**On Dart education**](http://ondart.me/)

[*Learning Dart*](http://learningdart.org/)

[*Version History*](CHANGELOG.md)








# ![Alt dartling] (https://raw.github.com/dzenanr/dartling/master/resources/dartling.png)

[dartling] (https://github.com/dzenanr/dartling) is a domain model framework. Its open source license is the 3-clause BSD license -- ["New BSD License" or "Modified BSD License"] (http://en.wikipedia.org/wiki/BSD_license).

dartling model consists of concepts, concept attributes and concept neighbors. Two neighbors make a relationship between two concepts. A relationship has two directions, each direction going from one concept to another neighbor concept. When both concepts are the same, the relationship is reflexive. When there are two relationships between the same but different concepts, the relationships are twins.

A graphical model designed in [Magic Boxes](https://github.com/dzenanr/magic_boxes) is transformed into [JSON] (http://www.json.org/) representation, imported to dartling and converted to a meta model. After the code generation, the model may be used without almost any additional programming for quick prototypes.

**What Can You Do with dartling?**

* design a domain model in Magic Boxes
* transform the model into a JSON representation
* prepare your dartling project based on the [dartling_skeleton] (https://github.com/dzenanr/dartling_skeleton) project
* copy the JSON representation of the model to your project
* generate the code for your project from your project
* test your model with some data
* init your model with some data
* add some specific code if you wish
* run the prototype application that uses the model and dartling web components

**What Could You Do with dartling in Future?**

* [research guidelines] 
  (https://docs.google.com/document/d/15rvqT1QOEusUniqNJOad-vwJDwRLombVmG3X87T6xkM/edit)
* let me know what you would like to see in dartling?
* join me in making dartling a darling of the Dart community
* if you are a student [work with me]  
  (https://docs.google.com/document/d/1cZWkOlzy8lqHhe_0q0mEyQlvI-Xjc8q07BwLaWqqyE8/edit)
  on making dartling easier to learn

## dartling API

dartling repository may have several domains. A domain may have several models. A model has entry points that are entities. From an entity in one of entry entities, child entities may be obtained. Data navigation is done by following parent or child neighbors.

You can add, remove, update, find, select and order data. Actions or transactions may be used to support unrestricted undos and redos in a domain session. A transaction is an action that contains other actions. The domain allows any object to react to actions in its models.

To understand what else you can do with dartling examine its API defined in abstract classes with Api at the end of their names. The two most important ones are EntitiesApi and EntityApi.

## Examples

dartling has five examples that show how different web applications may be developed quickly based on a domain model generated from the JSON representation of a graphical model. One of them is [Art.Pen] (http://pancake.io/976ed5/dart/art/pen/d_art_pen.html), which is a version of the Logo programming language for children. I use Art.Pen to teach basic control structures in programming by drawing fun "art" with positional pen commands. Another example is [Game.Parking] (http://pancake.io/976ed5/dart/game/parking/game_parking.html), which is a strategy puzzle designed by a mathematician to teach children abstract thinking. The other three examples are models with standard modeling patterns: one-to-many, many-to-many and reflexive relationships.

**Warning**: I have run my projects only in the [Chrome] (https://www.google.com/intl/en/chrome/browser/) browser.

### Models

* [default_project] (https://dl.dropbox.com/u/161496/dart/models/default_project.png)
* [art_pen] (https://dl.dropbox.com/u/161496/dart/models/art_pen.png)
* [game_parking] (https://dl.dropbox.com/u/161496/dart/models/game_parking.png)
* [category_keyword] (https://dl.dropbox.com/u/161496/dart/models/category_keyword.png)
* [category_question_link] (https://dl.dropbox.com/u/161496/dart/models/category_question_link.png)

## dartling Project Structure

The dartling project has three folders: lib, test and web. The lib folder has the gen subfolder where the code is generated from a domain model and regenerated if the model changes. A programmer should not change anything in the gen folder.

The domain (your domain name) folder has the model (your model name) folder that contains the json folder with JSON representations of the model and its data. The model.dart file in the model folder contains a model from Magic Boxes. The data.dart file in the json folder contains data of the model.

## dartling Skeleton

[dartling Skeleton](https://github.com/dzenanr/dartling_skeleton) is a [Dart Editor] 
(http://www.dartlang.org/docs/editor/getting-started/) 
project template for a new dartling project.

## More Details
 
[**About dartling**] (https://docs.google.com/document/d/1IYs9jqWfKXmflTIGYob7qIE01wwJpWRQkWHQXZLNSvo/edit)

[**On Dart g+ page**] (https://plus.google.com/b/113649577593294551754/113649577593294551754/posts)

[**On Dart blog**] (http://dzenanr.github.com/)

[**On Dart course**] (http://ondart.me/)

### ![Alt dartling] (https://raw.github.com/dzenanr/dartling/master/resources/dartling5.png)
image done by Rafik Benmoussa




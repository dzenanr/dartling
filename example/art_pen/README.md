# Dartling Project

[Dartling Skeleton] (https://github.com/dzenanr/dartling_skeleton) is a project template for a new Dartling project.

**What Can You Do with Dartling?**

* design a domain model in Magic Boxes
* transform the model into a JSON representation
* prepare your dartling project based on the dartling_skeleton.dart project
* copy the JSON representation of the model to your project
* generate the code for your project from your project
* test your model with some data
* init your model with some data
* add some specific code if you wish
* run the prototype application that uses the model and Dartling web components

# Dartling

[Dartling] (https://github.com/dzenanr/dartling) is a domain model framework for web application prototypes. Its open source license is the 3-clause BSD license -- ["New BSD License" or "Modified BSD License"] (http://en.wikipedia.org/wiki/BSD_license).

Dartling model consists of concepts, concept attributes and concept neighbors. Two neighbors make a relationship between two concepts. A relationship has two directions, each direction going from one concept to another neighbor concept. When both concepts are the same, the relationship is reflexive. When there are two relationships between the same but different concepts, the relationships are twins.

A graphical model designed in [Magic Boxes](https://github.com/dzenanr/magic_boxes) is transformed into [JSON] (http://www.json.org/) representation, imported to Dartling and converted to the meta model. Then, the model may be used without almost any additional programming for quick prototypes.

## Dartling API

Dartling repository may have several domains. A domain may have several models. A model has entry points that are entities. From an entity in one of the entry entities, child entities may be obtained. Data navigation is done by following parent or child neighbors.

You can add, remove, update, find, select and order data. Actions or transactions may be used to support unrestricted undos and redos in a domain session. A transaction is an action that contains other actions. The domain allows any object to react to actions in its models.

To understand what else you can do with Dartling examine its API defined in abstract classes with Api at the end of their names. The two most important ones are EntitiesApi and EntityApi.

## Example

The [Link model](https://dl.dropbox.com/u/161496/dart/mb/model/Link2.png) has the most commonly used patterns: 
* optional relationship (0..N -- 0..1), 
* id dependent relationship (0..N -- 1..1 id), 
* and many-to-many relationship (represented as two one-to-many id dependent relationships).

The [JSON text](https://dl.dropbox.com/u/161496/dart/mb/model/Link2.txt) is generated in Magic Boxes and used in Dartling to create its meta model. The meta model is used in almost all methods of the Dartling’s API.

## Dartling Project Structure

The Dartling project has two folders: data and view. The data folder has the gen subfolder where the code is generated from a domain model and regenerated if the model changes. A programmer should not change anything in the gen folder.

The data folder contains JSON representation of a model and its data. The model.dart file contains a model from Magic Boxes. The data.dart file contains data of the model. 

[**More details**] (https://docs.google.com/document/d/1IYs9jqWfKXmflTIGYob7qIE01wwJpWRQkWHQXZLNSvo/edit)

[**New project**] (https://docs.google.com/document/d/1n9dBtZskRPyy57whjKRzRl7gKG2b5KVZVghViGxAEMg/edit)

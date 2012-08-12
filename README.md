

Dartling

Dartling (https://github.com/dzenanr/Dartling) is a domain model framework for web application prototypes. Its open source license is the 3-clause BSD license -- "New BSD License" or "Modified BSD License" (http://en.wikipedia.org/wiki/BSD_license).

Dartling model consists of concepts, concept attributes and concept neighbors. Two neighbors make a relationship between two concepts. A relationship has two directions, each direction going from one concept to another neighbor concept. When both concepts are the same, the relationship is reflexive. When there are two relationships between the same but different concepts, the relationships are twins.

A graphical model designed in MagicBoxes (https://github.com/dzenanr/MagicBoxes) is transformed into JSON (http://www.json.org/, http://jsonformatter.curiousconcept.com/) representation, imported to Dartling and converted to the meta model. Then, the model may be used without almost any additional programming for quick prototypes.

Dartling API

Dartling repository may have several domains. A domain may have several models. A model has entry points that are entities. From an entity in one of entry entities, child entities may be obtained. Data navigation is done by following parent or child neighbors.

You can add, remove, update, find, select and order data. Actions or transactions may be used to support unrestricted undos and redos in a domain session. A transaction is an action that contains other actions. The domain allows any object to react to actions in its models.

To understand what else you can do with Dartling examine its API defined in abstract classes with Api at the end of their names. The two most important ones are EntitiesApi and EntityApi.

Intermediate Example

The Link model (https://dl.dropbox.com/u/161496/dart/mb/model/Link2.png) has the most commonly used patterns: optional relationship (0..N -- 0..1), id dependent relationship (0..N -- 1..1 id), and many-to-many relationship (represented as two one-to-many id dependent relationships).

The JSON text (https://dl.dropbox.com/u/161496/dart/mb/model/Link2.txt) is generated in MagicBoxes and used in Dartling to create its meta model and the model without data, which are created in tests.

Advanced Example

The Link model of the CategoryQuestion domain has also some advanced model patterns: mandatory relationship (0..N -- 1..1), reflexive relationship (0..N -- 0..1 on the same concept), and
twin relationships (0..N -- 1..1 id 2 relationships between the same 2 concepts).

From the graphical model (https://dl.dropbox.com/u/161496/dart/mb/model/CategoryQuestion_Link.png), 
the JSON text 
(https://dl.dropbox.com/u/161496/dart/mb/model/CategoryQuestionLink.txt) 
is generated in MagicBoxes and used in Dartling to create its meta model. The meta model is used in almost all methods of the Dartling’s API.

Dartling Project Structure

The Dartling project has three generic (generated, meta, repository) and two specific folders (specific, test). Code in the generated folder will be generated soon. It will be generated from a domain model. The specific folder is a place for the customization of the domain model. Tests are created in the test folder.

More details: http://goo.gl/7YGAq


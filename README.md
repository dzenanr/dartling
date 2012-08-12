

Dartling

3-clause license ("New BSD License" or "Modified BSD License")

Dartling (https://github.com/dzenanr/Dartling) is a domain model framework for web application prototypes. A model consists of concepts, concept attributes and concept neighbors (two neighbors make a relationship between two concepts). 

A graphical model designed in MagicBoxes (https://github.com/dzenanr/MagicBoxes) is transformed into JSON (http://www.json.org/, http://jsonformatter.curiousconcept.com/) representation, imported to Dartling and converted to the meta model. Then, the model may be used without almost any additional programming for quick prototypes.

Dartling API

To understand what you can do with Dartling examine its API defined in abstract classes with Api at the end of their names. The two most important are EntitiesApi and EntityApi.

The following short examples show how the API is used for the Project concept that has only two attributes: name and description. The name attribute is also an identifier.

A subset of projects that relate to programming may be obtained by the onProgramming bool function.

Projects programmingProjects = projects.select((p) => p.onProgramming);

A project is found quickly by its id.

Project project = projects.findByAttributeId('name', 'Dartling');

Projects may be sorted by using the compareName int function.

Projects orderedProjects =
    projects.orderByFunction((m,n) => m.compareName(n));

Dartling has actions and transactions to support unrestricted undos and redos. A transaction is an action that contains other actions.

Advanced Example

The domain (CategoryQuestion) model (Link) has the most commonly used patterns.

From the graphical model (https://dl.dropbox.com/u/161496/dart/mb/model/CategoryQuestion_Link.png), 
the JSON text 
(https://dl.dropbox.com/u/161496/dart/mb/model/CategoryQuestionLink.txt) 
is generated in MagicBoxes and used in Dartling to create its meta model. The meta model is used in almost all methods of the Dartling’s API.

Dartling Project Structure

The Dartling project has three generic and two specific folders. Code in the generated folder will be generated soon. It will be generated from a domain model. The specific folder is a place for the customization of the domain model. Tests are created in the test folder.

More details: http://goo.gl/7YGAq


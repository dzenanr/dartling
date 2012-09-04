
class RepoMainSection {

  View view;

  RepoMainSection(this.view) {
    var menuView = new View.from(view, "menu");
    new RepoMenuBar(menuView);

    var entitiesView = new View.from(view, "entities");
    new RepoEntitiesSection(entitiesView);
  }

}

class RepoMenuBar {

  View view;

  RepoMenuBar(this.view) {
    var repo = view.repo;
    var domains = repo.domains;
    String section = '';
    section = '${section}<nav> \n';
    section = '${section}  <ul> \n';
    for (Domain domain in domains) {
      DomainModels domainModels = repo.getDomainModels(domain.code);
      for (Model model in domain.models) {
        section = '${section}    <li>${domain.code}.${model.code} \n';
        section = '${section}      <ul> \n';
        ModelEntries modelEntries = domainModels.getModelEntries(model.code);
        for (Concept concept in model.entryConcepts) {
          Entities entryEntities = modelEntries.getEntry(concept.code);
          section = '${section}        <li><button id="${domain.code}'
                    '${model.code}${concept.code}Button">Show ${concept.codes}'
                    '</button></li> \n';
        }
        section = '${section}      </ul> \n';
        section = '${section}    </li> \n';
      }
    }

    section = '${section}    <li>About \n';
    section = '${section}      <ul> \n';
    section = '${section}        <li> \n';
    section = '${section}          <a href="https://github.com/dzenanr/'
              'dartling.dart"> \n';
    section = '${section}            Dartling \n';
    section = '${section}          </a> in \n';
    section = '${section}          <a href="http://www.dartlang.org/"> \n';
    section = '${section}            Dart \n';
    section = '${section}          </a> \n';
    section = '${section}        </li> \n';
    section = '${section}        <li> \n';
    section = '${section}          <a href="https://plus.google.com/u/0/b/'
              '113649577593294551754/"> \n';
    section = '${section}            <img src="view/css/img/ondart0.png"/> \n';
    section = '${section}          </a> \n';
    section = '${section}        </li> \n';
    section = '${section}      </ul> \n';
    section = '${section}    </li> \n';

    section = '${section}  </ul> \n';
    section = '${section}</nav> \n';
    view.document.query('#${view.did}').innerHTML = section;

    for (Domain domain in domains) {
      DomainModels domainModels = repo.getDomainModels(domain.code);
      for (Model model in domain.models) {
        ModelEntries modelEntries = domainModels.getModelEntries(model.code);
        for (Concept concept in model.entryConcepts) {
          Entities entryEntities = modelEntries.getEntry(concept.code);
          ButtonElement buttonElement =
              document.query('#${domain.code}${model.code}${concept.code}Button');
          View entryEntitiesView = new View(view.document, concept.codesFirstLetterLower);
          entryEntitiesView.entities = entryEntities;
          entryEntitiesView.title = concept.codes;
          EntitiesTable entryEntitiesTable = new EntitiesTable(entryEntitiesView);
          buttonElement.on.click.add((MouseEvent e) {
            if (buttonElement.text.startsWith('Show')) {
              entryEntitiesTable.show();
              buttonElement.text = 'Hide ${concept.codes}';
            } else {
              entryEntitiesTable.hide();
              buttonElement.text = 'Show ${concept.codes}';
            }
          });
        }
      }
    }
  }

}

class RepoEntitiesSection {

  View view;

  RepoEntitiesSection(this.view) {
    var domains = view.repo.domains;
    String section = '';
    for (Domain domain in domains) {
      for (Model model in domain.models) {
        for (Concept entryConcept in model.entryConcepts) {
          section =
              '${section}<section id="${entryConcept.codesFirstLetterLower}">'
              '</section>  \n';
          List<String> childCodeInternalPathList =
              entryConcept.childCodeInternalPaths;
          for (String childCodeInternalPath in childCodeInternalPathList) {
            section = '${section}<section id="${childCodeInternalPath}">'
                      '</section>  \n';
          }
        }
      }
    }
    view.document.query('#${view.did}').innerHTML = section;
  }

}




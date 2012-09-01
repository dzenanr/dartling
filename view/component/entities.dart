
class EntitiesSimpleTable {

  View view;

  bool hidden = true;

  EntitiesSimpleTable(this.view);

  bool get shown => !hidden;

  void show() {
    if (hidden) {
      String section = '<br/> ';
      section = '${section}<table>';
      section = '${section}  <caption>';
      String title;
      if (view.title == null) {
        title = view.did.toUpperCase();
      } else {
        title = view.title;
      }
      section = '${section}    ${title}';
      section = '${section}  </caption>';
      List<Attribute> attributes;
      if (view.essentialOnly) {
        attributes = view.entities.concept.essentialAttributes;
      } else {
        attributes = view.entities.concept.attributes.list;
      }
      String label;
      var value;
      section = '${section}  <tr>';
      for (Attribute attribute in attributes) {
        label = attribute.codeFirstLetterUpper;
        section = '${section}    <th>';
        section = '${section}      ${label}';
        section = '${section}    </th>';
      }
      section = '${section}  </tr>';
      for (var entity in view.entities) {
        section = '${section}  <tr>';
        for (Attribute attribute in attributes) {
          value = entity.getAttribute(attribute.code);
          section = '${section}    <td>';
          section = '${section}      ${value}';
          section = '${section}    </td>';
        }
        section = '${section}  </tr>';
      }
      section = '${section}</table>';
      section = '$section <br/> ';

      /*
       * Each web page loaded in the browser has its own document object.
       * This object serves as an entry point to the web page's content
       * (the DOM tree, including elements such as <body> and <table> ) and
       * provides functionality global to the document (such as obtaining the
       * page's URL and creating new elements in the document).
       */
      view.document.query('#${view.did}').innerHTML = section;
      hidden = false;
    }
  }

  void hide() {
    if (shown) {
      view.document.query('#${view.did}').innerHTML = '';
      hidden = true;
    }
  }

}

class EntitiesTable {

  View view;

  bool hidden = true;

  EntitiesTable(this.view);

  bool get shown => !hidden;

  void show() {
    if (hidden) {
      String section = '<br/> ';
      section = '${section}<table>';
      section = '${section}  <caption>';
      String title;
      if (view.title == null) {
        title = view.did.toUpperCase();
      } else {
        title = view.title;
      }
      section = '${section}    ${title}';
      section = '${section}  </caption>';
      List<Attribute> attributes;
      if (view.essentialOnly) {
        attributes = view.entities.concept.essentialAttributes;
      } else {
        attributes = view.entities.concept.attributes.list;
      }
      Parents parents = view.entities.concept.parents;
      Children children = view.entities.concept.children;
      String label;
      var value;
      section = '${section}  <tr>';
      for (Attribute attribute in attributes) {
        label = attribute.codeFirstLetterUpper;
        section = '${section}    <th>';
        section = '${section}      ${label}';
        section = '${section}    </th>';
      }
      for (Parent parent in parents) {
        label = parent.codeFirstLetterUpper;
        section = '${section}    <th>';
        section = '${section}      ${label}';
        section = '${section}    </th>';
      }
      for (Child child in children) {
        label = child.codeFirstLetterUpper;
        section = '${section}    <th>';
        section = '${section}      ${label}';
        section = '${section}    </th>';
      }

      section = '${section}  </tr>';

      for (var entity in view.entities) {
        section = '${section}  <tr>';
        for (Attribute attribute in attributes) {
          value = entity.getAttribute(attribute.code);
          section = '${section}    <td>';
          section = '${section}      ${value}';
          section = '${section}    </td>';
        }
        for (Parent parent in parents) {
          section = '${section}    <td>';
          var parentEntity = entity.getParent(parent.code);
          if (parentEntity != null) {
            if (parentEntity.concept.identifier) {
              section = '${section}      ${parentEntity.id}';
            } else {
              section = '${section}      ${parentEntity.oid}';
            }
          }
          section = '${section}    </td>';
        }
        for (Child child in children) {
          section = '${section}    <td id="${child.code}Of${entity.oid}">';
          section = '${section}    </td>';
        }
        section = '${section}  </tr>';
      }
      section = '${section}</table>';
      section = '$section <br/> ';

      /*
       * Each web page loaded in the browser has its own document object.
       * This object serves as an entry point to the web page's content
       * (the DOM tree, including elements such as <body> and <table> ) and
       * provides functionality global to the document (such as obtaining the
       * page's URL and creating new elements in the document).
       */
      view.document.query('#${view.did}').innerHTML = section;

      for (var entity in view.entities) {
        for (Child child in children) {
          Element tdElement = document.query('#${child.code}Of${entity.oid}');
          assert(tdElement != null);
          ButtonElement childButton = new ButtonElement();
          childButton.text = 'Show';

          View childView = new View(document, '${child.code}Child');
          childView.entities = entity.getChild(child.code);
          if (!childView.entities.empty) {
            if (entity.concept.identifier) {
              childView.title = '${entity.id}.${child.code}';
            } else {
              childView.title = '${entity}.${child.code}';
            }
            EntitiesTable childTable = new EntitiesTable(childView);

            childButton.on.click.add((MouseEvent e) {
              if (childTable.hidden) {
                childTable.show();
                childButton.text = 'Hide';
              } else {
                childTable.hide();
                childButton.text = 'Show';
              }
            });

            tdElement.elements.clear();
            tdElement.elements.add(childButton);
          }
        }
      }
      //print(view.document.query('#${view.did}').innerHTML);
      hidden = false;
    }
  }

  void hide() {
    if (shown) {
      view.document.query('#${view.did}').innerHTML = '';
      hidden = true;
    }
  }

}




class EntityTable {

  View view;

  bool hidden = true;

  EntityTable(this.view);

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
        attributes = view.entity.concept.essentialAttributes;
      } else {
        attributes = view.entity.concept.attributes.list;
      }
      String label;
      var value;
      for (Attribute attribute in attributes) {
        label = attribute.codeFirstLetterUpper;
        value = view.entity.getAttribute(attribute.code);
        section = '${section}  <tr>';
        section = '${section}    <th>';
        section = '${section}      ${label}';
        section = '${section}    </th>';
        section = '${section}    <td>';
        section = '${section}      ${value}';
        section = '${section}    </td>';
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

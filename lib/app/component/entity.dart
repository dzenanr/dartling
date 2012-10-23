part of dartling_app;

class EntityTable {

  View view;

  bool hidden = true;

  EntityTable(this.view);

  bool get shown => !hidden;

  void show() {
    if (hidden) {
      String section = '<br/> \n';
      section = '${section}<table> \n';
      section = '${section}  <caption> \n';
      String title;
      if (view.title == null) {
        title = view.did.toUpperCase();
      } else {
        title = view.title;
      }
      section = '${section}    ${title} \n';
      section = '${section}  </caption> \n';
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
        section = '${section}  <tr> \n';
        section = '${section}    <th> \n';
        section = '${section}      ${label} \n';
        section = '${section}    </th> \n';
        section = '${section}    <td> \n';
        section = '${section}      ${value} \n';
        section = '${section}    </td> \n';
        section = '${section}  </tr> \n';
      }
      section = '${section}</table> \n';
      section = '$section <br/> \n';

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

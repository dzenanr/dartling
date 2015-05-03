part of entities_table_wc;

class EntitiesTable {
  Entities entities;
  List<Attribute> essentialAttributes;
  
  TableElement table = querySelector('#entities-table');
  
  var context;

  EntitiesTable(this.context, this.entities) {
    essentialAttributes = entities.concept.essentialAttributes;
    var incrementAttributes = entities.concept.incrementAttributes;
    var idIncrementAttribute = false;
    for (var attribute in incrementAttributes) {
      if (attribute.identifier) {
        idIncrementAttribute = true;
        break;
      }
    }
    if (idIncrementAttribute) {
      display(sort:false);
    } else {
      display();
    }
    addEventHandlers();
  }
  
  void addEventHandlers() {
    var identifierAttributes = entities.concept.identifierAttributes;
    for (var attribute in identifierAttributes) {
      TableRowElement hRow = table.nodes[1];
      for (TableCellElement thElement in hRow.nodes) {
        if (thElement.text == attribute.code) {
          thElement.onClick.listen((Event e) {
            entities.sort((e1, e2) {
              var v1 = e1.getAttribute(attribute.code);
              var v2 = e2.getAttribute(attribute.code);
              return v1.compareTo(v2);
            });
            display(sort: false);
          });
        }
      }
    } 
  }
  
  void display({sort: true}) {
    removeRows();
    addCaption();
    addHeaderRow();
    if (sort) {
      entities.sort();
    }
    for (var entity in entities) {
      addDataRow(entity);
    }  
  }
  
  void removeRows() {
    table.nodes.clear();
  }
  
  void addCaption() {
    var tableCaption = new TableCaptionElement();
    tableCaption.text = entities.concept.labels;
    table.nodes.add(tableCaption);
  }
  
  void addHeaderRow() {
    TableRowElement hRow = new Element.tr();
    for (Attribute attribute in essentialAttributes) {
      TableCellElement thElement = new Element.th();
      thElement.text = attribute.label;
      hRow.nodes.add(thElement);
    }
    table.nodes.add(hRow);
  }
  
  void addDataRow(ConceptEntity entity) {
    TableRowElement dRow = new Element.tr();
    
    for (Attribute attribute in essentialAttributes) {
      TableCellElement tdElement = new Element.td();
      var value = entity.getAttribute(attribute.code);
      if (value != null) {
        tdElement.text = entity.getAttribute(attribute.code).toString();
      }
      dRow.nodes.add(tdElement);
    }
     
    dRow.id = entity.oid.toString();
    dRow.onClick.listen(selectEntity);
    table.nodes.add(dRow);
  }
  
  void selectEntity(Event e) {
    var dRow = (e.target as TableCellElement).parent;
    var idn = int.parse(dRow.id);
    var entity = entities.singleWhereOid(new Oid.ts(idn));
    context.entityTable.setEntity(entity);
  }
  
  void save() {
    context.save();
  }
}




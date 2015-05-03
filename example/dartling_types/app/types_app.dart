part of dartling_types_app;

class TypesApp {
  TypesEntries model;
  
  TypesApp(DartlingModels domain) {
    model = domain.getModelEntries("Types"); 
    _load(model);
    new EntitiesTableWc(this, model.types);
  }
  
  void _load(TypesEntries model) {
    String json = window.localStorage['dartling_types_data'];
    if (json != null && model.isEmpty) {
      model.fromJson(json);
    }
  }
  
  void save() {
    window.localStorage['dartling_types_data'] = model.toJson();
  }
}

class EntitiesTableWc {
  var app;
 
  EntitiesTable entitiesTable;
  EntityTable entityTable;
  
  EntitiesTableWc(this.app, var entities) {
    entitiesTable = new EntitiesTable(this, entities);
    entityTable = new EntityTable(entitiesTable, entities);  
  }
  
  void save() {
    app.save();
  }
}




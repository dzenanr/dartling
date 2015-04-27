part of dartling_types; 
 
// lib/gen/dartling/models.dart 
 
class DartlingModels extends DomainModels { 
 
  DartlingModels(Domain domain) : super(domain) { 
    // fromJsonToModel function from dartling/lib/domain/model/transfer.json.dart 
 
    Model model = fromJsonToModel(dartlingTypesModelJson, domain, "Types"); 
    TypesModel typesModel = new TypesModel(model); 
    add(typesModel); 
 
  } 
 
} 
 

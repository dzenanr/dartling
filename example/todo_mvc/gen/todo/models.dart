part of todo_mvc; 
 
// lib/gen/todo/models.dart 
 
class TodoModels extends DomainModels { 
 
  TodoModels(Domain domain) : super(domain) { 
    // fromJsonToModel function from dartling/lib/domain/model/transfer.json.dart 
 
    Model model = fromJsonToModel(todoMvcModelJson, domain, "Mvc"); 
    MvcModel mvcModel = new MvcModel(model); 
    add(mvcModel); 
 
  } 
 
} 
 

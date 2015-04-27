part of todo_mvc; 
 
// lib/gen/todo/mvc/entries.dart 
 
class MvcEntries extends ModelEntries { 
 
  MvcEntries(Model model) : super(model); 
 
  Map<String, Entities> newEntries() { 
    var entries = new Map<String, Entities>(); 
    var concept; 
    concept = model.concepts.singleWhereCode("Task"); 
    entries["Task"] = new Tasks(concept); 
    return entries; 
  } 
 
  Entities newEntities(String conceptCode) { 
    var concept = model.concepts.singleWhereCode(conceptCode); 
    if (concept == null) { 
      throw new ConceptError("${conceptCode} concept does not exist.") ; 
    } 
    if (concept.code == "Task") { 
      return new Tasks(concept); 
    } 
    return null; 
  } 
 
  ConceptEntity newEntity(String conceptCode) { 
    var concept = model.concepts.singleWhereCode(conceptCode); 
    if (concept == null) { 
      throw new ConceptError("${conceptCode} concept does not exist.") ; 
    } 
    if (concept.code == "Task") { 
      return new Task(concept); 
    } 
    return null; 
  } 
 
  Tasks get tasks => getEntry("Task"); 
 
} 
 

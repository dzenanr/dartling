 
part of default_project; 
 
// lib/default/project/model.dart 
 
class ProjectModel extends ProjectEntries { 
 
  ProjectModel(Model model) : super(model); 
 
  fromJsonToProjectEntry() { 
    fromJsonToEntry(defaultProjectProjectEntry); 
  } 
 
  fromJsonToModel() { 
    fromJson(defaultProjectModel); 
  } 
 
  init() { 
    initProjects(); 
  } 
 
  initProjects() { 
    var project1 = new Project(projects.concept); 
    project1.name = "letter"; 
    project1.description = "discount"; 
    projects.add(project1); 
 
    var project2 = new Project(projects.concept); 
    project2.name = "tall"; 
    project2.description = "celebration"; 
    projects.add(project2); 
 
    var project3 = new Project(projects.concept); 
    project3.name = "big"; 
    project3.description = "measuremewnt"; 
    projects.add(project3); 
 
  } 
 
  // added after code gen - begin 
 
  // added after code gen - end 
 
} 
 

import "package:test/test.dart"; 
import "package:dartling/dartling.dart"; 
import 'default_project.dart';
 
testDefaultProjectProjects( 
    DefaultDomain defaultDomain, ProjectModel projectModel, Projects projects) { 
  DomainSession session; 
  group("Testing Default.Project.Project", () { 
    session = defaultDomain.newSession();  
    setUp(() { 
      projectModel.init(); 
    }); 
    tearDown(() { 
      projectModel.clear(); 
    }); 
 
    test("Not empty model", () { 
      expect(projectModel.isEmpty, isFalse); 
      expect(projects.isEmpty, isFalse); 
    }); 
 
    test("Empty model", () { 
      projectModel.clear(); 
      expect(projectModel.isEmpty, isTrue); 
      expect(projects.isEmpty, isTrue); 
      expect(projects.errors.isEmpty, isTrue); 
    }); 
 
    test("From model to JSON", () { 
      var json = projectModel.toJson(); 
      expect(json, isNotNull); 
 
      print(json); 
      //projectModel.displayJson(); 
      //projectModel.display(); 
    }); 
 
    test("From JSON to model", () { 
      var json = projectModel.toJson(); 
      projectModel.clear(); 
      expect(projectModel.isEmpty, isTrue); 
      projectModel.fromJson(json); 
      expect(projectModel.isEmpty, isFalse); 
 
      projectModel.display(); 
    }); 
 
    test("From model entry to JSON", () { 
      var json = projectModel.fromEntryToJson("Project"); 
      expect(json, isNotNull); 
 
      print(json); 
      //projectModel.displayEntryJson("Project"); 
      //projectModel.displayJson(); 
      //projectModel.display(); 
    }); 
 
    test("From JSON to model entry", () { 
      var json = projectModel.fromEntryToJson("Project"); 
      projects.clear(); 
      expect(projects.isEmpty, isTrue); 
      projectModel.fromJsonToEntry(json); 
      expect(projects.isEmpty, isFalse); 
 
      projects.display(title: "From JSON to model entry"); 
    }); 
 
    test("Add project required error", () { 
      // no required attribute that is not id 
    }); 
 
    test("Add project unique error", () { 
      var projectConcept = projects.concept; 
      var projectCount = projects.length; 
      var project = new Project(projectConcept); 
      var randomProject = projects.random(); 
      project.name = randomProject.name; 
      var added = projects.add(project); 
      expect(added, isFalse); 
      expect(projects.length, equals(projectCount)); 
      expect(projects.errors.length, greaterThan(0)); 
 
      projects.errors.display(title: "Add project unique error"); 
    }); 
 
    test("Not found project by new oid", () { 
      var dartlingOid = new Oid.ts(1345648254063); 
      var project = projects.singleWhereOid(dartlingOid); 
      expect(project, isNull); 
    }); 
 
    test("Find project by oid", () { 
      var randomProject = projects.random(); 
      var project = projects.singleWhereOid(randomProject.oid); 
      expect(project, isNotNull); 
      expect(project, equals(randomProject)); 
    }); 
 
    test("Find project by attribute id", () { 
      var randomProject = projects.random(); 
      var project = 
          projects.singleWhereAttributeId("name", randomProject.name); 
      expect(project, isNotNull); 
      expect(project.name, equals(randomProject.name)); 
    }); 
 
    test("Find project by required attribute", () { 
      // no required attribute that is not id 
    }); 
 
    test("Find project by attribute", () { 
      var randomProject = projects.random(); 
      var project = 
          projects.firstWhereAttribute("description", randomProject.description); 
      expect(project, isNotNull); 
      expect(project.description, equals(randomProject.description)); 
    }); 
 
    test("Select projects by attribute", () { 
      var randomProject = projects.random(); 
      var selectedProjects = 
          projects.selectWhereAttribute("description", randomProject.description); 
      expect(selectedProjects.isEmpty, isFalse); 
      selectedProjects.forEach((se) => 
          expect(se.description, equals(randomProject.description))); 
 
      //selectedProjects.display(title: "Select projects by description"); 
    }); 
 
    test("Select projects by required attribute", () { 
      // no required attribute that is not id 
    }); 
 
    test("Select projects by attribute, then add", () { 
      var randomProject = projects.random(); 
      var selectedProjects = 
          projects.selectWhereAttribute("description", randomProject.description); 
      expect(selectedProjects.isEmpty, isFalse); 
      expect(selectedProjects.source.isEmpty, isFalse); 
      var projectsCount = projects.length; 
 
      var project = new Project(projects.concept); 
        project.name = 'lunch'; 
        project.description = 'discount'; 
      var added = selectedProjects.add(project); 
      expect(added, isTrue); 
      expect(projects.length, equals(++projectsCount)); 
 
      //selectedProjects.display(title: 
      //  "Select projects by attribute, then add"); 
      //projects.display(title: "All projects"); 
    }); 
 
    test("Select projects by attribute, then remove", () { 
      var randomProject = projects.random(); 
      var selectedProjects = 
          projects.selectWhereAttribute("description", randomProject.description); 
      expect(selectedProjects.isEmpty, isFalse); 
      expect(selectedProjects.source.isEmpty, isFalse); 
      var projectsCount = projects.length; 
 
      var removed = selectedProjects.remove(randomProject); 
      expect(removed, isTrue); 
      expect(projects.length, equals(--projectsCount)); 
 
      randomProject.display(prefix: "removed"); 
      //selectedProjects.display(title: 
      //  "Select projects by attribute, then remove"); 
      //projects.display(title: "All projects"); 
    }); 
 
    test("Sort projects", () { 
      projects.sort(); 
 
      //projects.display(title: "Sort projects"); 
    }); 
 
    test("Order projects", () { 
      var orderedProjects = projects.order(); 
      expect(orderedProjects.isEmpty, isFalse); 
      expect(orderedProjects.length, equals(projects.length)); 
      expect(orderedProjects.source.isEmpty, isFalse); 
      expect(orderedProjects.source.length, equals(projects.length)); 
      expect(orderedProjects, isNot(same(projects))); 
 
      //orderedProjects.display(title: "Order projects"); 
    }); 
 
    test("Copy projects", () { 
      var copiedProjects = projects.copy(); 
      expect(copiedProjects.isEmpty, isFalse); 
      expect(copiedProjects.length, equals(projects.length)); 
      expect(copiedProjects, isNot(same(projects))); 
      copiedProjects.forEach((e) => 
        expect(e, equals(projects.singleWhereOid(e.oid)))); 
      copiedProjects.forEach((e) => 
        expect(e, isNot(same(projects.singleWhereId(e.id))))); 
 
      //copiedProjects.display(title: "Copy projects"); 
    }); 
 
    test("True for every project", () { 
      // no required attribute that is not id 
    }); 
 
    test("Random project", () { 
      var project1 = projects.random(); 
      expect(project1, isNotNull); 
      var project2 = projects.random(); 
      expect(project2, isNotNull); 
 
      //project1.display(prefix: "random1"); 
      //project2.display(prefix: "random2"); 
    }); 
 
    test("Update project id with try", () { 
      var randomProject = projects.random(); 
      var beforeUpdate = randomProject.name; 
      try { 
        randomProject.name = 'deep'; 
      } on UpdateError catch (e) { 
        expect(randomProject.name, equals(beforeUpdate)); 
      } 
    }); 
 
    test("Update project id without try", () { 
      var randomProject = projects.random(); 
      var beforeUpdateValue = randomProject.name; 
      expect(() => randomProject.name = 'agile', throws); 
      expect(randomProject.name, equals(beforeUpdateValue)); 
    }); 
 
    test("Update project id with success", () { 
      var randomProject = projects.random(); 
      var afterUpdateEntity = randomProject.copy(); 
      var attribute = randomProject.concept.attributes.singleWhereCode("name"); 
      expect(attribute.update, isFalse); 
      attribute.update = true; 
      afterUpdateEntity.name = 'winter'; 
      expect(afterUpdateEntity.name, equals('winter')); 
      attribute.update = false; 
      var updated = projects.update(randomProject, afterUpdateEntity); 
      expect(updated, isTrue); 
 
      var entity = projects.singleWhereAttributeId("name", 'winter'); 
      expect(entity, isNotNull); 
      expect(entity.name, equals('winter')); 
 
      //projects.display("After update project id"); 
    }); 
 
    test("Update project non id attribute with failure", () { 
      var randomProject = projects.random(); 
      var afterUpdateEntity = randomProject.copy(); 
      afterUpdateEntity.description = 'concern'; 
      expect(afterUpdateEntity.description, equals('concern')); 
      // projects.update can only be used if oid, code or id is set. 
      expect(() => projects.update(randomProject, afterUpdateEntity), throws); 
    }); 
 
    test("Copy Equality", () { 
      var randomProject = projects.random(); 
      randomProject.display(prefix:"before copy: "); 
      var randomProjectCopy = randomProject.copy(); 
      randomProjectCopy.display(prefix:"after copy: "); 
      expect(randomProject, equals(randomProjectCopy)); 
      expect(randomProject.oid, equals(randomProjectCopy.oid)); 
      expect(randomProject.code, equals(randomProjectCopy.code)); 
      expect(randomProject.name, equals(randomProjectCopy.name)); 
      expect(randomProject.description, equals(randomProjectCopy.description)); 
 
      expect(randomProject.id, isNotNull); 
      expect(randomProjectCopy.id, isNotNull); 
      expect(randomProject.id, equals(randomProjectCopy.id)); 
 
      var idsEqual = false; 
      if (randomProject.id == randomProjectCopy.id) { 
        idsEqual = true; 
      } 
      expect(idsEqual, isTrue); 
 
      idsEqual = false; 
      if (randomProject.id.equals(randomProjectCopy.id)) { 
        idsEqual = true; 
      } 
      expect(idsEqual, isTrue); 
    }); 
 
    test("New project action undo and redo", () { 
      var projectCount = projects.length; 
      var project = new Project(projects.concept); 
      project.name = 'teaching'; 
    project.description = 'universe'; 
      projects.add(project); 
      expect(projects.length, equals(++projectCount)); 
      projects.remove(project); 
      expect(projects.length, equals(--projectCount)); 
 
      var action = new AddAction(session, projects, project); 
      action.doit(); 
      expect(projects.length, equals(++projectCount)); 
 
      action.undo(); 
      expect(projects.length, equals(--projectCount)); 
 
      action.redo(); 
      expect(projects.length, equals(++projectCount)); 
    }); 
 
    test("New project session undo and redo", () { 
      var projectCount = projects.length; 
      var project = new Project(projects.concept); 
      project.name = 'sun'; 
    project.description = 'universe'; 
      projects.add(project); 
      expect(projects.length, equals(++projectCount)); 
      projects.remove(project); 
      expect(projects.length, equals(--projectCount)); 
 
      var action = new AddAction(session, projects, project); 
      action.doit(); 
      expect(projects.length, equals(++projectCount)); 
 
      session.past.undo(); 
      expect(projects.length, equals(--projectCount)); 
 
      session.past.redo(); 
      expect(projects.length, equals(++projectCount)); 
    }); 
 
    test("Project update undo and redo", () { 
      var project = projects.random(); 
      var action = new SetAttributeAction(session, project, "description", 'cloud'); 
      action.doit(); 
 
      session.past.undo(); 
      expect(project.description, equals(action.before)); 
 
      session.past.redo(); 
      expect(project.description, equals(action.after)); 
    }); 
 
    test("Project action with multiple undos and redos", () { 
      var projectCount = projects.length; 
      var project1 = projects.random(); 
 
      var action1 = new RemoveAction(session, projects, project1); 
      action1.doit(); 
      expect(projects.length, equals(--projectCount)); 
 
      var project2 = projects.random(); 
 
      var action2 = new RemoveAction(session, projects, project2); 
      action2.doit(); 
      expect(projects.length, equals(--projectCount)); 
 
      //session.past.display(); 
 
      session.past.undo(); 
      expect(projects.length, equals(++projectCount)); 
 
      session.past.undo(); 
      expect(projects.length, equals(++projectCount)); 
 
      //session.past.display(); 
 
      session.past.redo(); 
      expect(projects.length, equals(--projectCount)); 
 
      session.past.redo(); 
      expect(projects.length, equals(--projectCount)); 
 
      //session.past.display(); 
    }); 
 
    test("Transaction undo and redo", () { 
      var projectCount = projects.length; 
      var project1 = projects.random(); 
      var project2 = projects.random(); 
      while (project1 == project2) { 
        project2 = projects.random();  
      } 
      var action1 = new RemoveAction(session, projects, project1); 
      var action2 = new RemoveAction(session, projects, project2); 
 
      var transaction = new Transaction("two removes on projects", session); 
      transaction.add(action1); 
      transaction.add(action2); 
      transaction.doit(); 
      projectCount = projectCount - 2; 
      expect(projects.length, equals(projectCount)); 
 
      projects.display(title:"Transaction Done"); 
 
      session.past.undo(); 
      projectCount = projectCount + 2; 
      expect(projects.length, equals(projectCount)); 
 
      projects.display(title:"Transaction Undone"); 
 
      session.past.redo(); 
      projectCount = projectCount - 2; 
      expect(projects.length, equals(projectCount)); 
 
      projects.display(title:"Transaction Redone"); 
    }); 
 
    test("Transaction with one action error", () { 
      var projectCount = projects.length; 
      var project1 = projects.random(); 
      var project2 = project1; 
      var action1 = new RemoveAction(session, projects, project1); 
      var action2 = new RemoveAction(session, projects, project2); 
 
      var transaction = new Transaction( 
        "two removes on projects, with an error on the second", session); 
      transaction.add(action1); 
      transaction.add(action2); 
      var done = transaction.doit(); 
      expect(done, isFalse); 
      expect(projects.length, equals(projectCount)); 
 
      //projects.display(title:"Transaction with an error"); 
    }); 
 
    test("Reactions to project actions", () { 
      var projectCount = projects.length; 
 
      var reaction = new ProjectReaction(); 
      expect(reaction, isNotNull); 
 
      defaultDomain.startActionReaction(reaction); 
      var project = new Project(projects.concept); 
      project.name = 'lake'; 
    project.description = 'blue'; 
      projects.add(project); 
      expect(projects.length, equals(++projectCount)); 
      projects.remove(project); 
      expect(projects.length, equals(--projectCount)); 
 
      var session = defaultDomain.newSession(); 
      var addAction = new AddAction(session, projects, project); 
      addAction.doit(); 
      expect(projects.length, equals(++projectCount)); 
      expect(reaction.reactedOnAdd, isTrue); 
 
      var setAttributeAction = new SetAttributeAction( 
        session, project, "description", 'home'); 
      setAttributeAction.doit(); 
      expect(reaction.reactedOnUpdate, isTrue); 
      defaultDomain.cancelActionReaction(reaction); 
    }); 
 
  }); 
} 
 
class ProjectReaction implements ActionReactionApi { 
  bool reactedOnAdd    = false; 
  bool reactedOnUpdate = false; 
 
  react(BasicAction action) { 
    if (action is EntitiesAction) { 
      reactedOnAdd = true; 
    } else if (action is EntityAction) { 
      reactedOnUpdate = true; 
    } 
  } 
} 
 
void main() { 
  var repository = new Repository(); 
  var defaultDomain = repository.getDomainModels("Default");   
  assert(defaultDomain != null); 
  var projectModel = defaultDomain.getModelEntries("Project");  
  assert(projectModel != null); 
  var projects = projectModel.projects; 
  testDefaultProjectProjects(defaultDomain, projectModel, projects); 
} 
 

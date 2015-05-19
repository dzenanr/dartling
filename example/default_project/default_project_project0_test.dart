import "package:test/test.dart"; 
import 'default_project.dart';

void testDefaultProjectProject( 
    Repository repository, String domainCode, String modelCode) { 
  var domain; 
  var model; 
  var projects; 
  group("Testing Default.Project.Project", () { 
    domain = repository.getDomainModels(domainCode); 
    model = domain.getModelEntries(modelCode);  
    projects = model.projects; 
    setUp(() { 
      model.init(); 
    }); 
    tearDown(() { 
      model.clear(); 
    }); 
 
    test("Not empty model", () { 
      expect(model.isEmpty, isFalse); 
      expect(projects.isEmpty, isFalse); 
    }); 
 
    test("Empty model", () { 
      model.clear(); 
      expect(model.isEmpty, isTrue); 
      expect(projects.isEmpty, isTrue); 
    }); 
 
    test("From model entry to JSON", () { 
      var json = model.fromEntryToJson("Project"); 
      expect(json, isNotNull); 
 
      print(json); 
      //model.displayEntryJson("Project"); 
      //model.displayJson(); 
      //model.display(); 
    }); 
 
    test("From JSON to model entry", () { 
      var json = model.fromEntryToJson("Project"); 
      projects.clear(); 
      expect(projects.isEmpty, isTrue); 
      model.fromJsonToEntry(json); 
      expect(projects.isEmpty, isFalse); 
 
      projects.display(title: "From JSON to model entry"); 
    }); 
 
    test("Add project required error", () { 
      // no required attribute that is not an id 
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
      expect(projects.exceptions.length, greaterThan(0)); 
 
      projects.exceptions.display(title: "Add project unique error"); 
    }); 
 
      // Find project by required attribute: 
      // no required attribute that is not an id 
 
      // Select projects by required attribute: 
      // no required attribute that is not an id 
 
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
      // no required attribute that is not an id 
    }); 
 
    test("Random project", () { 
      var project1 = projects.random(); 
      expect(project1, isNotNull); 
      var project2 = projects.random(); 
      expect(project2, isNotNull); 
 
      //project1.display(prefix: "random1"); 
      //project2.display(prefix: "random2"); 
    }); 
 
  }); 
} 
 
void main() { 
  testDefaultProjectProject(new Repository(), "Default", "Project"); 
} 
 

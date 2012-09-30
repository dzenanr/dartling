
#import("package:dartling/dartling.dart");
#import("package:unittest/unittest.dart");

//#import("package:default_project/default_project.dart");

#source("../../../lib/default/project/json/data.dart");
#source("../../../lib/default/project/json/model.dart");
#source("../../../lib/default/project/init.dart");
#source("../../../lib/default/project/projects.dart");
#source("../../../lib/gen/default/project/entries.dart");
#source("../../../lib/gen/default/project/projects.dart");
#source("../../../lib/gen/default/models.dart");
#source("../../../lib/gen/default/repository.dart");

testDefaultProject(Repo repo, String domainCode, String modelCode) {
  var models;
  var entries;
  group("Testing ${domainCode}.${modelCode}", () {
    setUp(() {
      models = repo.getDomainModels(domainCode);
      entries = models.getModelEntries(modelCode);
      expect(entries, isNotNull);

      var projectCount = 0;
      var projects = entries.projects;
      expect(projects.count, equals(projectCount));

      var projectConcept = projects.concept;
      expect(projectConcept, isNotNull);
      expect(projectConcept.attributes.list, isNot(isEmpty));

      var design = new Project(projectConcept);
      expect(design, isNotNull);
      design.name = 'Dartling Design';
      design.description =
          'Creating a model of Dartling concepts based on MagicBoxes.';
      projects.add(design);
      expect(projects.count, equals(++projectCount));

      var prototype = new Project(projectConcept);
      expect(prototype, isNotNull);
      prototype.name = 'Dartling Prototype';
      prototype.description =
          'Programming the meta model and the generic model.';
      projects.add(prototype);
      expect(projects.count, equals(++projectCount));

      var production = new Project(projectConcept);
      expect(production, isNotNull);
      production.name = 'Dartling';
      production.description =
          'Programming Dartling.';
      projects.add(production);
      expect(projects.count, equals(++projectCount));
    });
    tearDown(() {
      entries.clear();
      var projects = entries.projects;
      expect(projects.empty, isTrue);
    });
    test("Empty Entries Test", () {
      entries.clear();
      expect(entries.empty, isTrue);
    });
    test('From Project Model to JSON', () {
      var json = entries.toJson();
      expect(json, isNotNull);
      entries.displayJson();
    });
    test('From JSON to Project Model', () {
      var projects = entries.projects;
      projects.clear();
      expect(projects.empty, isTrue);
      entries.fromJsonToData();
      expect(projects.empty, isFalse);
      projects.display('From JSON to Project Model');
    });
    test('Add Project Required Error', () {
      var projects = entries.projects;
      var projectConcept = projects.concept;
      var projectCount = projects.count;
      var project = new Project(projectConcept);
      expect(project, isNotNull);
      var added = projects.add(project);
      expect(added, isFalse);
      expect(projects.count, equals(projectCount));
      expect(projects.errors.count, equals(1));
      expect(projects.errors.list[0].category, equals('required'));
      projects.errors.display('Add Project Required Error');
    });
    test('Add Project Unique Error', () {
      var projects = entries.projects;
      var projectConcept = projects.concept;
      var projectCount = projects.count;
      var project = new Project(projectConcept);
      expect(project, isNotNull);
      project.name = 'Dartling';
      var added = projects.add(project);
      expect(added, isFalse);
      expect(projects.count, equals(projectCount));
      expect(projects.errors.count, equals(1));
      expect(projects.errors.list[0].category, equals('unique'));
      projects.errors.display('Add Project Unique Error');
    });
    test('Add Project Pre Validation', () {
      var projects = entries.projects;
      var projectConcept = projects.concept;
      var projectCount = projects.count;
      var project = new Project(projectConcept);
      expect(project, isNotNull);
      project.name =
          'A new project with a long name that cannot be accepted';
      var added = projects.add(project);
      expect(added, isFalse);
      expect(projects.count, equals(projectCount));
      expect(projects.errors, hasLength(1));
      expect(projects.errors.list[0].category, equals('pre'));
      projects.errors.display('Add Project Pre Validation');
    });
    test('Find Project by New Oid', () {
      var dartlingOid = new Oid.ts(1345648254063);
      var projects = entries.projects;
      var project = projects.find(dartlingOid);
      expect(project, isNull);
    });
    test('Find Project by Saved Oid', () {
      var projects = entries.projects;
      projects.clear();
      expect(projects.empty, isTrue);
      entries.fromJsonToData();
      expect(projects.empty, isFalse);

      var dartlingOid = new Oid.ts(1344888717723);
      var project = projects.find(dartlingOid);
      expect(project, isNotNull);
      expect(project.name == 'Dartling');
    });
    test('Find Project by Id', () {
      var projects = entries.projects;
      var projectConcept = projects.concept;
      Id id = new Id(projectConcept);
      expect(id.count, equals(1));
      var searchName = 'Dartling';
      id.setAttribute('name', searchName);
      var project = projects.findById(id);
      expect(project, isNotNull);
      expect(project.name, equals(searchName));
    });
    test('Find Project by Attribute Id', () {
      var projects = entries.projects;
      var searchName = 'Dartling';
      var project = projects.findByAttributeId('name', searchName);
      expect(project, isNotNull);
      expect(project.name, equals(searchName));
    });
    test('Find Project by Name Id', () {
      var projects = entries.projects;
      var searchName = 'Dartling';
      var project = projects.findByNameId(searchName);
      expect(project, isNotNull);
      expect(project.name, equals(searchName));
    });
    test('Select Projects by Function', () {
      var projects = entries.projects;
      var programmingProjects = projects.select((p) => p.onProgramming);
      expect(programmingProjects.empty, isFalse);
      expect(programmingProjects.length, equals(2));

      programmingProjects.display('Select Projects by Function');
    });
    test('Select Projects by Function then Add', () {
      var projects = entries.projects;
      var programmingProjects = projects.select((p) => p.onProgramming);
      expect(programmingProjects.empty, isFalse);
      expect(programmingProjects.source.empty, isFalse);

      var projectConcept = projects.concept;
      var programmingProject = new Project(projectConcept);
      programmingProject.name = 'Dartling Testing';
      programmingProject.description = 'Programming unit tests.';
      var added = programmingProjects.add(programmingProject);
      expect(added, isTrue);

      programmingProjects.display('Select Projects by Function then Add');
      projects.display('All Projects');
    });
    test('Select Projects by Function then Remove', () {
      var projects = entries.projects;
      var projectCount = projects.count;
      //projects.display('Projects Before Remove');
      var programmingProjects = projects.select((p) => p.onProgramming);
      expect(programmingProjects.empty, isFalse);
      expect(programmingProjects.source.empty, isFalse);

      var searchName = 'Dartling';
      var project = programmingProjects.findByNameId(searchName);
      expect(project, isNotNull);
      expect(project.name, equals(searchName));
      var programmingProjectCount = programmingProjects.count;
      programmingProjects.remove(project);
      expect(programmingProjects.count, equals(--programmingProjectCount));
      expect(projects.count, equals(--projectCount));
    });
    test('Order Projects by Name', () {
      var projects = entries.projects;
      Projects orderedProjects =
          projects.orderByFunction((m,n) => m.nameCompareTo(n));
      expect(orderedProjects.empty, isFalse);
      expect(orderedProjects.count, equals(projects.count));
      expect(orderedProjects.source.empty, isFalse);
      expect(orderedProjects.source.count, equals(projects.count));

      orderedProjects.display('Order Projects by Name');
    });
    test('New Project with Id', () {
      var projects = entries.projects;
      var projectCount = projects.count;
      var projectConcept = projects.concept;
      var marketing = new Project.withId(projectConcept, 'Dartling Marketing');
      expect(marketing, isNotNull);
      marketing.description = 'Making Dartling known to the Dart community.';
      var added = projects.add(marketing);
      expect(added, isTrue);
      expect(projects.count, equals(++projectCount));
      projects.display('New Project with Id');
    });
    test('Copy Projects', () {
      var projects = entries.projects;
      Projects copiedProjects = projects.copy();
      expect(copiedProjects.empty, isFalse);
      expect(copiedProjects.count, equals(projects.count));
      expect(copiedProjects, isNot(same(projects)));
      expect(copiedProjects != projects);
      //expect(copiedProjects, isNot(equals(projects))); // does not pass
      copiedProjects.forEach((cp) =>
          expect(cp, isNot(same(projects.findById(cp.id)))));
      copiedProjects.display('Copied Projects');
    });
    test('True for Every Project', () {
      var projects = entries.projects;
      expect(projects.every((p) => p.code == null), isTrue);
      expect(projects.every((p) => p.name != null), isTrue);
    });
    test('Update New Project Id with Try', () {
      var projects = entries.projects;
      var projectCount = projects.count;
      var projectConcept = projects.concept;
      var marketing = new Project.withId(projectConcept, 'Dartling Marketing');
      expect(marketing, isNotNull);
      marketing.description = 'Making Dartling known to the Dart community.';
      projects.add(marketing);
      expect(projects.count, equals(++projectCount));

      var beforeNameUpdate = marketing.name;
      try {
        marketing.name = 'Marketing Dartling';
      } on UpdateException catch (e) {
        expect(marketing.name, equals(beforeNameUpdate));
      }
    });
    test('Update New Project Id without Try', () {
      var projects = entries.projects;
      var projectCount = projects.count;
      var projectConcept = projects.concept;
      var marketing = new Project.withId(projectConcept, 'Dartling Marketing');
      expect(marketing, isNotNull);
      marketing.description = 'Making Dartling known to the Dart community.';
      projects.add(marketing);
      expect(projects.count, equals(++projectCount));

      var beforeNameUpdate = marketing.name;
      expect(() => marketing.name = 'Marketing Dartling', throws);
      expect(marketing.name, equals(beforeNameUpdate));
    });
    test('Update New Project Id with Success', () {
      var projects = entries.projects;
      var projectCount = projects.count;
      var projectConcept = projects.concept;
      var marketing = new Project.withId(projectConcept, 'Dartling Marketing');
      expect(marketing, isNotNull);
      marketing.description = 'Making Dartling known to the Dart community.';
      projects.add(marketing);
      expect(projects.count, equals(++projectCount));
      //projects.display('Before Update New Project Id with Success');

      var afterUpdateMarketing = marketing.copy();
      var nameAttribute = marketing.concept.attributes.findByCode('name');
      expect(nameAttribute.update, isFalse);
      nameAttribute.update = true;
      var newName = 'Marketing Dartling';
      afterUpdateMarketing.name = newName;
      expect(afterUpdateMarketing.name, equals(newName));
      nameAttribute.update = false;
      var updated = projects.update(marketing, afterUpdateMarketing);
      expect(updated, isTrue);
      //projects.display('After Update New Project Id with Success');

      var marketingDartling = projects.findByAttributeId('name', newName);
      expect(marketingDartling, isNotNull);
      expect(marketingDartling.name, equals(newName));
    });
    test('Update New Project Description with Failure', () {
      var projects = entries.projects;
      var projectCount = projects.count;
      var projectConcept = projects.concept;
      var marketing = new Project.withId(projectConcept, 'Dartling Marketing');
      expect(marketing, isNotNull);
      marketing.description = 'Making Dartling known to the Dart community.';
      projects.add(marketing);
      expect(projects.count, equals(++projectCount));

      var beforeDescriptionUpdate = marketing.description;
      var afterUpdateMarketing = marketing.copy();
      var newDescription = 'Writing papers about Dartling';
      afterUpdateMarketing.description = newDescription;
      expect(afterUpdateMarketing.description, equals(newDescription));
      // Projects.update can only be used if oid, code or id set.
      expect(() => projects.update(marketing, afterUpdateMarketing), throws);
    });
    test('Copy Equality', () {
      var projects = entries.projects;
      var projectCount = projects.count;
      var projectConcept = projects.concept;
      var marketing = new Project.withId(projectConcept, 'Dartling Marketing');
      expect(marketing, isNotNull);
      marketing.description = 'Making Dartling known to the Dart community.';
      projects.add(marketing);
      expect(projects.count, equals(++projectCount));

      marketing.display('before copy: ');
      var afterUpdateMarketing = marketing.copy();
      afterUpdateMarketing.display('after copy: ');
      expect(marketing == afterUpdateMarketing);
      expect(marketing.equals(afterUpdateMarketing));
      expect(marketing.oid == afterUpdateMarketing.oid);
      expect(marketing.oid, equals(afterUpdateMarketing.oid));
      expect(marketing.code == afterUpdateMarketing.code);
      expect(marketing.code, equals(afterUpdateMarketing.code));
      expect(marketing.name, equals(afterUpdateMarketing.name));
      expect(marketing.description, equals(afterUpdateMarketing.description));

      expect(marketing.id, isNotNull);
      expect(afterUpdateMarketing.id, isNotNull);
      expect(marketing.id == afterUpdateMarketing.id);
      expect(marketing.id, equals(afterUpdateMarketing.id));
      /*
       * ==
       *
       * If x===y, return true.
       * Otherwise, if either x or y is null, return false.
       * Otherwise, return the result of x.equals(y).
       */
      var idsEqual = false;
      if (marketing.id == afterUpdateMarketing.id) {
        idsEqual = true;
      }
      expect(idsEqual, isTrue);

      idsEqual = false;
      if (marketing.id.equals(afterUpdateMarketing.id)) {
        idsEqual = true;
      }
      expect(idsEqual, isTrue);
    });
    test('New Project Undo and Redo', () {
      var projects = entries.projects;
      var projectCount = projects.count;
      var projectConcept = projects.concept;
      var marketing = new Project.withId(projectConcept, 'Dartling Marketing');
      expect(marketing, isNotNull);
      marketing.description = 'Making Dartling known to the Dart community.';

      var session = models.newSession();
      var action = new AddAction(session, projects, marketing);
      action.doit();
      expect(projects.count, equals(++projectCount));

      action.undo();
      expect(projects.count, equals(--projectCount));

      action.redo();
      expect(projects.count, equals(++projectCount));
    });
    test('New Project Undo and Redo with Session', () {
      var projects = entries.projects;
      var projectCount = projects.count;
      var projectConcept = projects.concept;
      var marketing = new Project.withId(projectConcept, 'Dartling Marketing');
      expect(marketing, isNotNull);
      marketing.description = 'Making Dartling known to the Dart community.';

      var session = models.newSession();
      var action = new AddAction(session, projects, marketing);
      action.doit();
      expect(projects.count, equals(++projectCount));

      session.past.undo();
      expect(projects.count, equals(--projectCount));

      session.past.redo();
      expect(projects.count, equals(++projectCount));
    });
    test('Undo and Redo Update Project', () {
      var projects = entries.projects;
      var searchName = 'Dartling';
      var project = projects.findByAttributeId('name', searchName);
      expect(project, isNotNull);
      expect(project.name, equals(searchName));

      var session = models.newSession();
      var action =
          new SetAttributeAction(session, project, 'description',
              'Domain Model Framework.');
      action.doit();

      session.past.undo();
      expect(project.description, equals(action.before));

      session.past.redo();
      expect(project.description, equals(action.after));
    });
    test('Project Action with Multiple Undos and Redos ', () {
      var projects = entries.projects;
      var projectCount = projects.count;
      var projectConcept = projects.concept;

      var project1 = new Project(projectConcept);
      project1.name = 'Data modeling';

      var session = models.newSession();
      var action1 = new AddAction(session, projects, project1);
      action1.doit();
      expect(projects.count, equals(++projectCount));

      var project2 = new Project(projectConcept);
      project2.name = 'Database design';

      var action2 = new AddAction(session, projects, project2);
      action2.doit();
      expect(projects.count, equals(++projectCount));

      session.past.display();

      session.past.undo();
      expect(projects.count, equals(--projectCount));
      session.past.display();

      session.past.undo();
      expect(projects.count, equals(--projectCount));
      session.past.display();

      session.past.redo();
      expect(projects.count, equals(++projectCount));
      session.past.display();

      session.past.redo();
      expect(projects.count, equals(++projectCount));
      session.past.display();
    });
    test('Undo and Redo Transaction', () {
      var projects = entries.projects;
      var projectCount = projects.count;
      var projectConcept = projects.concept;
      var session = models.newSession();

      var project1 = new Project(projectConcept);
      project1.name = 'Data modeling';
      var action1 = new AddAction(session, projects, project1);

      var project2 = new Project(projectConcept);
      project2.name = 'Database design';
      var action2 = new AddAction(session, projects, project2);

      var transaction = new Transaction('two adds on projects', session);
      transaction.add(action1);
      transaction.add(action2);
      transaction.doit();
      projectCount = projectCount + 2;
      expect(projects.count, equals(projectCount));
      projects.display('Transaction Done');

      session.past.undo();
      projectCount = projectCount - 2;
      expect(projects.count, equals(projectCount));
      projects.display('Transaction Undone');

      session.past.redo();
      projectCount = projectCount + 2;
      expect(projects.count, equals(projectCount));
      projects.display('Transaction Redone');
    });
    test('Undo and Redo Transaction with Id Error', () {
      var projects = entries.projects;
      var projectCount = projects.count;
      var projectConcept = projects.concept;
      var session = models.newSession();

      var project1 = new Project(projectConcept);
      project1.name = 'Data modeling';
      var action1 = new AddAction(session, projects, project1);

      var project2 = new Project(projectConcept);
      //project2.name = 'Database design';
      var action2 = new AddAction(session, projects, project2);

      var transaction = new Transaction(
        'two adds on projects, with an error on the second', session);
      transaction.add(action1);
      transaction.add(action2);
      var done = transaction.doit();
      expect(done, isFalse);
      expect(projects.count, equals(projectCount));
      projects.display('Transaction (with Id Error) Done');
    });
    test('Reactions to Project Actions', () {
      var projects = entries.projects;
      var projectCount = projects.count;
      var projectConcept = projects.concept;

      var reaction = new ProjectReaction();
      expect(reaction, isNotNull);

      models.startActionReaction(reaction);
      var project = new Project(projectConcept);
      project.name = 'Dartling Documentation';

      var session = models.newSession();
      var addAction = new AddAction(session, projects, project);
      addAction.doit();
      expect(projects.count, equals(++projectCount));
      expect(reaction.reactedOnAdd, isTrue);

      var description = 'Documenting Dartling.';
      var setAttributeAction =
          new SetAttributeAction(session, project, 'description', description);
      setAttributeAction.doit();
      expect(reaction.reactedOnUpdate, isTrue);
      models.cancelActionReaction(reaction);
    });
    test('Random Entity', () {
      var projects = entries.projects;
      var project1 = projects.random();
      expect(project1, isNotNull);
      project1.display('1');
      var project2 = projects.random();
      expect(project2, isNotNull);
      project2.display('2');
    });

  });
}

class ProjectReaction implements ActionReactionApi {

  bool reactedOnAdd = false;
  bool reactedOnUpdate = false;

  react(BasicAction action) {
    if (action is EntitiesAction) {
      reactedOnAdd = true;
    } else if (action is EntityAction) {
      reactedOnUpdate = true;
    }
  }

}

testDefaultData(DefaultRepo defaultRepo) {
  testDefaultProject(defaultRepo, DefaultRepo.defaultDomainCode,
      DefaultRepo.defaultProjectModelCode);
}

void main() {
  var defaultRepo = new DefaultRepo();
  testDefaultData(defaultRepo);
}


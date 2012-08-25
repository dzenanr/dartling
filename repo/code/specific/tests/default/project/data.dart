
class ProjectActionReaction implements ActionReactionApi {

  bool reactedOnAdd = false;
  bool reactedOnUpdate = false;

  var models;
  var session;
  var projects;

  ProjectActionReaction(this.models, this.projects) {
    session = models.newSession();
  }

  addProject(String projectName) {
    var project = new Project(projects.concept);
    project.name = projectName;

    models.startActionReaction(this);
    var action = new AddAction(session, projects, project);
    action.doit();
    models.cancelActionReaction(this);

    assert(projects.findByAttribute('name', projectName) != null);
  }

  updateProjectDescription(String projectName, String projectDescription) {
    var project = projects.findByAttribute('name', projectName);

    models.startActionReaction(this);
    var action = new SetAttributeAction(
        session, project, 'description', projectDescription);
    action.doit();
    models.cancelActionReaction(this);
  }

  react(Action action) {
    if (action is EntitiesAction) {
      Projects ps = action.entities;
      if (ps.errors.count > 0) {
        ps.errors.display();
      } else {
        ps.display('Projects with Reaction');
        reactedOnAdd = true;
      }
    } else if (action is EntityAction) {
      Project p = action.entity;
      print('Dartling Project with After Update Description');
      print('');
      p.display();
      reactedOnUpdate = true;
    }
    print('!!! Action Reaction for ${projects.concept.codeInPlural} !!!');
    print('');
    print('$action');
    print('');
  }

}

class ProjectPastReaction implements PastReactionApi {

  var models;

  ProjectPastReaction(this.models) {
    models.newSession().past.startPastReaction(this);
  }

  reactNoPast() {
    print('There are no past actions in the ${models.domain.code} domain.');
    print('');
  }

  reactYesPast() {
    print('There is at least one past action in the ${models.domain.code} domain.');
    print('');
  }

}

testDefaultProjectData(Repo repo, String domainCode, String modelCode) {
  var models;
  var projects;
  var projectConcept;
  var projectCount = 0;
  var dartlingOid;
  group('Testing ${domainCode}.${modelCode}', () {
    setUp(() {
      models = repo.getDomainModels(domainCode);
      expect(models, isNotNull);
      var entries = models.getModelEntries(modelCode);
      expect(entries, isNotNull);

      projects = entries.projects;
      expect(projects.count, equals(projectCount));

      projectConcept = projects.concept;
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
      dartlingOid = production.oid;
    });
    tearDown(() {
      projects.clear();
      expect(projects.count, equals(0));
      projectCount = 0;
    });
    test('Select Projects by Function', () {
      var programmingProjects = projects.select((p) => p.onProgramming);
      expect(programmingProjects.list, isNot(isEmpty));
      expect(programmingProjects.length, equals(2));

      programmingProjects.display('Programming Entities');
    });
    test('Select Projects by Function then Add', () {
      Projects programmingProjects = projects.select((p) => p.onProgramming);
      expect(programmingProjects.list, isNot(isEmpty));
      expect(programmingProjects.count, equals(2));
      expect(programmingProjects.source.list, isNot(isEmpty));
      expect(programmingProjects.source.count, equals(projectCount));

      var programmingProject = new Project(projectConcept);
      programmingProject.name = 'Dartling Testing';
      programmingProject.description = 'Programming unit tests.';
      programmingProjects.add(programmingProject);
      expect(programmingProjects.count, equals(3));
      expect(projects.count, equals(++projectCount));

      programmingProjects.display('Programming Entities After Add');
      projects.display('All Projects');
    });
    test('Find Project by Oid', () {
      var project = projects.find(dartlingOid);
      expect(project, isNotNull);
      expect(project.name == 'Dartling');
    });
    test('Find Project by Id', () {
      Id id = new Id(projectConcept);
      expect(id.count, equals(1));
      expect(id.parentCount, equals(0));
      expect(id.attributeCount, equals(1));
      var searchName = 'Dartling';
      id.setAttribute('name', searchName);
      //var project = projects.findById(id);
      Project project = projects.findById(id);
      expect(project, isNotNull);
      expect(project.name, equals(searchName));
    });
    test('Find Project by Attribute Id', () {
      var searchName = 'Dartling';
      Project project = projects.findByAttributeId('name', searchName);
      expect(project, isNotNull);
      expect(project.name, equals(searchName));
    });
    test('Find Project by Name Id', () {
      var searchName = 'Dartling';
      Project project = projects.findByNameId(searchName);
      expect(project, isNotNull);
      expect(project.name, equals(searchName));
    });
    test('Order Projects by Name', () {
      Projects orderedProjects =
          projects.orderByFunction((m,n) => m.compareName(n));
      expect(orderedProjects.list, isNot(isEmpty));
      expect(orderedProjects.count, equals(projectCount));
      expect(orderedProjects.source.list, isNot(isEmpty));
      expect(orderedProjects.source.count, equals(projectCount));

      orderedProjects.display('Ordered Projects');
    });
    test('New Project with Id', () {
      var marketing = new Project.withId(projectConcept, 'Dartling Marketing');
      expect(marketing, isNotNull);
      marketing.description = 'Making Dartling known to the Dart community.';
      projects.add(marketing);
      expect(projects.count, equals(++projectCount));

      projects.display('Projects Including Marketing');
    });
    test('Copy Projects', () {
      Projects copiedProjects = projects.copy();
      expect(copiedProjects.list, isNot(isEmpty));
      expect(copiedProjects.count, equals(projectCount));
      expect(copiedProjects, isNot(same(projects)));
      expect(copiedProjects != projects);
      //expect(copiedProjects, isNot(equals(projects))); // does not pass

      copiedProjects.forEach((cp) =>
          expect(cp, isNot(same(projects.findById(cp.id)))));

      copiedProjects.display('Copied Projects');
    });
    test('True for Every Project', () {
      expect(projects.every((p) => p.code == null), isTrue);
      expect(projects.every((p) => p.name != null), isTrue);
    });
    test('Reaction to New Project', () {
      var reaction = new ProjectActionReaction(models, projects);
      expect(reaction, isNotNull);
      reaction.addProject('Dartling Documentation');
      expect(projects, hasLength(++projectCount));
      expect(reaction.reactedOnAdd, isTrue);
    });
    test('Reaction to Project Update', () {
      var reaction = new ProjectActionReaction(models, projects);
      expect(reaction, isNotNull);
      reaction.updateProjectDescription('Dartling', 'Developing Dartling.');
      expect(projects, hasLength(projectCount));
      expect(reaction.reactedOnUpdate, isTrue);
    });
    test('Project Action with Undo and Redo ', () {
      var session = models.newSession();

      var project1 = new Project(projectConcept);
      project1.name = 'Data modeling';

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
    test('From Project Model to JSON', () {
      var entries = models.getModelEntries(modelCode);
      expect(entries, isNotNull);
      var json = entries.toJson();
      expect(json, isNotNull);
      entries.displayJson(json, 'Project Model in JSON');
    });
    test('From JSON to Project Model', () {
      var entries = models.getModelEntries(modelCode);
      expect(entries, isNotNull);
      expect(projects.list, isNot(isEmpty));
      projects.clear();
      expect(projects.list, isEmpty);
      entries.fromJsonToData();

      expect(projects.list, isNot(isEmpty));
      projects.display('From JSON to Project Model');
    });
    test('Update New Project Id with Try', () {
      var marketing = new Project.withId(projectConcept, 'Dartling Marketing');
      expect(marketing, isNotNull);
      marketing.description = 'Making Dartling known to the Dart community.';
      projects.add(marketing);
      expect(projects.count, equals(++projectCount));

      var beforeNameUpdate = marketing.name;
      try {
        marketing.name = 'Marketing Dartling';
      } catch (final UpdateException e) {
        expect(marketing.name, equals(beforeNameUpdate));
      }
    });
    test('Update New Project Id without Try', () {
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
    test('Copy Equality', () {
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
    test('Update New Project Description with Failure', () {
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
      expect(() => projects.update(marketing, afterUpdateMarketing), throws);
    });

  });
}

class ProjectActionReaction implements ActionReaction {

  String name;
  bool reactedOnAdd = false;
  bool reactedOnUpdate = false;

  var projects;

  ProjectActionReaction(this.name, this.projects);

  addProject(String projectName) {
    var project = new Project(projects.concept);
    project.name = projectName;

    projects.startReaction(this);
    projects.add(project);
    projects.cancelReaction(this);

    projects.lastAction.undo();
    projects.lastAction.undo();

    assert(projects.getEntityByAttribute('name', projectName) != null);
  }

  updateProjectDescription(String projectName, String projectDescription) {
    var project = projects.getEntityByAttribute('name', projectName);
    assert(project != null);

    project.startReaction(this);
    project.description = projectDescription;
    project.cancelReaction(this);
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
    print('!!! Action Reaction for ${projects.concept.pluralName} by $name !!!');
    print('');
    print('$action');
    print('');
  }

}

class ProjectPastReaction implements PastReaction {

  Projects projects;

  ProjectPastReaction(this.projects) {
    projects.past.startReaction(this);
  }

  reactNoPast() {
    print('!!! No Past Reaction for ${projects.concept.pluralName} !!!');
    print('');
    print('There are no past actions.');
    print('');
  }

  reactYesPast() {
    print('!!! Yes Past Reaction for ${projects.concept.pluralName} !!!');
    print('');
    print('There is at least one past action.');
    print('');
  }

}

testProjectData() {
  var data;
  var projectCount;
  var dartlingOid;
  group('Testing Project', () {
    setUp(() {
      data = new ProjectData();

      var projectConcept = data.projectConcept;
      expect(projectConcept, isNotNull);
      expect(projectConcept.attributes, isNot(isEmpty));
      expect(projectConcept.attributes.count == 2);

      projectCount = 0;

      var projects = data.projects;
      expect(projects, isNotNull);
      expect(projects.count == projectCount);

      var design = new Project(projectConcept);
      expect(design, isNotNull);
      design.name = 'Dartling Design';
      design.description =
          'Creating a model of Dartling concepts based on MagicBoxes.';
      projects.add(design);
      expect(projects.count == ++projectCount);

      var prototype = new Project(projectConcept);
      expect(prototype, isNotNull);
      prototype.name = 'Dartling Prototype';
      prototype.description =
          'Programming the meta model and the generic model.';
      projects.add(prototype);
      expect(projects.count == ++projectCount);

      var production = new Project(projectConcept);
      expect(production, isNotNull);
      production.name = 'Dartling';
      production.description =
          'Programming Dartling.';
      projects.add(production);
      expect(projects.count == ++projectCount);
      dartlingOid = production.oid;
    });
    tearDown(() {
      var projects = data.projects;
      projects.clear();
      expect(projects.count == 0);
    });
    test('Select Projects by Function', () {
      var projects = data.projects;
      expect(projects.count == projectCount);

      var programmingProjects = projects.select((p) => p.onProgramming);
      expect(programmingProjects, isNotNull);
      expect(programmingProjects, isNot(isEmpty));
      expect(programmingProjects.length == 2);

      programmingProjects.display('Programming Entities');
    });
    test('Select Projects by Function then Add', () {
      var projects = data.projects;
      expect(projects.count == projectCount);

      Projects programmingProjects = projects.select((p) => p.onProgramming);
      expect(programmingProjects, isNotNull);
      expect(programmingProjects, isNot(isEmpty));
      expect(programmingProjects.count == 2);
      expect(programmingProjects.sourceEntities, isNotNull);
      expect(programmingProjects.sourceEntities, isNot(isEmpty));
      expect(programmingProjects.sourceEntities.count == projectCount);

      var programmingProject = new Project(data.projectConcept);
      programmingProject.name = 'Dartling Testing';
      programmingProject.description = 'Programming unit tests.';
      programmingProjects.add(programmingProject);
      expect(programmingProjects.count == 3);
      expect(projects.count == ++projectCount);

      programmingProjects.display('Programming Entities After Add');
      projects.display('All Projects');
    });
    test('Get Project by Oid', () {
      var projects = data.projects;
      expect(projects.count == projectCount);

      var project = projects.getEntity(dartlingOid);
      expect(project, isNotNull);
      expect(project.name == 'Dartling');
    });
    test('Get Project by Id', () {
      var projects = data.projects;
      expect(projects.count == projectCount);

      Id id = new Id(data.projectConcept);
      expect(id.count == 1);
      expect(id.parentCount == 0);
      expect(id.attributeCount == 1);
      var searchName = 'Dartling';
      id.setAttribute('name', searchName);
      var project = projects.getEntityById(id);
      //Project project = projects.getEntityById(id);
      expect(project, isNotNull);
      expect(project.name == searchName);
    });
    test('Order Projects by Name', () {
      var projects = data.projects;
      expect(projects.count == projectCount);

      Projects orderedProjects =
          projects.orderByFunction((m,n) => m.compareName(n));
      expect(orderedProjects, isNotNull);
      expect(orderedProjects, isNot(isEmpty));
      expect(orderedProjects.count == projectCount);
      expect(orderedProjects.sourceEntities, isNotNull);
      expect(orderedProjects.sourceEntities, isNot(isEmpty));
      expect(orderedProjects.sourceEntities.count == projectCount);

      orderedProjects.display('Ordered Projects');
    });
    test('New Project with Id', () {
      var projects = data.projects;
      expect(projects.count == projectCount);

      var projectConcept = data.projectConcept;
      expect(projectConcept, isNotNull);
      expect(projectConcept.attributes, isNot(isEmpty));
      expect(projectConcept.attributes.count == 2);

      var marketing = new Project.withId(projectConcept, 'Dartling Marketing');
      expect(marketing, isNotNull);
      marketing.description = 'Making Dartling known to the Dart community.';
      projects.add(marketing);
      expect(projects.count == ++projectCount);

      projects.display('Projects Including Marketing');
    });
    test('Copy Projects', () {
      var projects = data.projects;
      expect(projects.count == projectCount);

      Projects copiedProjects = projects.copy();
      expect(copiedProjects, isNotNull);
      expect(copiedProjects, isNot(isEmpty));
      expect(copiedProjects.count == projectCount);
      expect(copiedProjects, isNot(same(projects)));
      expect(copiedProjects, isNot(equals(projects)));

      copiedProjects.forEach((cp) =>
          expect(cp, isNot(same(projects.getEntityById(cp.id)))));

      copiedProjects.display('Copied Projects');
    });
    test('True for Every Project', () {
      var projects = data.projects;
      expect(projects.count == projectCount);

      expect(projects.every((p) => p.code == null), isTrue);
      expect(projects.every((p) => p.name != null), isTrue);
    });
    test('Reaction to New Project', () {
      var projects = data.projects;
      expect(projects, hasLength(projectCount));

      var reaction = new ProjectActionReaction('Test Project', projects);
      expect(reaction, isNotNull);
      reaction.addProject('Dartling Documentation');
      expect(projects, hasLength(++projectCount));
      expect(reaction.reactedOnAdd, isTrue);
    });

    test('Reaction to Project Update', () {
      var projects = data.projects;
      expect(projects, hasLength(projectCount));

      var reaction = new ProjectActionReaction('Test Project', projects);
      expect(reaction, isNotNull);
      reaction.updateProjectDescription('Dartling', 'Developing Dartling.');
      expect(projects, hasLength(projectCount));
      expect(reaction.reactedOnUpdate, isTrue);
    });
    test('Project Action with Undo and Redo ', () {
      var projects = data.projects;
      expect(projects, hasLength(projectCount));
      var projectConcept = projects.concept;

      new ProjectPastReaction(projects);

      var product1 = new Project(projectConcept);
      product1.name = 'Oracle';

      var action1 = new EntitiesAction('add');
      action1.entities = projects;
      action1.entity = product1;
      action1.doit();
      expect(projects.count, equals(++projectCount));

      var product2 = new Project(projectConcept);
      product2.name = 'MySql';

      var action2 = new EntitiesAction('add');
      action2.entities = projects;
      action2.entity = product2;
      action2.doit();
      expect(projects.count, equals(++projectCount));
      /*
      action2.undo();
      expect(projects.count, equals(--projectCount));

      action1.undo();
      expect(projects.count, equals(--projectCount));
      */
      projects.past.display();

      projects.past.undo();
      expect(projects.count, equals(--projectCount));
      projects.past.display();

      projects.past.undo();
      expect(projects.count, equals(--projectCount));
      projects.past.display();

      projects.past.redo();
      expect(projects.count, equals(++projectCount));
      projects.past.display();

      projects.past.redo();
      expect(projects.count, equals(++projectCount));
      projects.past.display();
    });

  });
}



ProjectEntry fromJsonToProjectEntry() {
  /**
   *  || Project
   *  id name
   *  at description
   */
  var _json = '''
      {"width":990,"lines":[],"height":580,"boxes":[{"entry":true,
      "name":"Project","x":179,"y":226,"width":120,"height":120,
      "items":[{"sequence":10,"category":"identifier","name":"name",
      "type":"String","init":""},{"sequence":20,"category":"attribute",
      "name":"description","type":"String","init":""}]}]}
  ''';
  return new ProjectEntry(fromMagicBoxes(_json));
}

class ProjectActionReaction implements ActionReaction {

  bool reactedOnAdd = false;
  bool reactedOnUpdate = false;

  var entry;
  var session;
  var projects;

  ProjectActionReaction(this.entry, this.projects) {
    session = entry.newSession();
  }

  addProject(String projectName) {
    var project = new Project(projects.concept);
    project.name = projectName;

    entry.startActionReaction(this);
    var action = new AddAction(session, projects, project);
    action.doit();
    entry.cancelActionReaction(this);

    assert(projects.findByAttribute('name', projectName) != null);
  }

  updateProjectDescription(String projectName, String projectDescription) {
    var project = projects.findByAttribute('name', projectName);
    assert(project != null);

    entry.startActionReaction(this);
    var action = new
        SetAttributeAction(session, project, 'description', projectDescription);
    action.doit();
    entry.cancelActionReaction(this);
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
    print('!!! Action Reaction for ${projects.concept.pluralName} !!!');
    print('');
    print('$action');
    print('');
  }

}

class ProjectPastReaction implements PastReaction {

  var entry;

  ProjectPastReaction(this.entry) {
    entry.newSession().past.startPastReaction(this);
  }

  reactNoPast() {
    print('There are no past actions in the ${entry.domain.code} domain.');
    print('');
  }

  reactYesPast() {
    print('There is at least one past action in the ${entry.domain.code} domain.');
    print('');
  }

}

testProjectData() {
  var entry;
  var session;
  var data;
  var projects;
  var projectConcept;
  var projectCount;
  var dartlingOid;
  group('Testing Project', () {
    setUp(() {
      entry = fromJsonToProjectEntry();
      data = entry.data;
      session = entry.newSession();

      projectConcept = data.projectConcept;
      expect(projectConcept, isNotNull);
      expect(projectConcept.attributes, isNot(isEmpty));
      expect(projectConcept.attributes.count, equals(2));

      projectCount = 0;

      projects = data.projects;
      expect(projects, isNotNull);
      expect(projects.count, equals(projectCount));

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
    });
    test('Select Projects by Function', () {
      var programmingProjects = projects.select((p) => p.onProgramming);
      expect(programmingProjects, isNotNull);
      expect(programmingProjects, isNot(isEmpty));
      expect(programmingProjects.length, equals(2));

      programmingProjects.display('Programming Entities');
    });
    test('Select Projects by Function then Add', () {
      Projects programmingProjects = projects.select((p) => p.onProgramming);
      expect(programmingProjects, isNotNull);
      expect(programmingProjects, isNot(isEmpty));
      expect(programmingProjects.count, equals(2));
      expect(programmingProjects.source, isNotNull);
      expect(programmingProjects.source, isNot(isEmpty));
      expect(programmingProjects.source.count, equals(projectCount));

      var programmingProject = new Project(data.projectConcept);
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
      Id id = new Id(data.projectConcept);
      expect(id.count == 1);
      expect(id.parentCount == 0);
      expect(id.attributeCount == 1);
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
      expect(orderedProjects, isNotNull);
      expect(orderedProjects, isNot(isEmpty));
      expect(orderedProjects.count, equals(projectCount));
      expect(orderedProjects.source, isNotNull);
      expect(orderedProjects.source, isNot(isEmpty));
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
      expect(copiedProjects, isNotNull);
      expect(copiedProjects, isNot(isEmpty));
      expect(copiedProjects.count, equals(projectCount));
      expect(copiedProjects, isNot(same(projects)));
      expect(copiedProjects, isNot(equals(projects)));

      copiedProjects.forEach((cp) =>
          expect(cp, isNot(same(projects.findById(cp.id)))));

      copiedProjects.display('Copied Projects');
    });
    test('True for Every Project', () {
      expect(projects.every((p) => p.code == null), isTrue);
      expect(projects.every((p) => p.name != null), isTrue);
    });
    test('Reaction to New Project', () {
      var reaction = new ProjectActionReaction(entry, projects);
      expect(reaction, isNotNull);
      reaction.addProject('Dartling Documentation');
      expect(projects, hasLength(++projectCount));
      expect(reaction.reactedOnAdd, isTrue);
    });
    test('Reaction to Project Update', () {
      var reaction = new ProjectActionReaction(entry, projects);
      expect(reaction, isNotNull);
      reaction.updateProjectDescription('Dartling', 'Developing Dartling.');
      expect(projects, hasLength(projectCount));
      expect(reaction.reactedOnUpdate, isTrue);
    });
    test('Project Action with Undo and Redo ', () {
      new ProjectPastReaction(entry);

      var product1 = new Project(projectConcept);
      product1.name = 'Oracle';

      var action1 = new AddAction(session, projects, product1);
      action1.doit();
      expect(projects.count, equals(++projectCount));

      var product2 = new Project(projectConcept);
      product2.name = 'MySql';

      var action2 = new AddAction(session, projects, product2);
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

  });
}
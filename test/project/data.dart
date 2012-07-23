
var data;

testProjectData() {
  group('Testing', () {
    setUp(() {
      data = new ProjectData();

      var projectConcept = data.projectConcept;
      expect(projectConcept, isNotNull);
      expect(projectConcept.attributes, isNot(isEmpty));
      expect(projectConcept.attributes.count == 2);

      var projects = data.projects;
      expect(projects, isNotNull);
      expect(projects.count == 0);

      var design = new Project(projectConcept);
      expect(design, isNotNull);
      design.name = 'Dartling Design';
      design.description =
          'Creating a model of Dartling concepts based on MagicBoxes.';
      projects.add(design);
      expect(projects.count == 1);

      var prototype = new Project(projectConcept);
      expect(prototype, isNotNull);
      prototype.name = 'Dartling Prototype';
      prototype.description =
          'Programming the meta model and the generic model.';
      projects.add(prototype);
      expect(projects.count == 2);

      var production = new Project(projectConcept);
      expect(production, isNotNull);
      production.name = 'Dartling';
      production.description =
          'Programming Dartling.';
      projects.add(production);
      expect(projects.count == 3);
    });
    tearDown(() {
      var projects = data.projects;
      projects.empty();
      expect(projects.count == 0);
    });
    test('Project Filtering 1', () {
      var projects = data.projects;
      expect(projects.count == 3);

      var programmingProjects = projects.filter((p) => p.isOnProgramming());
      expect(programmingProjects, isNotNull);
      expect(programmingProjects, isNot(isEmpty));
      expect(programmingProjects.length == 2);

      //programmingProjects.display('Programming Entities');
    });
    test('Project Filtering 2', () {
      var projects = data.projects;
      expect(projects.count == 3);

      List<Project> programmingProjectList =
          projects.filter((p) => p.isOnProgramming());
      expect(programmingProjectList, isNotNull);
      expect(programmingProjectList, isNot(isEmpty));
      expect(programmingProjectList.length == 2);

      //programmingProjects.display('Programming Entities');
    });
    test('Project Filtering 3', () {
      var projects = data.projects;
      expect(projects.count == 3);

      List<Project> programmingProjectList =
          projects.filter((p) => p.isOnProgramming());
      expect(programmingProjectList, isNotNull);
      expect(programmingProjectList, isNot(isEmpty));
      expect(programmingProjectList.length == 2);

      Projects programmingProjects = new Projects(data.projectConcept);
      programmingProjects.addFrom(programmingProjectList);
      programmingProjects.sourceEntities = projects;
      expect(programmingProjects, isNotNull);
      expect(programmingProjects, isNot(isEmpty));
      expect(programmingProjects.count == 2);
      expect(programmingProjects.sourceEntities, isNotNull);
      expect(programmingProjects.sourceEntities, isNot(isEmpty));
      expect(programmingProjects.sourceEntities.count == 3);

      programmingProjects.display('Programming Entities Before Add');

      var programmingProject = new Project(data.projectConcept);
      programmingProject.name = 'Dartling Testing';
      programmingProject.description =
          'Programming unit tests.';
      programmingProjects.add(programmingProject);
      expect(programmingProjects.count == 3);
      expect(projects.count == 4);

      programmingProjects.display('Programming Entities After Add');
      projects.display('All Projects');
    });
    test('Get Project By Id', () {
      var projects = data.projects;
      expect(projects.count == 3);

      Id id = new Id(data.projectConcept);
      expect(id.count == 1);
      expect(id.parentCount == 0);
      expect(id.attributeCount == 1);
      var searchName = 'Dartling';
      id.setAttribute('name', searchName);
      var project = projects.getEntityById(id);
      expect(project, isNotNull);
      expect(project.name == searchName);
    });
  });
}


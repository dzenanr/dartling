
testProjectData() {
  test('Project Data Creation', () {
    var data = new ProjectData();

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

    projects.display('Project Data Creation');
  });
}
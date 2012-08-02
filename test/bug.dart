
testBug() {
  test('Bug Name', () {
    var data = new UserData();

    var memberConcept = data.memberConcept;
    expect(memberConcept, isNotNull);
    expect(memberConcept.attributes, isNot(isEmpty));
    expect(memberConcept.attributes.count == 9);
    memberConcept.attributes.getEntityByCode('password').sensitive = true;

    var memberCount = 0;

    var members = data.members;
    expect(members, isNotNull);
    expect(members.count == memberCount);

    var tim = new Member(memberConcept);
    expect(tim, isNotNull);
    tim.code = 'atimurr';
    tim.password = 'timmy8527';
    tim.firstName = 'Timur';
    tim.lastName = 'Ridjanovic';
    tim.email = 'timur.ridjanovic@gmail.com';
    members.add(tim);
    expect(members.count == ++memberCount);
    members.display('After Add');
    members.history.display();

    var undo = members.history.undo();
    expect(members.count == --memberCount);
    members.display('After Undo');
    print('undo: $undo');
    members.history.display();

    var redo = members.history.redo();
    //expect(members.count == ++memberCount);
    members.display('After Redo');
    print('redo: $redo');
    members.history.display();
  });
}

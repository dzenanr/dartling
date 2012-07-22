
testUserData() {
  test('User Data Creation', () {
    var data = new UserData();

    var memberConcept = data.memberConcept;
    expect(memberConcept, isNotNull);
    expect(memberConcept.attributes, isNot(isEmpty));
    expect(memberConcept.attributes.count == 3);

    var members = data.members;
    expect(members, isNotNull);
    expect(members.count == 0);

    var tim = new Member(memberConcept);
    expect(tim, isNotNull);
    tim.firstName = 'Timur';
    tim.lastName = 'Ridjanovic';
    //tim.code = '${tim.lastName}, ${tim.firstName}';
    tim.email = 'timur.ridjanovic@gmail.com';
    members.add(tim);
    expect(members.count == 1);

    var dzenan = new Member(memberConcept);
    expect(dzenan, isNotNull);
    dzenan.firstName = 'Dzenan';
    dzenan.lastName = 'Ridjanovic';
    //dzenan.code = '${dzenan.lastName}, ${dzenan.firstName}';
    dzenan.email = 'dzenanr@gmail.com';
    members.add(dzenan);
    expect(members.count == 2);

    members.display('User Data Creation');
  });
}

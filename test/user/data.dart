testUserData() {
  var data;
  var dzenanOid;
  group('Testing', () {
    setUp(() {
      data = new UserData();

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
      dzenanOid = dzenan.oid;
      expect(dzenanOid, isNotNull);
      var dr = members.getEntity(dzenanOid);
      expect(dr, isNotNull);

      var charlem = new Member(memberConcept);
      expect(charlem, isNotNull);
      charlem.firstName = 'Charle';
      charlem.lastName = 'Mantha';
      charlem.email = 'charlem@hotmail.com';
      members.add(charlem);
      expect(members.count == 3);
    });
    tearDown(() {
      var members = data.members;
      members.empty();
      expect(members.count == 0);
    });
    test('Select Members By Attribute', () {
      var members = data.members;
      expect(members.count == 3);
      members.display('All Members');

      List<Member> selectedMemberList =
          members.selectByAttribute('lastName', 'Ridjanovic');
      expect(selectedMemberList, isNotNull);
      expect(selectedMemberList, isNot(isEmpty));
      expect(selectedMemberList.length == 2);

      Members selectedMembers = new Members(data.memberConcept);
      selectedMembers.addFrom(selectedMemberList);
      selectedMembers.sourceEntities = members;
      expect(selectedMembers, isNotNull);
      expect(selectedMembers, isNot(isEmpty));
      expect(selectedMembers.count == 2);
      expect(selectedMembers.sourceEntities, isNotNull);
      expect(selectedMembers.sourceEntities, isNot(isEmpty));
      expect(selectedMembers.sourceEntities.count == 3);

      selectedMembers.display('Selected Members Before Remove');
      expect(selectedMembers.count == 2);
      expect(members.count == 3);
      expect(dzenanOid, isNotNull);
      var dzenan = selectedMembers.getEntity(dzenanOid);
      expect(dzenan, isNotNull);
      selectedMembers.remove(dzenan);
      expect(selectedMembers.count == 1);
      expect(members.count == 2);
      selectedMembers.display('Selected Members After Remove');

      members.display('All Members After Remove');
    });
    test('Order Members By Function', () {
      var members = data.members;
      expect(members.count == 3);
      members.display('Members');

      List<Member> orderedMemberList =
          members.order((m,n) => m.compareTo(n));
      expect(orderedMemberList, isNotNull);
      expect(orderedMemberList, isNot(isEmpty));
      expect(orderedMemberList.length == 3);

      Members orderedMembers = new Members(data.memberConcept);
      orderedMembers.addFrom(orderedMemberList);
      orderedMembers.sourceEntities = members;
      expect(orderedMembers, isNotNull);
      expect(orderedMembers, isNot(isEmpty));
      expect(orderedMembers.count == 3);
      expect(orderedMembers.sourceEntities, isNotNull);
      expect(orderedMembers.sourceEntities, isNot(isEmpty));
      expect(orderedMembers.sourceEntities.count == 3);

      orderedMembers.display('Ordered Members');
    });
  });
}
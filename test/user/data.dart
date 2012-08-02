
testUserData() {
  var data;
  var memberCount;
  var dzenanOid;
  group('Testing', () {
    setUp(() {
      data = new UserData();

      var memberConcept = data.memberConcept;
      expect(memberConcept, isNotNull);
      expect(memberConcept.attributes, isNot(isEmpty));
      expect(memberConcept.attributes.count == 9);
      memberConcept.attributes.getEntityByCode('password').sensitive = true;

      memberCount = 0;

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

      var dzenan = new Member(memberConcept);
      expect(dzenan, isNotNull);
      dzenan.code = 'dzenanr';
      dzenan.password = 'drifting09';
      dzenan.firstName = 'Dzenan';
      dzenan.lastName = 'Ridjanovic';
      dzenan.email = 'dzenanr@gmail.com';
      dzenan.receiveEmail = true;
      dzenan.role = 'admin';
      dzenan.karma = 17.9;
      dzenan.about = '''I like to walk, hike and stop to have a good bite and drink. 
    In addition, my name is Dženan Riđanović (Dzenan Ridjanovic). 
    I am an associate professor in the Business School at the 
    Laval University (Université Laval), Quebec, Canada. 
    I received a B.Sc. in informatics from the University of Sarajevo, 
    an M.Sc. in computer science from the University of Maryland, 
    and a Ph.D. in management information systems from the 
    University of Minnesota. My research interests are in the 
    spiral development of domain models and dynamic web applications
    with NoSQL databases.''';
      members.add(dzenan);
      expect(members.count == ++memberCount);
      dzenanOid = dzenan.oid;
      expect(dzenanOid, isNotNull);
      var dr = members.getEntity(dzenanOid);
      expect(dr, isNotNull);

      var charlem = new Member(memberConcept);
      expect(charlem, isNotNull);
      charlem.code = 'charlem';
      charlem.password = 'ccNo77voice';
      charlem.firstName = 'Charle';
      charlem.lastName = 'Mantha';
      charlem.email = 'charlem@hotmail.com';
      members.add(charlem);
      expect(members.count == ++memberCount);

      var amracr = new Member(memberConcept);
      expect(amracr, isNotNull);
      amracr.code = 'acr';
      amracr.password = 'a2c4r0';
      amracr.firstName = 'Amra';
      amracr.lastName = 'Curovac Ridjanovic';
      amracr.email = 'amracr@gmail.com';
      amracr.receiveEmail = true;
      members.add(amracr);
      expect(members.count == ++memberCount);
    });
    tearDown(() {
      var members = data.members;
      members.empty();
      expect(members.count == 0);
    });
    test('Add Member Required Error', () {
      var members = data.members;
      expect(members.count == memberCount);

      var memberConcept = data.memberConcept;
      expect(memberConcept, isNotNull);
      expect(memberConcept.attributes, isNot(isEmpty));

      var robertm = new Member(memberConcept);
      expect(robertm, isNotNull);
      robertm.firstName = 'Robert';
      robertm.email = 'robertm@gmail.com';
      members.add(robertm);
      expect(members.count == memberCount);
      expect(members.errors.count == 2);
      expect(members.errors.list[0].category == 'required');
      expect(members.errors.list[1].category == 'required');
      //members.errors.display('Add Member Required Error');
    });
    test('Add Member Unique Error', () {
      var members = data.members;
      expect(members.count == memberCount);

      var memberConcept = data.memberConcept;
      expect(memberConcept, isNotNull);
      expect(memberConcept.attributes, isNot(isEmpty));

      var robertm = new Member(memberConcept);
      expect(robertm, isNotNull);
      robertm.firstName = 'Robert';
      robertm.lastName = 'Mantha';
      robertm.email = 'charlem@hotmail.com';
      expect(memberConcept.getAttribute('email').id, isTrue);
      expect(robertm.id.count == 1);
      expect(robertm.id.getAttribute('email') == robertm.email);
      members.add(robertm);
      expect(members.count == memberCount);
      expect(members.errors.count == 2);
      expect(members.errors.list[0].category == 'required');
      expect(members.errors.list[1].category == 'unique');
      //members.errors.display('Add Member Unique Error');
    });
    test('Add Member Required and Unique Error', () {
      var members = data.members;
      expect(members.count == memberCount);

      var memberConcept = data.memberConcept;
      expect(memberConcept, isNotNull);
      expect(memberConcept.attributes, isNot(isEmpty));

      var robertm = new Member(memberConcept);
      expect(robertm, isNotNull);
      robertm.firstName = 'Robert';
      robertm.email = 'charlem@hotmail.com';
      members.add(robertm);
      expect(members.count == memberCount);
      expect(members.errors.count == 3);
      expect(members.errors.list[0].category == 'required');
      expect(members.errors.list[1].category == 'required');
      expect(members.errors.list[2].category == 'unique');
      members.errors.display('Add Member Required and Unique Error');
    });
    test('Select Members by Attribute then Remove', () {
      var members = data.members;
      expect(members.count == memberCount);

      Members selectedMembers =
          members.selectByAttribute('lastName', 'Ridjanovic');
      expect(selectedMembers, isNotNull);
      expect(selectedMembers, isNot(isEmpty));
      expect(selectedMembers.count == 2);
      expect(selectedMembers.sourceEntities, isNotNull);
      expect(selectedMembers.sourceEntities, isNot(isEmpty));
      expect(selectedMembers.sourceEntities.count == memberCount);

      selectedMembers.display('Selected Members Before Remove');
      expect(selectedMembers.count == 2);
      expect(members.count == memberCount);
      expect(dzenanOid, isNotNull);
      var dzenan = selectedMembers.getEntity(dzenanOid);
      expect(dzenan, isNotNull);
      selectedMembers.remove(dzenan);
      expect(selectedMembers.count == 1);
      expect(members.count == memberCount - 1);

      selectedMembers.display('Selected Members After Remove');
      members.display('All Members After Remove');
    });
    test('Select Members by (get) Function', () {
      var members = data.members;
      expect(members.count == memberCount);

      var ridjanovicMembers = members.select((m) => m.ridjanovic);
      expect(ridjanovicMembers, isNotNull);
      expect(ridjanovicMembers, isNot(isEmpty));
      expect(ridjanovicMembers.length == 3);
    });
    test('Select Members by (bool) Attribute, which is (get) Function', () {
      var members = data.members;
      expect(members.count == memberCount);

      var receiveEmailMembers = members.select((m) => m.receiveEmail);
      expect(receiveEmailMembers, isNotNull);
      expect(receiveEmailMembers, isNot(isEmpty));
      expect(receiveEmailMembers.length == 2);
    });
    test('Order Members by Last then First Name', () {
      var members = data.members;
      expect(members.count == memberCount);

      Members orderedMembers = members.order();
      expect(orderedMembers, isNotNull);
      expect(orderedMembers, isNot(isEmpty));
      expect(orderedMembers.count == memberCount);
      expect(orderedMembers.sourceEntities, isNotNull);
      expect(orderedMembers.sourceEntities, isNot(isEmpty));
      expect(orderedMembers.sourceEntities.count == memberCount);

      orderedMembers.display('Members Ordered by Last then First Name');
    });
    test('Order Members by Code', () {
      var members = data.members;
      expect(members.count == memberCount);

      Members orderedMembers =
          members.orderByFunction((m,n) => m.compareCode(n));
      expect(orderedMembers, isNotNull);
      expect(orderedMembers, isNot(isEmpty));
      expect(orderedMembers.count == memberCount);
      expect(orderedMembers.sourceEntities, isNotNull);
      expect(orderedMembers.sourceEntities, isNot(isEmpty));
      expect(orderedMembers.sourceEntities.count == memberCount);

      orderedMembers.display('Members Ordered by Code');
    });
    test('New Member with Ids', () {
      var members = data.members;
      expect(members.count == memberCount);

      var memberConcept = data.memberConcept;
      expect(memberConcept, isNotNull);
      expect(memberConcept.attributes, isNot(isEmpty));

      var ogdenr = new Member.withIds(
          memberConcept, 'ogdenr', 'ogden.ridjanovic@gmail.com');
      expect(ogdenr, isNotNull);
      ogdenr.password = 'toto9tutu';
      ogdenr.firstName = 'Ogden';
      ogdenr.lastName = 'Ridjanovic';
      ogdenr.receiveEmail = false;
      members.add(ogdenr);
      expect(members.count == 5);

      members.display('Members Including Ogden');
    });
    test('New Date from String', () {
      Date date;
      var s;

      try {
        s = 'one day in a year';
        date = new Date.fromString(s);
      } catch (final IllegalArgumentException e) {
        expect(date, isNull);
        print('/// Not valid date: $s; $e');
        print('');
      }

      try {
        s = '';
        date = new Date.fromString(s);
      } catch (final IllegalArgumentException e) {
        expect(date, isNull);
        print('/// Not valid date: $s; $e');
        print('');
      }

      try {
        s = null;
        date = new Date.fromString(s);
      } catch (final NullPointerException e) {
        expect(date, isNull);
        print('/// Not valid date: $s; $e');
        print('');
      }
    });
    test('True for Some Projects', () {
      var members = data.members;
      expect(members.count == memberCount);

      expect(members.some((m) => m.about == null), isTrue);
    });

  });
}


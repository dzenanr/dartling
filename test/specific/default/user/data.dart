
class MemberReaction implements ActionReaction {

  bool reactedOnAdd = false;
  bool reactedOnUpdate = false;

  react(Action action) {
    if (action is EntitiesAction) {
      reactedOnAdd = true;
    } else if (action is EntityAction) {
      reactedOnUpdate = true;
    }
  }

}

testUserData(Repo repo, String modelCode) {
  var domainData;
  var session;
  var modelData;
  var members;
  var memberConcept;
  var memberCount = 0;
  var dzenanOid;
  group('Testing User', () {
    setUp(() {
      domainData = repo.defaultDomainModels;
      session = domainData.newSession();
      modelData = domainData.getModelEntries(modelCode);

      members = modelData.members;
      expect(members, isNotNull);
      expect(members.count, equals(memberCount));

      memberConcept = members.concept;
      expect(memberConcept, isNotNull);
      expect(memberConcept.attributes, isNot(isEmpty));
      expect(memberConcept.attributes.count == 9);
      memberConcept.attributes.findByCode('password').sensitive = true;

      var claudeb = new Member(memberConcept);
      expect(claudeb, isNotNull);
      claudeb.code = 'claudeb';
      claudeb.password = 'claudeb8527';
      claudeb.firstName = 'Claude';
      claudeb.lastName = 'Begin';
      claudeb.email = 'claude.begin@gmail.com';
      members.add(claudeb);
      expect(members.count, equals(++memberCount));

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
    In addition, my name is Denan Ri?anovi? (Dzenan Ridjanovic). 
    I am an associate professor in the Business School at the 
    Laval University (Universit Laval), Quebec, Canada. 
    I received a B.Sc. in informatics from the University of Sarajevo, 
    an M.Sc. in computer science from the University of Maryland, 
    and a Ph.D. in management information systems from the 
    University of Minnesota. My research interests are in the 
    spiral development of domain models and dynamic web applications
    with NoSQL databases.''';
      members.add(dzenan);
      expect(members.count, equals(++memberCount));
      dzenanOid = dzenan.oid;
      expect(dzenanOid, isNotNull);
      var dr = members.find(dzenanOid);
      expect(dr, isNotNull);

      var charlem = new Member(memberConcept);
      expect(charlem, isNotNull);
      charlem.code = 'charlem';
      charlem.password = 'ccNo77voice';
      charlem.firstName = 'Charle';
      charlem.lastName = 'Mantha';
      charlem.email = 'charlem@hotmail.com';
      members.add(charlem);
      expect(members.count, equals(++memberCount));

      var amracr = new Member(memberConcept);
      expect(amracr, isNotNull);
      amracr.code = 'acr';
      amracr.password = 'a2c4r0';
      amracr.firstName = 'Amra';
      amracr.lastName = 'Curovac Ridjanovic';
      amracr.email = 'amracr@gmail.com';
      amracr.receiveEmail = true;
      members.add(amracr);
      expect(members.count, equals(++memberCount));
    });
    tearDown(() {
      members.clear();
      expect(members.count, equals(0));
      memberCount = 0;
    });
    test('Add Member Required Error', () {
      var robertm = new Member(memberConcept);
      expect(robertm, isNotNull);
      robertm.firstName = 'Robert';
      robertm.email = 'robertm@gmail.com';
      members.add(robertm);
      expect(members.count, equals(memberCount));
      expect(members.errors.count, equals(2));
      expect(members.errors.list[0].category, equals('required'));
      expect(members.errors.list[1].category, equals('required'));
      //members.errors.display('Add Member Required Error');
    });
    test('Add Member Unique Error', () {
      var robertm = new Member(memberConcept);
      expect(robertm, isNotNull);
      robertm.firstName = 'Robert';
      robertm.lastName = 'Mantha';
      robertm.email = 'charlem@hotmail.com';
      expect(memberConcept.getAttribute('email').identifier, isTrue);
      expect(robertm.id.count, equals(1));
      expect(robertm.id.getAttribute('email'), equals(robertm.email));
      members.add(robertm);
      expect(members.count, equals(memberCount));
      expect(members.errors.count, equals(2));
      expect(members.errors.list[0].category, equals('required'));
      expect(members.errors.list[1].category, equals('unique'));
      //members.errors.display('Add Member Unique Error');
    });
    test('Add Member Required and Unique Error', () {
      var robertm = new Member(memberConcept);
      expect(robertm, isNotNull);
      robertm.firstName = 'Robert';
      robertm.email = 'charlem@hotmail.com';
      members.add(robertm);
      expect(members.count, equals(memberCount));
      expect(members.errors.count, equals(3));
      expect(members.errors.list[0].category, equals('required'));
      expect(members.errors.list[1].category, equals('required'));
      expect(members.errors.list[2].category, equals('unique'));
      //members.errors.display('Add Member Required and Unique Error');
    });
    test('Select Members by Attribute then Remove', () {
      //members.display('Members Before Remove');
      Members selectedMembers =
          members.selectByAttribute('lastName', 'Ridjanovic');
      expect(selectedMembers, isNotNull);
      expect(selectedMembers, isNot(isEmpty));
      selectedMembers.display('Selected Members Before Remove');
      expect(selectedMembers.count, equals(1));
      expect(selectedMembers.source, isNotNull);
      expect(selectedMembers.source, isNot(isEmpty));
      expect(selectedMembers.source.count, equals(memberCount));

      expect(members.count, equals(memberCount));
      expect(dzenanOid, isNotNull);
      var dzenan = selectedMembers.find(dzenanOid);
      expect(dzenan, isNotNull);
      selectedMembers.remove(dzenan);
      expect(selectedMembers.count, equals(0));
      expect(members.count, equals(memberCount - 1));

      selectedMembers.display('Selected Members After Remove');
      members.display('All Members After Remove');
    });
    test('Select Members by (get) Function', () {
      var ridjanovicMembers = members.select((m) => m.ridjanovic);
      expect(ridjanovicMembers, isNotNull);
      expect(ridjanovicMembers, isNot(isEmpty));
      expect(ridjanovicMembers.length, equals(2));
    });
    test('Select Members by (bool) Attribute, which is (get) Function', () {
      var receiveEmailMembers = members.select((m) => m.receiveEmail);
      expect(receiveEmailMembers, isNotNull);
      expect(receiveEmailMembers, isNot(isEmpty));
      expect(receiveEmailMembers.length, equals(2));
    });
    test('Order Members by Last then First Name', () {
      Members orderedMembers = members.order();
      expect(orderedMembers, isNotNull);
      expect(orderedMembers, isNot(isEmpty));
      expect(orderedMembers.count, equals(memberCount));
      expect(orderedMembers.source, isNotNull);
      expect(orderedMembers.source, isNot(isEmpty));
      expect(orderedMembers.source.count, equals(memberCount));

      orderedMembers.display('Members Ordered by Last then First Name');
    });
    test('Order Members by Code', () {
      Members orderedMembers =
          members.orderByFunction((m,n) => m.compareCode(n));
      expect(orderedMembers, isNotNull);
      expect(orderedMembers, isNot(isEmpty));
      expect(orderedMembers.count, equals(memberCount));
      expect(orderedMembers.source, isNotNull);
      expect(orderedMembers.source, isNot(isEmpty));
      expect(orderedMembers.source.count, equals(memberCount));

      orderedMembers.display('Members Ordered by Code');
    });
    test('New Member with Ids', () {
      var ogdenr = new Member.withIds(
          memberConcept, 'ogdenr', 'ogden.ridjanovic@gmail.com');
      expect(ogdenr, isNotNull);
      ogdenr.password = 'toto9tutu';
      ogdenr.firstName = 'Ogden';
      ogdenr.lastName = 'Ridjanovic';
      ogdenr.receiveEmail = false;
      members.add(ogdenr);
      expect(members.count, equals(++memberCount));

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
      expect(members.some((m) => m.about == null), isTrue);
    });
    test('New Member Undo', () {
      var robertm = new Member(memberConcept);
      expect(robertm, isNotNull);
      robertm.code = 'rwm';
      robertm.password = 'r1w2m32';
      robertm.firstName = 'Robert';
      robertm.lastName = 'Mantha';
      robertm.email = 'robert.mantha@abc.com';

      var action = new AddAction(session, members, robertm);
      action.doit();
      expect(members.count, equals(++memberCount));

      session.past.undo();
      expect(members.count, equals(--memberCount));

      session.past.redo();
      expect(members.count, equals(++memberCount));
    });
    test('Update Member Undo', () {
      var acr = members.findByCode('acr');
      expect(acr, isNotNull);

      var action =
          new SetAttributeAction(session, acr, 'about', 'Intercultural interests.');
      action.doit();

      session.past.undo();
      expect(acr.about, equals(action.before));

      session.past.redo();
      expect(acr.about, equals(action.after));
    });
    test('Member Undo', () {
      var mauricel = new Member(memberConcept);
      expect(mauricel, isNotNull);
      mauricel.code = 'mauricel';
      mauricel.password = 'mauriceltom0';
      mauricel.firstName = 'Maurice';
      mauricel.lastName = 'Laundry';
      mauricel.email = 'mlaundry@gmail.com';

      var action = new AddAction(session, members, mauricel);
      action.doit();
      expect(members.count, equals(++memberCount));
      members.display('After Add on Members');

      session.past.undo();
      expect(members.count, equals(--memberCount));
      members.display('After Undo on Members');

      session.past.redo();
      expect(members.count, equals(++memberCount));
      members.display('After Undoing Undo on Members');

      var about = 'Maurice is a calm fellow, with good spirit.';
      action = new SetAttributeAction(session, mauricel, 'about', about);
      action.doit();
      members.display('After Update on Member');

      session.past.undo();
      expect(mauricel.about, isNot(equals(about)));
      members.display('After Undo on Member');

      session.past.redo();
      expect(mauricel.about, equals(about));
      members.display('After Undoing Undo on Member');
    });
    test('Reactions to Member Actions', () {
      var reaction = new MemberReaction();
      expect(reaction, isNotNull);

      domainData.startActionReaction(reaction);
      var member = new Member(memberConcept);
      expect(member, isNotNull);
      member.code = 'amemberurr';
      member.password = 'membermy8527';
      member.firstName = 'John';
      member.lastName = 'Smith';
      member.email = 'john.smith@gmail.com';

      var action = new AddAction(session, members, member);
      action.doit();
      expect(members.count, equals(++memberCount));
      expect(reaction.reactedOnAdd, isTrue);

      var about = 'He is a good fellow, with good sense of humor.';
      action = new SetAttributeAction(session, member, 'about', about);
      action.doit();
      expect(reaction.reactedOnUpdate, isTrue);
      domainData.cancelActionReaction(reaction);
    });
    test('Add Member Pre Validation', () {
      var robertm = new Member(memberConcept);
      expect(robertm, isNotNull);
      robertm.code = 'robertm';
      robertm.password = 'rvvm3w';
      robertm.firstName = 'Robert';
      robertm.lastName = 'Mantha';
      robertm.email = 'robertm@gmail.com';
      robertm.role = 'prof';
      members.add(robertm);
      expect(members.count, equals(memberCount));
      expect(members.errors.list, hasLength(1));
      expect(members.errors.list[0].category, equals('pre'));
      //members.errors.display('Add Member Pre Error');
    });

  });
}

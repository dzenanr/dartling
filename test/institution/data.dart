
EcoleEntry fromJsonToUserEntry() {
  /**

   */
  var _json = '''
   {"width":990,"lines":[],"height":580,"boxes":[{"entry":false,"name":"Ecole",
  "x":342,"y":252,"width":120,"height":120,"items":[{"sequence":10,"category":"attribute",
  "name":"numeroEcole","type":"String","init":""},{"sequence":20,"category":"attribute",
  "name":"nomEcole","type":"String","init":""}]}]}
    ''';
  return new EcoleEntry(fromMagicBoxes(_json));
}

class EcoleReaction implements ActionReaction {

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

testUserData() {
  var entry;
  var session;
  var data;
  var members;
  var memberConcept;
  var memberCount;
  var dzenanOid;
  group('Testing User', () {
    setUp(() {
      entry = fromJsonToUserEntry();
      data = entry.data;
      session = entry.newSession();

      ecoleConcept = data.memberConcept;
      expect(ecoleConcept, isNotNull);
      expect(ecoleConcept.attributes, isNot(isEmpty));
      expect(ecoleConcept.attributes.count ==2 );


      ecoleCount = 0;

      ecoles = data.ecloes;
      expect(ecoles, isNotNull);
      expect(ecoles.count, equals(ecoleCount));

      var lavalHighScool = new Ecole(ecoleConcept);
      expect(lavalHighScool, isNotNull);
      lavalHighScool.numeroEcole = 2;
      lavalHighScool.nomEcole = 'Laval School';
      ecoles.add(lavalHighScool);
      expect(ecoles.count, equals(++ecoleCount));

      var ULaval = new Ecole(ecoleConcept);
      expect(ULaval, isNotNull);
      ULaval.numeroEcole = 2;
      ULaval.password = 'Laval Univ';
      ecoles.add(ULaval);
      expect(ecoles.count, equals(++ecoleCount));
      UlavaOid = ULaval.oid;
      expect(UlavaOid, isNotNull);
      var dr = ecoles.find(UlavaOid);
      expect(dr, isNotNull);


    });
    tearDown(() {
      ecoles.clear();
      expect(ecoles.count, equals(0));
    });
    test('Add Ecole Required Error', () {
      var robertm = new Ecole(ecoleConcept);
      expect(robertm, isNotNull);
      robertm.numerEcole = 2;
      robertm.nomEcole = 'Robert school';
      ecoles.add(robertm);
      expect(ecoles.count == ecoleCount);
      expect(ecoles.errors.count == 2);
      expect(ecoles.errors.list[0].category == 'required');
      expect(ecoles.errors.list[1].category == 'required');
      //members.errors.display('Add Member Required Error');
    });
    test('Add Member Unique Error', () {
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
      //members.errors.display('Add Member Required and Unique Error');
    });
    test('Select Members by Attribute then Remove', () {
      Members selectedMembers =
          members.selectByAttribute('lastName', 'Ridjanovic');
      expect(selectedMembers, isNotNull);
      expect(selectedMembers, isNot(isEmpty));
      expect(selectedMembers.count == 2);
      expect(selectedMembers.source, isNotNull);
      expect(selectedMembers.source, isNot(isEmpty));
      expect(selectedMembers.source.count == memberCount);

      selectedMembers.display('Selected Members Before Remove');
      expect(selectedMembers.count == 2);
      expect(members.count == memberCount);
      expect(dzenanOid, isNotNull);
      var dzenan = selectedMembers.find(dzenanOid);
      expect(dzenan, isNotNull);
      selectedMembers.remove(dzenan);
      expect(selectedMembers.count == 1);
      expect(members.count == memberCount - 1);

      selectedMembers.display('Selected Members After Remove');
      members.display('All Members After Remove');
    });
    test('Select Members by (get) Function', () {
      var ridjanovicMembers = members.select((m) => m.ridjanovic);
      expect(ridjanovicMembers, isNotNull);
      expect(ridjanovicMembers, isNot(isEmpty));
      expect(ridjanovicMembers.length == 3);
    });
    test('Select Members by (bool) Attribute, which is (get) Function', () {
      var receiveEmailMembers = members.select((m) => m.receiveEmail);
      expect(receiveEmailMembers, isNotNull);
      expect(receiveEmailMembers, isNot(isEmpty));
      expect(receiveEmailMembers.length == 2);
    });
    test('Order Members by Last then First Name', () {
      Members orderedMembers = members.order();
      expect(orderedMembers, isNotNull);
      expect(orderedMembers, isNot(isEmpty));
      expect(orderedMembers.count == memberCount);
      expect(orderedMembers.source, isNotNull);
      expect(orderedMembers.source, isNot(isEmpty));
      expect(orderedMembers.source.count == memberCount);

      orderedMembers.display('Members Ordered by Last then First Name');
    });
    test('Order Members by Code', () {
      Members orderedMembers =
          members.orderByFunction((m,n) => m.compareCode(n));
      expect(orderedMembers, isNotNull);
      expect(orderedMembers, isNot(isEmpty));
      expect(orderedMembers.count == memberCount);
      expect(orderedMembers.source, isNotNull);
      expect(orderedMembers.source, isNot(isEmpty));
      expect(orderedMembers.source.count == memberCount);

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
      var claudeb = new Member(memberConcept);
      expect(claudeb, isNotNull);
      claudeb.code = 'claudeb';
      claudeb.password = 'claudebtom0';
      claudeb.firstName = 'Claude';
      claudeb.lastName = 'Begin';
      claudeb.email = 'claude.begin@gmail.com';

      var action = new AddAction(session, members, claudeb);
      action.doit();
      expect(members.count, equals(++memberCount));
      members.display('After Add on Members');

      session.past.undo();
      expect(members.count, equals(--memberCount));
      members.display('After Undo on Members');

      session.past.redo();
      expect(members.count, equals(++memberCount));
      members.display('After Undoing Undo on Members');

      var about = 'Claude is a calm fellow, with good spirit.';
      action = new SetAttributeAction(session, claudeb, 'about', about);
      action.doit();
      members.display('After Update on Member');

      session.past.undo();
      expect(claudeb.about, isNot(equals(about)));
      members.display('After Undo on Member');

      session.past.redo();
      expect(claudeb.about, equals(about));
      members.display('After Undoing Undo on Member');
    });
    test('Reactions to Member Actions', () {
      var reaction = new MemberReaction();
      expect(reaction, isNotNull);

      entry.startActionReaction(reaction);
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

      entry.startActionReaction(reaction);
      var about = 'He is a calm fellow, with good spirit.';
      action = new SetAttributeAction(session, member, 'about', about);
      action.doit();
      expect(reaction.reactedOnUpdate, isTrue);
      entry.cancelActionReaction(reaction);
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
      expect(members.errors.count, equals(1));
      expect(members.errors.list[0].category, equals('pre'));
      members.errors.display('Add Member Pre Error');
    });

  });
}



class UserReaction implements ActionReactionApi {

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
  var models;
  var session;
  var entries;
  var users;
  var userConcept;
  var userCount = 0;
  var dzenanOid;
  group('Testing ${modelCode}', () {
    setUp(() {
      models = repo.getDomainModels('Default');
      expect(models, isNotNull);
      session = models.newSession();
      entries = models.getModelEntries(modelCode);
      expect(entries, isNotNull);

      users = entries.users;
      expect(users, isNotNull);
      expect(users.count, equals(userCount));

      userConcept = users.concept;
      expect(userConcept, isNotNull);
      expect(userConcept.attributes.list, isNot(isEmpty));
      userConcept.attributes.findByCode('password').sensitive = true;

      var claudeb = new User(userConcept);
      expect(claudeb, isNotNull);
      claudeb.code = 'claudeb';
      claudeb.password = 'claudeb8527';
      claudeb.firstName = 'Claude';
      claudeb.lastName = 'Begin';
      claudeb.email = 'claude.begin@gmail.com';
      users.add(claudeb);
      expect(users.count, equals(++userCount));

      var dzenan = new User(userConcept);
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
      users.add(dzenan);
      expect(users.count, equals(++userCount));
      dzenanOid = dzenan.oid;
      expect(dzenanOid, isNotNull);
      var dr = users.find(dzenanOid);
      expect(dr, isNotNull);

      var charlem = new User(userConcept);
      expect(charlem, isNotNull);
      charlem.code = 'charlem';
      charlem.password = 'ccNo77voice';
      charlem.firstName = 'Charle';
      charlem.lastName = 'Mantha';
      charlem.email = 'charlem@hotmail.com';
      users.add(charlem);
      expect(users.count, equals(++userCount));

      var amracr = new User(userConcept);
      expect(amracr, isNotNull);
      amracr.code = 'acr';
      amracr.password = 'a2c4r0';
      amracr.firstName = 'Amra';
      amracr.lastName = 'Curovac Ridjanovic';
      amracr.email = 'amracr@gmail.com';
      amracr.receiveEmail = true;
      users.add(amracr);
      expect(users.count, equals(++userCount));
    });
    tearDown(() {
      users.clear();
      expect(users.count, equals(0));
      userCount = 0;
    });
    test('Add User Required Error', () {
      var robertm = new User(userConcept);
      expect(robertm, isNotNull);
      robertm.firstName = 'Robert';
      robertm.email = 'robertm@gmail.com';
      users.add(robertm);
      expect(users.count, equals(userCount));
      expect(users.errors.count, equals(2));
      expect(users.errors.list[0].category, equals('required'));
      expect(users.errors.list[1].category, equals('required'));
      //users.errors.display('Add User Required Error');
    });
    test('Add User Unique Error', () {
      var robertm = new User(userConcept);
      expect(robertm, isNotNull);
      robertm.firstName = 'Robert';
      robertm.lastName = 'Mantha';
      robertm.email = 'charlem@hotmail.com';
      expect(userConcept.getAttribute('email').identifier, isTrue);
      expect(robertm.id.count, equals(1));
      expect(robertm.id.getAttribute('email'), equals(robertm.email));
      users.add(robertm);
      expect(users.count, equals(userCount));
      expect(users.errors.count, equals(2));
      expect(users.errors.list[0].category, equals('required'));
      expect(users.errors.list[1].category, equals('unique'));
      //users.errors.display('Add User Unique Error');
    });
    test('Add User Required and Unique Error', () {
      var robertm = new User(userConcept);
      expect(robertm, isNotNull);
      robertm.firstName = 'Robert';
      robertm.email = 'charlem@hotmail.com';
      users.add(robertm);
      expect(users.count, equals(userCount));
      expect(users.errors.count, equals(3));
      expect(users.errors.list[0].category, equals('required'));
      expect(users.errors.list[1].category, equals('required'));
      expect(users.errors.list[2].category, equals('unique'));
      //users.errors.display('Add User Required and Unique Error');
    });
    test('Select Users by Attribute then Remove', () {
      //users.display('Users Before Remove');
      Users selectedUsers =
          users.selectByAttribute('lastName', 'Ridjanovic');
      expect(selectedUsers, isNotNull);
      expect(selectedUsers.list, isNot(isEmpty));
      selectedUsers.display('Selected Users Before Remove');
      expect(selectedUsers.count, equals(1));
      expect(selectedUsers.source, isNotNull);
      expect(selectedUsers.source.list, isNot(isEmpty));
      expect(selectedUsers.source.count, equals(userCount));

      expect(users.count, equals(userCount));
      expect(dzenanOid, isNotNull);
      var dzenan = selectedUsers.find(dzenanOid);
      expect(dzenan, isNotNull);
      selectedUsers.remove(dzenan);
      expect(selectedUsers.count, equals(0));
      expect(users.count, equals(userCount - 1));

      selectedUsers.display('Selected Users After Remove');
      users.display('All Users After Remove');
    });
    test('Select Users by (get) Function', () {
      var ridjanovicUsers = users.select((m) => m.ridjanovic);
      expect(ridjanovicUsers, isNotNull);
      expect(ridjanovicUsers.list, isNot(isEmpty));
      expect(ridjanovicUsers.length, equals(2));
    });
    test('Select Users by (bool) Attribute, which is (get) Function', () {
      var receiveEmailUsers = users.select((m) => m.receiveEmail);
      expect(receiveEmailUsers, isNotNull);
      expect(receiveEmailUsers.list, isNot(isEmpty));
      expect(receiveEmailUsers.length, equals(2));
    });
    test('Order Users by Last then First Name', () {
      Users orderedUsers = users.order();
      expect(orderedUsers, isNotNull);
      expect(orderedUsers.list, isNot(isEmpty));
      expect(orderedUsers.count, equals(userCount));
      expect(orderedUsers.source, isNotNull);
      expect(orderedUsers.source.list, isNot(isEmpty));
      expect(orderedUsers.source.count, equals(userCount));

      orderedUsers.display('Users Ordered by Last then First Name');
    });
    test('Order Users by Code', () {
      Users orderedUsers =
          users.orderByFunction((m,n) => m.compareCode(n));
      expect(orderedUsers, isNotNull);
      expect(orderedUsers.list, isNot(isEmpty));
      expect(orderedUsers.count, equals(userCount));
      expect(orderedUsers.source, isNotNull);
      expect(orderedUsers.source.list, isNot(isEmpty));
      expect(orderedUsers.source.count, equals(userCount));

      orderedUsers.display('Users Ordered by Code');
    });
    test('New User with Ids', () {
      var ogdenr = new User.withIds(
          userConcept, 'ogdenr', 'ogden.ridjanovic@gmail.com');
      expect(ogdenr, isNotNull);
      ogdenr.password = 'toto9tutu';
      ogdenr.firstName = 'Ogden';
      ogdenr.lastName = 'Ridjanovic';
      ogdenr.receiveEmail = false;
      users.add(ogdenr);
      expect(users.count, equals(++userCount));

      users.display('Users Including Ogden');
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
      expect(users.some((m) => m.about == null), isTrue);
    });
    test('New User Undo', () {
      var robertm = new User(userConcept);
      expect(robertm, isNotNull);
      robertm.code = 'rwm';
      robertm.password = 'r1w2m32';
      robertm.firstName = 'Robert';
      robertm.lastName = 'Mantha';
      robertm.email = 'robert.mantha@abc.com';

      var action = new AddAction(session, users, robertm);
      action.doit();
      expect(users.count, equals(++userCount));

      session.past.undo();
      expect(users.count, equals(--userCount));

      session.past.redo();
      expect(users.count, equals(++userCount));
    });
    test('Update User Undo', () {
      var acr = users.findByCode('acr');
      expect(acr, isNotNull);

      var action =
          new SetAttributeAction(session, acr, 'about', 'Intercultural interests.');
      action.doit();

      session.past.undo();
      expect(acr.about, equals(action.before));

      session.past.redo();
      expect(acr.about, equals(action.after));
    });
    test('User Undo', () {
      var mauricel = new User(userConcept);
      expect(mauricel, isNotNull);
      mauricel.code = 'mauricel';
      mauricel.password = 'mauriceltom0';
      mauricel.firstName = 'Maurice';
      mauricel.lastName = 'Laundry';
      mauricel.email = 'mlaundry@gmail.com';

      var action = new AddAction(session, users, mauricel);
      action.doit();
      expect(users.count, equals(++userCount));
      users.display('After Add on Users');

      session.past.undo();
      expect(users.count, equals(--userCount));
      users.display('After Undo on Users');

      session.past.redo();
      expect(users.count, equals(++userCount));
      users.display('After Undoing Undo on Users');

      var about = 'Maurice is a calm fellow, with good spirit.';
      action = new SetAttributeAction(session, mauricel, 'about', about);
      action.doit();
      users.display('After Update on User');

      session.past.undo();
      expect(mauricel.about, isNot(equals(about)));
      users.display('After Undo on User');

      session.past.redo();
      expect(mauricel.about, equals(about));
      users.display('After Undoing Undo on User');
    });
    test('Reactions to User Actions', () {
      var reaction = new UserReaction();
      expect(reaction, isNotNull);

      models.startActionReaction(reaction);
      var user = new User(userConcept);
      expect(user, isNotNull);
      user.code = 'amemberurr';
      user.password = 'membermy8527';
      user.firstName = 'John';
      user.lastName = 'Smith';
      user.email = 'john.smith@gmail.com';

      var action = new AddAction(session, users, user);
      action.doit();
      expect(users.count, equals(++userCount));
      expect(reaction.reactedOnAdd, isTrue);

      var about = 'He is a good fellow, with good sense of humor.';
      action = new SetAttributeAction(session, user, 'about', about);
      action.doit();
      expect(reaction.reactedOnUpdate, isTrue);
      models.cancelActionReaction(reaction);
    });
    test('Add User Pre Validation', () {
      var robertm = new User(userConcept);
      expect(robertm, isNotNull);
      robertm.code = 'robertm';
      robertm.password = 'rvvm3w';
      robertm.firstName = 'Robert';
      robertm.lastName = 'Mantha';
      robertm.email = 'robertm@gmail.com';
      robertm.role = 'prof';
      users.add(robertm);
      expect(users.count, equals(userCount));
      expect(users.errors.list, hasLength(1));
      expect(users.errors.list[0].category, equals('pre'));
      //users.errors.display('Add User Pre Error');
    });
    test('From User Model to JSON', () {
      var json = entries.toJson();
      expect(json, isNotNull);
      entries.display(json, 'User Model in JSON');
    });
    test('From JSON to User Model', () {
      expect(users.list, isNot(isEmpty));
      users.clear();
      expect(users.list, isEmpty);
      entries.fromJsonToData();

      expect(users.list, isNot(isEmpty));
      users.display('From JSON to User Model');
    });

  });
}

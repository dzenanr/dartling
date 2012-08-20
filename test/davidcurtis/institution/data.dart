
class EcoleReaction implements ActionReactionApi {

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

testDavidCurtisInstitutionData(Repo repo, String domainCode, String modelCode) {
  var models;
  var session;
  var entries;
  var ecoles;
  var ecoleConcept;
  var ecoleCount = 0;
  var uLavalOid;
  var entry ;
  var data ;
  var domainData;
  var modelData;
  group('Testing ${domainCode}.${modelCode}', () {
    setUp(() {
      models = repo.getDomainModels(domainCode);
      session = models.newSession();
      entries = models.getModelEntries(modelCode);

      ecoles = entries.ecoles;
      expect(ecoles.count, equals(ecoleCount));

      ecoleConcept = ecoles.concept;
      expect(ecoleConcept, isNotNull);
      expect(ecoleConcept.attributes.list, isNot(isEmpty));
      expect(ecoleConcept.attributes.count, equals(3));

      var lavalHighScool = new Ecole(ecoleConcept);
      expect(lavalHighScool, isNotNull);
      lavalHighScool.numero = 2;
      lavalHighScool.nom = 'Laval School';
      lavalHighScool.adress = '1307 Chemin Sainte Foy';
      ecoles.add(lavalHighScool);
      expect(ecoles.count, equals(++ecoleCount));

      var abcScool = new Ecole(ecoleConcept);
      expect(abcScool, isNotNull);
      abcScool.numero = 3;
      abcScool.nom = 'Abc School';
      abcScool.adress = '122 Chemain Quatre bourgeois';
      ecoles.add(abcScool);
      expect(ecoles.count, equals(++ecoleCount));

      var uLaval = new Ecole(ecoleConcept);
      expect(uLaval, isNotNull);
      uLaval.numero = 1;
      uLaval.nom = 'Laval Univ';
      uLaval.adress = '1245 Rue University';
      ecoles.add(uLaval);
      expect(ecoles.count, equals(++ecoleCount));
      uLavalOid = uLaval.oid;
      expect(uLavalOid, isNotNull);
      var ul = ecoles.find(uLavalOid);
      expect(ul, isNotNull);
    });
    tearDown(() {
      ecoles.clear();
      expect(ecoles.count, equals(0));
      ecoleCount = 0;
    });
    test('Select Ecoles by Attribute', () {
      ecoles.display('All Ecoles');

      Ecoles selectedEcoles =
          ecoles.selectByAttribute('nom', 'Laval School');
      expect(selectedEcoles.list, isNot(isEmpty));
      expect(selectedEcoles.count, equals(1));
      expect(selectedEcoles.source.list, isNot(isEmpty));
      expect(selectedEcoles.source.count, equals(ecoleCount));

      selectedEcoles.display('Selected Ecoles');
    });
    test('Select Ecoles by Attribute then Remove', () {
      Ecoles selectedEcoles =
          ecoles.selectByAttribute('nom', 'Laval Univ');
      expect(selectedEcoles.list, isNot(isEmpty));
      expect(selectedEcoles.count, equals(1));
      expect(selectedEcoles.source.list, isNot(isEmpty));
      expect(selectedEcoles.source.count, equals(ecoleCount));

      selectedEcoles.display('Selected Ecoles Before Remove');
      expect(selectedEcoles.count, equals(1));
      expect(ecoles.count, equals(ecoleCount));
      var uLaval = selectedEcoles.find(uLavalOid);
      expect(uLaval, isNotNull);
      selectedEcoles.remove(uLaval);
      expect(selectedEcoles.count, equals(0));
      expect(ecoles.count, equals(--ecoleCount));

      selectedEcoles.display('Selected Ecoles After Remove');
      ecoles.display('All Ecoles After Remove');
    });
    test('Order Ecoles by Numero', () {
      Ecoles orderedEcoles = ecoles.order();
      expect(orderedEcoles.list, isNot(isEmpty));
      expect(orderedEcoles.count, equals(ecoleCount));
      expect(orderedEcoles.source.list, isNot(isEmpty));
      expect(orderedEcoles.source.count, equals(ecoleCount));
      orderedEcoles.display('Ecoles Ordered by Numero');
    });
    test('Order Ecoles by Nom', () {
      Ecoles orderedEcoles =
          ecoles.orderByFunction((m,n) => m.compareNom(n));
      expect(orderedEcoles.list, isNot(isEmpty));
      expect(orderedEcoles.count, equals(ecoleCount));
      expect(orderedEcoles.source.list, isNot(isEmpty));
      expect(orderedEcoles.source.count, equals(ecoleCount));
      orderedEcoles.display('Ecoles Ordered by Nom');
    });

    test('Order Ecoles by Adress', () {
      Ecoles orderedEcoles =
          ecoles.orderByFunction((m,n) => m.compareAdress(n));
      expect(orderedEcoles.list, isNot(isEmpty));
      expect(orderedEcoles.count, equals(ecoleCount));
      expect(orderedEcoles.source.list, isNot(isEmpty));
      expect(orderedEcoles.source.count, equals(ecoleCount));
      orderedEcoles.display('Ecoles Ordered by Address');
    });
    test('New Ecole with Id', () {
      var cba = new Ecole.withId(ecoleConcept, 99);
      expect(cba, isNotNull);
      cba.nom = 'CBA';
      ecoles.add(cba);
      expect(ecoles.count, equals(++ecoleCount));
    });
    test('New Ecole Undo', () {
      var yyySchool = new Ecole(ecoleConcept);
      expect(yyySchool, isNotNull);
      yyySchool.numero = 4;
      yyySchool.nom = 'YYY School';
      yyySchool.adress = 'New Orleans 11 St';

      var action = new AddAction(session, ecoles, yyySchool);
      action.doit();
      expect(ecoles.count, equals(++ecoleCount));

      session.past.undo();
      expect(ecoles.count, equals(--ecoleCount));

      session.past.redo();
      expect(ecoles.count, equals(++ecoleCount));
    });
    test('Reactions to Ecole Actions', () {
      var reaction = new EcoleReaction();
      expect(reaction, isNotNull);

      models.startActionReaction(reaction);
      var yyySchool = new Ecole(ecoleConcept);
      expect(yyySchool, isNotNull);
      yyySchool.numero = 4;
      yyySchool.nom = 'YYY School';
      yyySchool.adress = 'New Orleans 11 St';

      var action = new AddAction(session, ecoles, yyySchool);
      action.doit();
      expect(ecoles.count, equals(++ecoleCount));
      expect(reaction.reactedOnAdd, isTrue);

      models.cancelActionReaction(reaction);
    });
    test('From Institution Model to JSON', () {
      var json = entries.toJson();
      expect(json, isNotNull);
      entries.display(json, 'Institution Model in JSON');
    });
    test('From JSON to Institution Model', () {
      expect(ecoles.list, isNot(isEmpty));
      ecoles.clear();
      expect(ecoles.list, isEmpty);
      entries.fromJsonToData();

      expect(ecoles.list, isNot(isEmpty));
      ecoles.display('From JSON to Institution Model');
    });

  });
}
import "package:test/test.dart";
import "package:dartling/dartling.dart"; 
 
import 'dartling_types.dart' as dt;
 
void testDartlingTypesTypes( 
    dt.DartlingDomain dartlingDomain, dt.TypesModel typesModel, dt.Types types) { 
  DomainSession session; 
  group("Testing Dartling.Types.Type", () { 
    session = dartlingDomain.newSession();  
    setUp(() { 
      typesModel.init(); 
    }); 
    tearDown(() { 
      typesModel.clear(); 
    }); 
 
    test("Not empty model", () { 
      expect(typesModel.isEmpty, isFalse); 
      expect(types.isEmpty, isFalse); 
    }); 
 
    test("Empty model", () { 
      typesModel.clear(); 
      expect(typesModel.isEmpty, isTrue); 
      expect(types.isEmpty, isTrue); 
      expect(types.exceptions.isEmpty, isTrue); 
    }); 
 
    test("From model to JSON", () { 
      var json = typesModel.toJson(); 
      expect(json, isNotNull); 
 
      print(json); 
      //typesModel.displayJson(); 
      //typesModel.display(); 
    }); 
 
    test("From JSON to model", () { 
      var json = typesModel.toJson(); 
      typesModel.clear(); 
      expect(typesModel.isEmpty, isTrue); 
      typesModel.fromJson(json); 
      expect(typesModel.isEmpty, isFalse); 
 
      typesModel.display(); 
    }); 
 
    test("From model entry to JSON", () { 
      var json = typesModel.fromEntryToJson("Type"); 
      expect(json, isNotNull); 
 
      print(json); 
      //typesModel.displayEntryJson("Type"); 
      //typesModel.displayJson(); 
      //typesModel.display(); 
    }); 
 
    test("From JSON to model entry", () { 
      var json = typesModel.fromEntryToJson("Type"); 
      types.clear(); 
      expect(types.isEmpty, isTrue); 
      typesModel.fromJsonToEntry(json); 
      expect(types.isEmpty, isFalse); 
 
      types.display(title: "From JSON to model entry"); 
    }); 
 
    test("Add type required error", () { 
      var typeConcept = types.concept; 
      var typeCount = types.length; 
      var type = new dt.Type(typeConcept); 
      var added = types.add(type); 
      expect(added, isFalse); 
      expect(types.length, equals(typeCount)); 
      expect(types.exceptions.length, greaterThan(0)); 
      expect(types.exceptions.toList()[0].category, equals("required")); 
 
      types.exceptions.display(title: "Add type required error"); 
    }); 
 
    test("Add type unique error", () { 
      // id attribute defined as increment, cannot update it 
    }); 
 
    test("Not found type by new oid", () { 
      var dartlingOid = new Oid.ts(1345648254063); 
      var type = types.singleWhereOid(dartlingOid); 
      expect(type, isNull); 
    }); 
 
    test("Find type by oid", () { 
      var randomType = types.random(); 
      var type = types.singleWhereOid(randomType.oid); 
      expect(type, isNotNull); 
      expect(type, equals(randomType)); 
    }); 
 
    test("Find type by attribute id", () { 
      var randomType = types.random(); 
      var type = 
          types.singleWhereAttributeId("sequence", randomType.sequence); 
      expect(type, isNotNull); 
      expect(type.sequence, equals(randomType.sequence)); 
    }); 
 
    test("Find type by required attribute", () { 
      var randomType = types.random(); 
      var type = 
          types.firstWhereAttribute("title", randomType.title); 
      expect(type, isNotNull); 
      expect(type.title, equals(randomType.title)); 
    }); 
 
    test("Find type by attribute", () { 
      var randomType = types.random(); 
      var type = 
          types.firstWhereAttribute("started", randomType.started); 
      expect(type, isNotNull); 
      expect(type.started, equals(randomType.started)); 
    }); 
 
    test("Select types by attribute", () { 
      var randomType = types.random(); 
      var selectedTypes = 
          types.selectWhereAttribute("started", randomType.started); 
      expect(selectedTypes.isEmpty, isFalse); 
      selectedTypes.forEach((se) => 
          expect(se.started, equals(randomType.started))); 
 
      //selectedTypes.display(title: "Select types by started"); 
    }); 
 
    test("Select types by required attribute", () { 
      var randomType = types.random(); 
      var selectedTypes = 
          types.selectWhereAttribute("title", randomType.title); 
      expect(selectedTypes.isEmpty, isFalse); 
      selectedTypes.forEach((se) => 
          expect(se.title, equals(randomType.title))); 
 
      //selectedTypes.display(title: "Select types by title"); 
    }); 
 
    test("Select types by attribute, then add", () { 
      var randomType = types.random(); 
      var selectedTypes = 
          types.selectWhereAttribute("title", randomType.title); 
      expect(selectedTypes.isEmpty, isFalse); 
      expect(selectedTypes.source.isEmpty, isFalse); 
      var typesCount = types.length; 
 
      var type = new dt.Type(types.concept); 
      type.title = 'enquiry'; 
      type.email = 'rachel@clark.com'; 
      type.started = new DateTime.now(); 
      type.price = 63.4337336551856; 
      type.qty = 629; 
      type.completed = false; 
      type.whatever = 'room'; 
      type.web = Uri.parse('http://fr.slideshare.net/adamnash/personal-finance-for-engineers-twitter-2013'); 
      type.other = 'abstract'; 
      type.note = 'service'; 
      var added = selectedTypes.add(type); 
      expect(added, isTrue); 
      expect(types.length, equals(++typesCount)); 
 
      //selectedTypes.display(title: 
      //  "Select types by attribute, then add"); 
      //types.display(title: "All types"); 
    }); 
 
    test("Select types by attribute, then remove", () { 
      var randomType = types.random(); 
      var selectedTypes = 
          types.selectWhereAttribute("title", randomType.title); 
      expect(selectedTypes.isEmpty, isFalse); 
      expect(selectedTypes.source.isEmpty, isFalse); 
      var typesCount = types.length; 
 
      var removed = selectedTypes.remove(randomType); 
      expect(removed, isTrue); 
      expect(types.length, equals(--typesCount)); 
 
      randomType.display(prefix: "removed"); 
      //selectedTypes.display(title: 
      //  "Select types by attribute, then remove"); 
      //types.display(title: "All types"); 
    }); 
 
    test("Sort types", () { 
      types.sort(); 
 
      //types.display(title: "Sort types"); 
    }); 
 
    test("Order types", () { 
      var orderedTypes = types.order(); 
      expect(orderedTypes.isEmpty, isFalse); 
      expect(orderedTypes.length, equals(types.length)); 
      expect(orderedTypes.source.isEmpty, isFalse); 
      expect(orderedTypes.source.length, equals(types.length)); 
      expect(orderedTypes, isNot(same(types))); 
 
      //orderedTypes.display(title: "Order types"); 
    }); 
 
    test("Copy types", () { 
      var copiedTypes = types.copy(); 
      expect(copiedTypes.isEmpty, isFalse); 
      expect(copiedTypes.length, equals(types.length)); 
      expect(copiedTypes, isNot(same(types))); 
      copiedTypes.forEach((e) => 
        expect(e, equals(types.singleWhereOid(e.oid)))); 
      copiedTypes.forEach((e) => 
        expect(e, isNot(same(types.singleWhereId(e.id))))); 
 
      //copiedTypes.display(title: "Copy types"); 
    }); 
 
    test("True for every type", () { 
      expect(types.every((e) => e.title != null), isTrue); 
    }); 
 
    test("Random type", () { 
      var type1 = types.random(); 
      expect(type1, isNotNull); 
      var type2 = types.random(); 
      expect(type2, isNotNull); 
 
      //type1.display(prefix: "random1"); 
      //type2.display(prefix: "random2"); 
    }); 
 
    test("Update type id with try", () { 
      // id attribute defined as increment, cannot update it 
    }); 
 
    test("Update type id without try", () { 
      // id attribute defined as increment, cannot update it 
    }); 
 
    test("Update type id with success", () { 
      // id attribute defined as increment, cannot update it 
    }); 
 
    test("Update type non id attribute with failure", () { 
      var randomType = types.random(); 
      //var beforeUpdateValue = randomType.title; 
      var afterUpdateEntity = randomType.copy(); 
      afterUpdateEntity.title = 'text'; 
      expect(afterUpdateEntity.title, equals('text')); 
      // types.update can only be used if oid, code or id is set. 
      expect(() => types.update(randomType, afterUpdateEntity), throws); 
    }); 
 
    test("Copy Equality", () { 
      var randomType = types.random(); 
      randomType.display(prefix:"before copy: "); 
      var randomTypeCopy = randomType.copy(); 
      randomTypeCopy.display(prefix:"after copy: "); 
      expect(randomType, equals(randomTypeCopy)); 
      expect(randomType.oid, equals(randomTypeCopy.oid)); 
      expect(randomType.code, equals(randomTypeCopy.code)); 
      expect(randomType.sequence, equals(randomTypeCopy.sequence)); 
      expect(randomType.title, equals(randomTypeCopy.title)); 
      expect(randomType.email, equals(randomTypeCopy.email)); 
      expect(randomType.started, equals(randomTypeCopy.started)); 
      expect(randomType.price, equals(randomTypeCopy.price)); 
      expect(randomType.qty, equals(randomTypeCopy.qty)); 
      expect(randomType.completed, equals(randomTypeCopy.completed)); 
      expect(randomType.whatever, equals(randomTypeCopy.whatever)); 
      expect(randomType.web, equals(randomTypeCopy.web)); 
      expect(randomType.other, equals(randomTypeCopy.other)); 
      expect(randomType.note, equals(randomTypeCopy.note)); 
 
      expect(randomType.id, isNotNull); 
      expect(randomTypeCopy.id, isNotNull); 
      expect(randomType.id, equals(randomTypeCopy.id)); 
 
      var idsEqual = false; 
      if (randomType.id == randomTypeCopy.id) { 
        idsEqual = true; 
      } 
      expect(idsEqual, isTrue); 
 
      idsEqual = false; 
      if (randomType.id.equals(randomTypeCopy.id)) { 
        idsEqual = true; 
      } 
      expect(idsEqual, isTrue); 
    }); 
 
    test("New type action undo and redo", () { 
      var typeCount = types.length; 
          var type = new dt.Type(types.concept); 
      type.title = 'college'; 
      type.email = 'brian@torres.com'; 
      type.started = new DateTime.now(); 
      type.price = 23.809758981643913; 
      type.qty = 458.72941299856217; 
      type.completed = true; 
      type.whatever = 'selfdo'; 
      type.web = Uri.parse('http://internationalliving.com/2013/01/theres-no-such-thing-as-boredom-in-boquete-panama/'); 
      type.other = 'ship'; 
      type.note = 'school'; 
      types.add(type); 
      expect(types.length, equals(++typeCount)); 
      types.remove(type); 
      expect(types.length, equals(--typeCount)); 
 
      var action = new AddAction(session, types, type); 
      action.doit(); 
      expect(types.length, equals(++typeCount)); 
 
      action.undo(); 
      expect(types.length, equals(--typeCount)); 
 
      action.redo(); 
      expect(types.length, equals(++typeCount)); 
    }); 
 
    test("New type session undo and redo", () { 
      var typeCount = types.length; 
          var type = new dt.Type(types.concept); 
      type.title = 'question'; 
      type.email = 'karen@harris.com'; 
      type.started = new DateTime.now(); 
      type.price = 16.983949019456055; 
      type.qty = 236; 
      type.completed = false; 
      type.whatever = 'tape'; 
      type.web = Uri.parse('http://chimera.labs.oreilly.com/books/1234000001654/index.html'); 
      type.other = 'answer'; 
      type.note = 'executive'; 
      types.add(type); 
      expect(types.length, equals(++typeCount)); 
      types.remove(type); 
      expect(types.length, equals(--typeCount)); 
 
      var action = new AddAction(session, types, type); 
      action.doit(); 
      expect(types.length, equals(++typeCount)); 
 
      session.past.undo(); 
      expect(types.length, equals(--typeCount)); 
 
      session.past.redo(); 
      expect(types.length, equals(++typeCount)); 
    }); 
 
    test("Type update undo and redo", () { 
      var type = types.random(); 
      var action = new SetAttributeAction(session, type, "title", 'theme'); 
      action.doit(); 
 
      session.past.undo(); 
      expect(type.title, equals(action.before)); 
 
      session.past.redo(); 
      expect(type.title, equals(action.after)); 
    }); 
 
    test("Type action with multiple undos and redos", () { 
      var typeCount = types.length; 
      var type1 = types.random(); 
 
      var action1 = new RemoveAction(session, types, type1); 
      action1.doit(); 
      expect(types.length, equals(--typeCount)); 
 
      var type2 = types.random(); 
 
      var action2 = new RemoveAction(session, types, type2); 
      action2.doit(); 
      expect(types.length, equals(--typeCount)); 
 
      //session.past.display(); 
 
      session.past.undo(); 
      expect(types.length, equals(++typeCount)); 
 
      session.past.undo(); 
      expect(types.length, equals(++typeCount)); 
 
      //session.past.display(); 
 
      session.past.redo(); 
      expect(types.length, equals(--typeCount)); 
 
      session.past.redo(); 
      expect(types.length, equals(--typeCount)); 
 
      //session.past.display(); 
    }); 
 
    test("Transaction undo and redo", () { 
      var typeCount = types.length; 
      var type1 = types.random(); 
      var type2 = types.random(); 
      while (type1 == type2) { 
        type2 = types.random();  
      } 
      var action1 = new RemoveAction(session, types, type1); 
      var action2 = new RemoveAction(session, types, type2); 
 
      var transaction = new Transaction("two removes on types", session); 
      transaction.add(action1); 
      transaction.add(action2); 
      transaction.doit(); 
      typeCount = typeCount - 2; 
      expect(types.length, equals(typeCount)); 
 
      types.display(title:"Transaction Done"); 
 
      session.past.undo(); 
      typeCount = typeCount + 2; 
      expect(types.length, equals(typeCount)); 
 
      types.display(title:"Transaction Undone"); 
 
      session.past.redo(); 
      typeCount = typeCount - 2; 
      expect(types.length, equals(typeCount)); 
 
      types.display(title:"Transaction Redone"); 
    }); 
 
    test("Transaction with one action error", () { 
      var typeCount = types.length; 
      var type1 = types.random(); 
      var type2 = type1; 
      var action1 = new RemoveAction(session, types, type1); 
      var action2 = new RemoveAction(session, types, type2); 
 
      var transaction = new Transaction( 
        "two removes on types, with an error on the second", session); 
      transaction.add(action1); 
      transaction.add(action2); 
      var done = transaction.doit(); 
      expect(done, isFalse); 
      expect(types.length, equals(typeCount)); 
 
      //types.display(title:"Transaction with an error"); 
    }); 
 
    test("Reactions to type actions", () {  
      var typeCount = types.length; 
 
      var reaction = new TypeReaction(); 
      expect(reaction, isNotNull); 
 
      dartlingDomain.startActionReaction(reaction); 
          var type = new dt.Type(types.concept); 
      type.title = 'tent'; 
      type.email = 'patrick@smith.com'; 
      type.started = new DateTime.now(); 
      type.price = 75.45793235956197; 
      type.qty = 294.0646204769207; 
      type.completed = false; 
      type.whatever = 'privacy'; 
      type.web = Uri.parse('http://tinyhouseblog.com/yurts/tiny-spiritual-retreat-cabins/'); 
      type.other = 'do'; 
      type.note = 'pattern'; 
      types.add(type); 
      expect(types.length, equals(++typeCount)); 
      types.remove(type); 
      expect(types.length, equals(--typeCount)); 
 
      var session = dartlingDomain.newSession(); 
      var addAction = new AddAction(session, types, type); 
      addAction.doit(); 
      expect(types.length, equals(++typeCount)); 
      expect(reaction.reactedOnAdd, isTrue); 
 
      var setAttributeAction = new SetAttributeAction( 
        session, type, "title", 'message'); 
      setAttributeAction.doit(); 
      expect(reaction.reactedOnUpdate, isTrue); 
      dartlingDomain.cancelActionReaction(reaction); 
    }); 
 
  }); 
} 
 
class TypeReaction implements ActionReactionApi { 
  bool reactedOnAdd    = false; 
  bool reactedOnUpdate = false; 
 
  void react(BasicAction action) { 
    if (action is EntitiesAction) { 
      reactedOnAdd = true; 
    } else if (action is EntityAction) { 
      reactedOnUpdate = true; 
    } 
  } 
} 
 
void main() { 
  var repository = new dt.Repository(); 
  var dartlingDomain = repository.getDomainModels("Dartling");   
  assert(dartlingDomain != null); 
  var typesModel = dartlingDomain.getModelEntries("Types");  
  assert(typesModel != null); 
  var types = typesModel.types; 
  testDartlingTypesTypes(dartlingDomain, typesModel, types); 
} 
 

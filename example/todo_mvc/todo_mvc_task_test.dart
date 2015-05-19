import "package:test/test.dart";
import "package:dartling/dartling.dart"; 
import 'todo_mvc.dart';
 
void testTodoMvcTasks( 
    TodoDomain todoDomain, MvcModel mvcModel, Tasks tasks) { 
  DomainSession session; 
  group("Testing Todo.Mvc.Task", () { 
    session = todoDomain.newSession();   
    setUp(() { 
      mvcModel.init(); 
    }); 
    tearDown(() { 
      mvcModel.clear(); 
    }); 
 
    test("Not empty model", () { 
      expect(mvcModel.isEmpty, isFalse); 
      expect(tasks.isEmpty, isFalse); 
    }); 
 
    test("Empty model", () { 
      mvcModel.clear(); 
      expect(mvcModel.isEmpty, isTrue); 
      expect(tasks.isEmpty, isTrue); 
      expect(tasks.exceptions.isEmpty, isTrue); 
    }); 
 
    test("From model to JSON", () { 
      var json = mvcModel.toJson(); 
      expect(json, isNotNull); 
 
      print(json); 
      //mvcModel.displayJson(); 
      //mvcModel.display(); 
    }); 
 
    test("From JSON to model", () { 
      var json = mvcModel.toJson(); 
      mvcModel.clear(); 
      expect(mvcModel.isEmpty, isTrue); 
      mvcModel.fromJson(json); 
      expect(mvcModel.isEmpty, isFalse); 
 
      mvcModel.display(); 
    }); 
 
    test("From model entry to JSON", () { 
      var json = mvcModel.fromEntryToJson("Task"); 
      expect(json, isNotNull); 
 
      print(json); 
      //mvcModel.displayEntryJson("Task"); 
      //mvcModel.displayJson(); 
      //mvcModel.display(); 
    }); 
 
    test("From JSON to model entry", () { 
      var json = mvcModel.fromEntryToJson("Task"); 
      tasks.clear(); 
      expect(tasks.isEmpty, isTrue); 
      mvcModel.fromJsonToEntry(json); 
      expect(tasks.isEmpty, isFalse); 
 
      tasks.display(title: "From JSON to model entry"); 
    }); 
 
    test("Add task required error", () { 
      var taskConcept = tasks.concept; 
      var taskCount = tasks.length; 
      var task = new Task(taskConcept); 
      var added = tasks.add(task); 
      expect(added, isFalse); 
      expect(tasks.length, equals(taskCount)); 
      expect(tasks.exceptions.length, greaterThan(0)); 
      expect(tasks.exceptions.toList()[0].category, equals("required")); 
 
      tasks.exceptions.display(title: "Add task required error"); 
    }); 
 
    test("Add task unique error", () { 
      var taskConcept = tasks.concept; 
      var taskCount = tasks.length; 
      var task = new Task(taskConcept); 
      var randomTask = tasks.random(); 
      task.title = randomTask.title; 
      var added = tasks.add(task); 
      expect(added, isFalse); 
      expect(tasks.length, equals(taskCount)); 
      expect(tasks.exceptions.length, greaterThan(0)); 
 
      tasks.exceptions.display(title: "Add task unique error"); 
    }); 
 
    test("Not found task by new oid", () { 
      var dartlingOid = new Oid.ts(1345648254063); 
      var task = tasks.singleWhereOid(dartlingOid); 
      expect(task, isNull); 
    }); 
 
    test("Find task by oid", () { 
      var randomTask = tasks.random(); 
      var task = tasks.singleWhereOid(randomTask.oid); 
      expect(task, isNotNull); 
      expect(task, equals(randomTask)); 
    }); 
 
    test("Find task by attribute id", () { 
      var randomTask = tasks.random(); 
      var task = 
          tasks.singleWhereAttributeId("title", randomTask.title); 
      expect(task, isNotNull); 
      expect(task.title, equals(randomTask.title)); 
    }); 
 
    test("Find task by required attribute", () { 
      var randomTask = tasks.random(); 
      var task = 
          tasks.firstWhereAttribute("completed", randomTask.completed); 
      expect(task, isNotNull); 
      expect(task.completed, equals(randomTask.completed)); 
    }); 
 
    test("Find task by attribute", () { 
      // no attribute that is not required 
    }); 
 
    test("Select tasks by attribute", () { 
      // no attribute that is not required 
    }); 
 
    test("Select tasks by required attribute", () { 
      var randomTask = tasks.random(); 
      var selectedTasks = 
          tasks.selectWhereAttribute("completed", randomTask.completed); 
      expect(selectedTasks.isEmpty, isFalse); 
      selectedTasks.forEach((se) => 
          expect(se.completed, equals(randomTask.completed))); 
 
      //selectedTasks.display(title: "Select tasks by completed"); 
    }); 
 
    test("Select tasks by attribute, then add", () { 
      var randomTask = tasks.random(); 
      var selectedTasks = 
          tasks.selectWhereAttribute("completed", randomTask.completed); 
      expect(selectedTasks.isEmpty, isFalse); 
      expect(selectedTasks.source.isEmpty, isFalse); 
      var tasksCount = tasks.length; 
 
      var task = new Task(tasks.concept); 
      task.title = 'cardboard'; 
      task.completed = true; 
      var added = selectedTasks.add(task); 
      expect(added, isTrue); 
      expect(tasks.length, equals(++tasksCount)); 
 
      //selectedTasks.display(title: 
      //  "Select tasks by attribute, then add"); 
      //tasks.display(title: "All tasks"); 
    }); 
 
    test("Select tasks by attribute, then remove", () { 
      var randomTask = tasks.random(); 
      var selectedTasks = 
          tasks.selectWhereAttribute("completed", randomTask.completed); 
      expect(selectedTasks.isEmpty, isFalse); 
      expect(selectedTasks.source.isEmpty, isFalse); 
      var tasksCount = tasks.length; 
 
      var removed = selectedTasks.remove(randomTask); 
      expect(removed, isTrue); 
      expect(tasks.length, equals(--tasksCount)); 
 
      randomTask.display(prefix: "removed"); 
      //selectedTasks.display(title: 
      //  "Select tasks by attribute, then remove"); 
      //tasks.display(title: "All tasks"); 
    }); 
 
    test("Sort tasks", () { 
      tasks.sort(); 
 
      //tasks.display(title: "Sort tasks"); 
    }); 
 
    test("Order tasks", () { 
      var orderedTasks = tasks.order(); 
      expect(orderedTasks.isEmpty, isFalse); 
      expect(orderedTasks.length, equals(tasks.length)); 
      expect(orderedTasks.source.isEmpty, isFalse); 
      expect(orderedTasks.source.length, equals(tasks.length)); 
      expect(orderedTasks, isNot(same(tasks))); 
 
      //orderedTasks.display(title: "Order tasks"); 
    }); 
 
    test("Copy tasks", () { 
      var copiedTasks = tasks.copy(); 
      expect(copiedTasks.isEmpty, isFalse); 
      expect(copiedTasks.length, equals(tasks.length)); 
      expect(copiedTasks, isNot(same(tasks))); 
      copiedTasks.forEach((e) => 
        expect(e, equals(tasks.singleWhereOid(e.oid)))); 
      copiedTasks.forEach((e) => 
        expect(e, isNot(same(tasks.singleWhereId(e.id))))); 
 
      //copiedTasks.display(title: "Copy tasks"); 
    }); 
 
    test("True for every task", () { 
      expect(tasks.every((e) => e.completed != null), isTrue); 
    }); 
 
    test("Random task", () { 
      var task1 = tasks.random(); 
      expect(task1, isNotNull); 
      var task2 = tasks.random(); 
      expect(task2, isNotNull); 
 
      //task1.display(prefix: "random1"); 
      //task2.display(prefix: "random2"); 
    }); 
 
    test("Update task id with try", () { 
      var randomTask = tasks.random(); 
      var beforeUpdate = randomTask.title; 
      try { 
        randomTask.title = 'heating'; 
      } on UpdateException catch (e) { 
        expect(randomTask.title, equals(beforeUpdate)); 
      } 
    }); 
 
    test("Update task id without try", () { 
      var randomTask = tasks.random(); 
      var beforeUpdateValue = randomTask.title; 
      expect(() => randomTask.title = 'right', throws); 
      expect(randomTask.title, equals(beforeUpdateValue)); 
    }); 
 
    test("Update task id with success", () { 
      var randomTask = tasks.random(); 
      var afterUpdateEntity = randomTask.copy(); 
      var attribute = randomTask.concept.attributes.singleWhereCode("title"); 
      expect(attribute.update, isFalse); 
      attribute.update = true; 
      afterUpdateEntity.title = 'camping'; 
      expect(afterUpdateEntity.title, equals('camping')); 
      attribute.update = false; 
      var updated = tasks.update(randomTask, afterUpdateEntity); 
      expect(updated, isTrue); 
 
      var entity = tasks.singleWhereAttributeId("title", 'camping'); 
      expect(entity, isNotNull); 
      expect(entity.title, equals('camping')); 
 
      //tasks.display("After update task id"); 
    }); 
 
    test("Update task non id attribute with failure", () { 
      var randomTask = tasks.random(); 
      //var beforeUpdateValue = randomTask.completed; 
      var afterUpdateEntity = randomTask.copy(); 
      afterUpdateEntity.completed = false; 
      expect(afterUpdateEntity.completed, equals(false)); 
      // tasks.update can only be used if oid, code or id is set. 
      expect(() => tasks.update(randomTask, afterUpdateEntity), throws); 
    }); 
 
    test("Copy Equality", () { 
      var randomTask = tasks.random(); 
      randomTask.display(prefix:"before copy: "); 
      var randomTaskCopy = randomTask.copy(); 
      randomTaskCopy.display(prefix:"after copy: "); 
      expect(randomTask, equals(randomTaskCopy)); 
      expect(randomTask.oid, equals(randomTaskCopy.oid)); 
      expect(randomTask.code, equals(randomTaskCopy.code)); 
      expect(randomTask.title, equals(randomTaskCopy.title)); 
      expect(randomTask.completed, equals(randomTaskCopy.completed)); 
 
      expect(randomTask.id, isNotNull); 
      expect(randomTaskCopy.id, isNotNull); 
      expect(randomTask.id, equals(randomTaskCopy.id)); 
 
      var idsEqual = false; 
      if (randomTask.id == randomTaskCopy.id) { 
        idsEqual = true; 
      } 
      expect(idsEqual, isTrue); 
 
      idsEqual = false; 
      if (randomTask.id.equals(randomTaskCopy.id)) { 
        idsEqual = true; 
      } 
      expect(idsEqual, isTrue); 
    }); 
 
    test("New task action undo and redo", () {  
      var taskCount = tasks.length; 
          var task = new Task(tasks.concept); 
      task.title = 'tree'; 
      task.completed = false; 
      tasks.add(task); 
      expect(tasks.length, equals(++taskCount)); 
      tasks.remove(task); 
      expect(tasks.length, equals(--taskCount)); 
 
      var action = new AddAction(session, tasks, task); 
      action.doit(); 
      expect(tasks.length, equals(++taskCount)); 
 
      action.undo(); 
      expect(tasks.length, equals(--taskCount)); 
 
      action.redo(); 
      expect(tasks.length, equals(++taskCount)); 
    }); 
 
    test("New task session undo and redo", () {  
      var taskCount = tasks.length; 
          var task = new Task(tasks.concept); 
      task.title = 'vessel'; 
      task.completed = true; 
      tasks.add(task); 
      expect(tasks.length, equals(++taskCount)); 
      tasks.remove(task); 
      expect(tasks.length, equals(--taskCount)); 
 
      var action = new AddAction(session, tasks, task); 
      action.doit(); 
      expect(tasks.length, equals(++taskCount)); 
 
      session.past.undo(); 
      expect(tasks.length, equals(--taskCount)); 
 
      session.past.redo(); 
      expect(tasks.length, equals(++taskCount)); 
    }); 
 
    test("Task update undo and redo", () { 
      var task = tasks.random(); 
      var action = new SetAttributeAction(session, task, "completed", false); 
      action.doit(); 
 
      session.past.undo(); 
      expect(task.completed, equals(action.before)); 
 
      session.past.redo(); 
      expect(task.completed, equals(action.after)); 
    }); 
 
    test("Task action with multiple undos and redos", () { 
      var taskCount = tasks.length; 
      var task1 = tasks.random(); 
 
      var action1 = new RemoveAction(session, tasks, task1); 
      action1.doit(); 
      expect(tasks.length, equals(--taskCount)); 
 
      var task2 = tasks.random(); 
 
      var action2 = new RemoveAction(session, tasks, task2); 
      action2.doit(); 
      expect(tasks.length, equals(--taskCount)); 
 
      //session.past.display(); 
 
      session.past.undo(); 
      expect(tasks.length, equals(++taskCount)); 
 
      session.past.undo(); 
      expect(tasks.length, equals(++taskCount)); 
 
      //session.past.display(); 
 
      session.past.redo(); 
      expect(tasks.length, equals(--taskCount)); 
 
      session.past.redo(); 
      expect(tasks.length, equals(--taskCount)); 
 
      //session.past.display(); 
    }); 
 
    test("Transaction undo and redo", () { 
      var taskCount = tasks.length; 
      var task1 = tasks.random(); 
      var task2 = tasks.random(); 
      while (task1 == task2) { 
        task2 = tasks.random();  
      } 
      var action1 = new RemoveAction(session, tasks, task1); 
      var action2 = new RemoveAction(session, tasks, task2); 
 
      var transaction = new Transaction("two removes on tasks", session); 
      transaction.add(action1); 
      transaction.add(action2); 
      transaction.doit(); 
      taskCount = taskCount - 2; 
      expect(tasks.length, equals(taskCount)); 
 
      tasks.display(title:"Transaction Done"); 
 
      session.past.undo(); 
      taskCount = taskCount + 2; 
      expect(tasks.length, equals(taskCount)); 
 
      tasks.display(title:"Transaction Undone"); 
 
      session.past.redo(); 
      taskCount = taskCount - 2; 
      expect(tasks.length, equals(taskCount)); 
 
      tasks.display(title:"Transaction Redone"); 
    }); 
 
    test("Transaction with one action error", () { 
      var taskCount = tasks.length; 
      var task1 = tasks.random(); 
      var task2 = task1; 
      var action1 = new RemoveAction(session, tasks, task1); 
      var action2 = new RemoveAction(session, tasks, task2); 
 
      var transaction = new Transaction( 
        "two removes on tasks, with an error on the second", session); 
      transaction.add(action1); 
      transaction.add(action2); 
      var done = transaction.doit(); 
      expect(done, isFalse); 
      expect(tasks.length, equals(taskCount)); 
 
      //tasks.display(title:"Transaction with an error"); 
    }); 
 
    test("Reactions to task actions", () {  
      var taskCount = tasks.length; 
 
      var reaction = new TaskReaction(); 
      expect(reaction, isNotNull); 
 
      todoDomain.startActionReaction(reaction); 
          var task = new Task(tasks.concept); 
      task.title = 'vessel'; 
      task.completed = true;  
      tasks.add(task); 
      expect(tasks.length, equals(++taskCount)); 
      tasks.remove(task); 
      expect(tasks.length, equals(--taskCount)); 
 
      var session = todoDomain.newSession(); 
      var addAction = new AddAction(session, tasks, task); 
      addAction.doit(); 
      expect(tasks.length, equals(++taskCount)); 
      expect(reaction.reactedOnAdd, isTrue); 
 
      var setAttributeAction = new SetAttributeAction( 
        session, task, "completed", false); 
      setAttributeAction.doit(); 
      expect(reaction.reactedOnUpdate, isTrue); 
      todoDomain.cancelActionReaction(reaction); 
    }); 
 
  }); 
} 
 
class TaskReaction implements ActionReactionApi { 
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
  var repository = new Repository(); 
  var todoDomain = repository.getDomainModels("Todo");   
  assert(todoDomain != null); 
  var mvcModel = todoDomain.getModelEntries("Mvc");  
  assert(mvcModel != null); 
  var tasks = mvcModel.tasks; 
  testTodoMvcTasks(todoDomain, mvcModel, tasks); 
} 
 

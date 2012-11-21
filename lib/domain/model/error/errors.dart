part of dartling;

abstract class ErrorsApi {

  int get count;
  List<EntityError> get list;  add(EntityError error);
  clear();

}

//class Error extends Entity<Error> { // conflict with dart:html Entity

/*
Running dart2js...
../lib/core/errors.dart:5:1: duplicate definition
class Error {
^^^^^
Error: Compilation failed.
 */
class EntityError {

  String category;
  String message;

  EntityError(this.category);

  /**
   * Returns a string that represents the error.
   */
  String toString() {
    return '${category}: ${message}';
  }

  /**
   * Displays (prints) an error.
   */
  display({String prefix:''}) {
    print('${prefix}******************************************');
    print('${prefix}${category}                               ');
    print('${prefix}******************************************');
    print('${prefix}message: ${message}');
    print('${prefix}******************************************');
    print('');
  }

}

class EntityErrors implements ErrorsApi {

  List<EntityError> _errorList;

  EntityErrors() {
    _errorList = new List<EntityError>();
  }

  int get count => _errorList.length;
  int get length => count;

  List<EntityError> get list => _errorList;

  add(EntityError error) {
    _errorList.add(error);
  }

  clear() {
    _errorList.clear();
  }

  Iterator<EntityError> iterator() => _errorList.iterator();

  /**
   * Returns a string that represents the errors.
   */
  String toString() {
    var msgs = '';
    for (var error in this) {
      msgs = '${error.toString()} \n${msgs}';
    }
    return msgs;
  }

  /**
   * Displays (prints) a title, then errors.
   */
  display({String title:'Entities', bool withOid:true}) {
    if (title == 'Entities') {
      title = 'Errors';
    }
    print('');
    print('************************************************');
    print('$title                                          ');
    print('************************************************');
    print('');
    for (EntityError error in _errorList) {
      error.display(prefix:'*** ');
    }
  }

}

class DartlingError implements Error {

  final String msg;

  const DartlingError(this.msg);

  toString() => '*** $msg ***';

}

class ActionError extends DartlingError {

  const ActionError(String msg) : super(msg);

}

class AddError extends ActionError {

  const AddError(String msg) : super(msg);

}

class CodeError extends DartlingError {

  const CodeError(String msg) : super(msg);

}

class ConceptError extends DartlingError {

  const ConceptError(String msg) : super(msg);

}

class IdError extends DartlingError {

  const IdError(String msg) : super(msg);

}

class JsonError extends DartlingError {

  const JsonError(String msg) : super(msg);

}

class OidError extends DartlingError {

  const OidError(String msg) : super(msg);

}

class OrderError extends DartlingError {

  const OrderError(String msg) : super(msg);

}

class ParentError extends DartlingError {

  const ParentError(String msg) : super(msg);

}

class RemoveError extends ActionError {

  const RemoveError(String msg) : super(msg);

}

class TypeError extends DartlingError {

  const TypeError(String msg) : super(msg);

}

class UpdateError extends ActionError {

  const UpdateError(String msg) : super(msg);

}




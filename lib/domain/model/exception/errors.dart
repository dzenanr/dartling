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

class Errors implements ErrorsApi {

  List<EntityError> _errorList;

  Errors() {
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





abstract class ErrorsApi {

  abstract int get count;
  abstract List<EntityError> get list;  abstract add(EntityError error);
  abstract clear();

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
   * Displays (prints) an error.
   */
  display([String s='']) {
    print('${s}******************************************');
    print('${s}${category}                               ');
    print('${s}******************************************');
    print('${s}message: ${message}');
    print('${s}******************************************');
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

  /**
   * Displays (prints) a title, then errors.
   */
  display([String title='Entities', bool withOid=true]) {
    if (title == 'Entities') {
      title = 'Errors';
    }
    print('');
    print('************************************************');
    print('$title                                          ');
    print('************************************************');
    print('');
    for (EntityError error in _errorList) {
      error.display('*** ');
    }
  }

}




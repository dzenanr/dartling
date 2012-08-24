
abstract class ErrorsApi {

  abstract int get count();
  abstract List<Error> get list();
  abstract add(Error error);
  abstract clear();

}

//class Error extends Entity<Error> {
class Error {

  String category;
  String message;

  Error(this.category);

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

  List<Error> _errorList;

  Errors() {
    _errorList = new List<Error>();
  }

  int get count() => _errorList.length;
  int get length() => count;

  List<Error> get list() => _errorList;

  add(Error error) {
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
    for (Error error in _errorList) {
      error.display('*** ');
    }
  }

}




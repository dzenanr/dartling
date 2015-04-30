part of dartling;

abstract class ValidationErrorsApi {

  int get length;
  void add(ValidationError error);
  void clear();
  List<ValidationError> toList();

}

class ValidationError {

  String category;
  String message;

  ValidationError(this.category);

  /**
   * Returns a string that represents the error.
   */
  String toString() {
    return '${category}: ${message}';
  }

  /**
   * Displays (prints) an error.
   */
  void display({String prefix:''}) {
    print('${prefix}******************************************');
    print('${prefix}${category}                               ');
    print('${prefix}******************************************');
    print('${prefix}message: ${message}');
    print('${prefix}******************************************');
    print('');
  }

}

class ValidationErrors implements ValidationErrorsApi {

  List<ValidationError> _errorList;

  ValidationErrors() {
    _errorList = new List<ValidationError>();
  }

  int get length => _errorList.length;
  bool get isEmpty => length == 0;
  Iterator<ValidationError> get iterator => _errorList.iterator;

  void add(ValidationError error) {
    _errorList.add(error);
  }

  void clear() {
    _errorList.clear();
  }

  List<ValidationError> toList() => _errorList.toList();

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
  void display({String title:'Entities', bool withOid:true}) {
    if (title == 'Entities') {
      title = 'Errors';
    }
    print('');
    print('************************************************');
    print('$title                                          ');
    print('************************************************');
    print('');
    for (ValidationError error in _errorList) {
      error.display(prefix:'*** ');
    }
  }

}
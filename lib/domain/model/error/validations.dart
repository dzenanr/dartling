part of dartling;

abstract class ValidationExceptionsApi {

  int get length;
  void add(ValidationException exception);
  void clear();
  List<ValidationException> toList();

}

class ValidationException implements Exception {

  String category;
  String message;

  ValidationException(this.category);

  /**
   * Returns a string that represents the error.
   */
  String toString() {
    return '${category}: ${message}';
  }

  /**
   * Displays (prints) an exception.
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

class ValidationExceptions implements ValidationExceptionsApi {

  List<ValidationException> _exceptionList;

  ValidationExceptions() {
    _exceptionList = new List<ValidationException>();
  }

  int get length => _exceptionList.length;
  bool get isEmpty => length == 0;
  Iterator<ValidationException> get iterator => _exceptionList.iterator;

  void add(ValidationException exception) {
    _exceptionList.add(exception);
  }

  void clear() {
    _exceptionList.clear();
  }

  List<ValidationException> toList() => _exceptionList.toList();

  /**
   * Returns a string that represents the exceptions.
   */
  String toString() {
    var messages = '';
    for (var exception in this) {
      messages = '${exception.toString()} \n${messages}';
    }
    return messages;
  }

  /**
   * Displays (prints) a title, then exceptions.
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
    for (ValidationException exception in _exceptionList) {
      exception.display(prefix:'*** ');
    }
  }

}
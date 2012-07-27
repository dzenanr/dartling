
class DartlingException implements Exception {

  final String msg;

  const DartlingException(this.msg);

  toString() => msg;

}


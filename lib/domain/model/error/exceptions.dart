part of dartling;

class DartlingException implements Exception {

  final String msg;

  DartlingException(this.msg);

  toString() => '*** $msg ***';

}

class ActionException extends DartlingException {

  ActionException(String msg) : super(msg);

}

class AddException extends ActionException {

  AddException(String msg) : super(msg);

}

class CodeException extends DartlingException {

  CodeException(String msg) : super(msg);

}

class ConceptException extends DartlingException {

  ConceptException(String msg) : super(msg);

}

class IdException extends DartlingException {

  IdException(String msg) : super(msg);

}

class JsonException extends DartlingException {

  JsonException(String msg) : super(msg);

}

class OidException extends DartlingException {

  OidException(String msg) : super(msg);

}

class OrderException extends DartlingException {

  OrderException(String msg) : super(msg);

}

class ParentException extends DartlingException {

  ParentException(String msg) : super(msg);

}

class RemoveException extends ActionException {

  RemoveException(String msg) : super(msg);

}

class TypeException extends DartlingException {

  TypeException(String msg) : super(msg);

}

class UpdateException extends ActionException {

  UpdateException(String msg) : super(msg);

}




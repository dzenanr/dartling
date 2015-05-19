part of dartling;

class DartlingException implements Exception {

  final String message;

  DartlingException(this.message);

  toString() => '*** $message ***';

}

class ActionException extends DartlingException {

  ActionException(String message) : super(message);

}

class AddException extends ActionException {

  AddException(String message) : super(message);

}

class CodeException extends DartlingException {

  CodeException(String message) : super(message);

}

class ConceptException extends DartlingException {

  ConceptException(String message) : super(message);

}

class IdException extends DartlingException {

  IdException(String message) : super(message);

}

class JsonException extends DartlingException {

  JsonException(String message) : super(message);

}

class OidException extends DartlingException {

  OidException(String message) : super(message);

}

class OrderException extends DartlingException {

  OrderException(String message) : super(message);

}

class ParentException extends DartlingException {

  ParentException(String message) : super(message);

}

class RemoveException extends ActionException {

  RemoveException(String message) : super(message);

}

class TypeException extends DartlingException {

  TypeException(String message) : super(message);

}

class UpdateException extends ActionException {

  UpdateException(String message) : super(message);

}




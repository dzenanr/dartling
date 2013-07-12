part of dartling;

class DartlingError extends Error {

  final String msg;

  DartlingError(this.msg);

  toString() => '*** $msg ***';

}

class ActionError extends DartlingError {

  ActionError(String msg) : super(msg);

}

class AddError extends ActionError {

  AddError(String msg) : super(msg);

}

class CodeError extends DartlingError {

  CodeError(String msg) : super(msg);

}

class ConceptError extends DartlingError {

  ConceptError(String msg) : super(msg);

}

class IdError extends DartlingError {

  IdError(String msg) : super(msg);

}

class JsonError extends DartlingError {

  JsonError(String msg) : super(msg);

}

class OidError extends DartlingError {

  OidError(String msg) : super(msg);

}

class OrderError extends DartlingError {

  OrderError(String msg) : super(msg);

}

class ParentError extends DartlingError {

  ParentError(String msg) : super(msg);

}

class RemoveError extends ActionError {

  RemoveError(String msg) : super(msg);

}

class TypeError extends DartlingError {

  TypeError(String msg) : super(msg);

}

class UpdateError extends ActionError {

  UpdateError(String msg) : super(msg);

}




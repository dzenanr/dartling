part of dartling;

class DartlingError extends Error {

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




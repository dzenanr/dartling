
class DartlingException implements Exception {

  final String msg;

  const DartlingException(this.msg);

  toString() => '*** $msg ***';

}

class ActionException extends DartlingException {

  const ActionException(String msg) : super(msg);

}

class AddException extends ActionException {

  const AddException(String msg) : super(msg);

}

class CodeException extends DartlingException {

  const CodeException(String msg) : super(msg);

}

class ConceptException extends DartlingException {

  const ConceptException(String msg) : super(msg);

}

class IdException extends DartlingException {

  const IdException(String msg) : super(msg);

}

class JsonException extends DartlingException {

  const JsonException(String msg) : super(msg);

}

class OrderException extends DartlingException {

  const OrderException(String msg) : super(msg);

}

class ParentException extends DartlingException {

  const ParentException(String msg) : super(msg);

}

class RemoveException extends ActionException {

  const RemoveException(String msg) : super(msg);

}

class TypeException extends DartlingException {

  const TypeException(String msg) : super(msg);

}

class UpdateException extends ActionException {

  const UpdateException(String msg) : super(msg);

}



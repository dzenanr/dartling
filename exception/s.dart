
class DartlingException implements Exception {

  final String msg;

  const DartlingException(this.msg);

  toString() => '*** $msg ***';

}

class AddException extends DartlingException {

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

class OrderException extends DartlingException {

  const OrderException(String msg) : super(msg);

}

class RemoveException extends DartlingException {

  const RemoveException(String msg) : super(msg);

}

class TypeException extends DartlingException {

  const TypeException(String msg) : super(msg);

}

class UpdateException extends DartlingException {

  const UpdateException(String msg) : super(msg);

}



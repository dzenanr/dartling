part of dartling;

class EntityException implements Exception {

  final String msg;

  const EntityException(this.msg);

  toString() => '*** $msg ***';

}

class ActionException extends EntityException {

  const ActionException(String msg) : super(msg);

}

class AddException extends ActionException {

  const AddException(String msg) : super(msg);

}

class CodeException extends EntityException {

  const CodeException(String msg) : super(msg);

}

class ConceptException extends EntityException {

  const ConceptException(String msg) : super(msg);

}

class IdException extends EntityException {

  const IdException(String msg) : super(msg);

}

class JsonException extends EntityException {

  const JsonException(String msg) : super(msg);

}

class OidException extends EntityException {

  const OidException(String msg) : super(msg);

}

class OrderException extends EntityException {

  const OrderException(String msg) : super(msg);

}

class ParentException extends EntityException {

  const ParentException(String msg) : super(msg);

}

class RemoveException extends ActionException {

  const RemoveException(String msg) : super(msg);

}

class TypeException extends EntityException {

  const TypeException(String msg) : super(msg);

}

class UpdateException extends ActionException {

  const UpdateException(String msg) : super(msg);

}



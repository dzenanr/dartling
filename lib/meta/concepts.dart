part of dartling;

class Concepts extends Entities<Concept> {

}

class Concept extends ConceptEntity<Concept> {

  bool entry = true;
  bool abstract = false;

  String min = '0';
  String max = 'N';

  bool updateOid = false;
  bool updateCode = false;
  bool add = true;
  bool remove = true;
  String description;
  
  // to allow for a specific plural name, different from
  // the plural name derivation in ConceptEntity
  String _codes; // code (in) plural
  String _codesFirstLetterLower;
  String _codesLowerUnderscore; // lower letters and undescore separator
  String label;
  String labels;

  Model model;

  Attributes attributes;
  Parents parents; // destination parent neighbors
  Children children; // destination child neighbors

  Parents sourceParents;
  Children sourceChildren;

  Concept(this.model, String conceptCode) {
    code = conceptCode;
    model.concepts.add(this);

    attributes = new Attributes();

    parents = new Parents();
    children = new Children();

    sourceParents = new Parents();
    sourceChildren = new Children();
  }
  
  set code(String code) {
    super.code = code;
    if (label == null) {
      label = camelCaseSeparator(code, ' ');
    }
    if (labels == null) {
      labels = camelCaseSeparator(codes, ' ');
    }
  }
  
  int get hashCode => _oid.hashCode;
  
  /**
  * Two concepts are equal if their oids are equal.
  */
  bool equals(Concept concept) {
    if (_oid.equals(concept.oid)) {
      return true;
    }
    return false;
  }
  
  /**
   * == see:
   * https://www.dartlang.org/docs/dart-up-and-running/contents/ch02.html#op-equality
   *
   * Evolution:
   *
   * If x===y, return true.
   * Otherwise, if either x or y is null, return false.
   * Otherwise, return the result of x.equals(y).
   *
   * The newest spec is:
   * a) if either x or y is null, do identical(x, y)
   * b) otherwise call operator ==
   */
  bool operator ==(Object other) {
    if (other is Concept) {
      Concept concept = other;
      if (identical(this, concept)) {
        return true;
      } else {
        if (this == null || concept == null) {
          return false;
        } else {
          return equals(concept);
        }
      }
    } else {
      return false;
    }
  }

  String get codes {
    if (_codes == null) {
      _codes = plural(_code);
    }
    return _codes;
  }
  void set codes(String codes) {
    _codes = codes;
  }

  String get codesFirstLetterLower {
    if (_codesFirstLetterLower == null) {
      _codesFirstLetterLower = firstLetterLower(codes);
    }
    return _codesFirstLetterLower;
  }
  void set codesFirstLetterLower(String codesFirstLetterLower) {
    _codesFirstLetterLower = codesFirstLetterLower;
  }

  String get codesLowerUnderscore {
    if (_codesLowerUnderscore == null) {
      _codesLowerUnderscore = camelCaseLowerSeparator(codes, '_');
    }
    return _codesLowerUnderscore;
  }
  void set codesLowerUnderscore(String codesLowerUnderscore) {
    _codesLowerUnderscore = codesLowerUnderscore;
  }

  Attribute getAttribute(String attributeCode) =>
      attributes.singleWhereCode(attributeCode);

  Parent getDestinationParent(String parentCode) =>
      parents.singleWhereCode(parentCode);
  Child getDestinationChild(String childCode) =>
      children.singleWhereCode(childCode);

  Parent getSourceParent(String parentCode) =>
      sourceParents.singleWhereCode(parentCode);
  Child getSourceChild(String childCode) =>
      sourceChildren.singleWhereCode(childCode);

  List<Attribute> get requiredAttributes {
    var requiredList= new List<Attribute>();
    for (Attribute attribute in attributes) {
      if (attribute.required) {
        requiredList.add(attribute);
      }
    }
    return requiredList;
  }
  
  List<Attribute> get identifierAttributes {
    var identifierList= new List<Attribute>();
    for (Attribute attribute in attributes) {
      if (attribute.identifier) {
        identifierList.add(attribute);
      }
    }
    return identifierList;
  }
  
  List<Attribute> get nonIdentifierAttributes {
    var nonIdentifierList= new List<Attribute>();
    for (Attribute attribute in attributes) {
      if (!attribute.identifier) {
        nonIdentifierList.add(attribute);
      }
    }
    return nonIdentifierList;
  }
  
  List<Attribute> get incrementAttributes {
    var incrementList= new List<Attribute>();
    for (Attribute attribute in attributes) {
      if (attribute.increment != null) {
        incrementList.add(attribute);
      }
    }
    return incrementList;
  }
  
  List<Attribute> get nonIncrementAttributes {
    var nonIncrementList= new List<Attribute>();
    for (Attribute attribute in attributes) {
      if (attribute.increment == null) {
        nonIncrementList.add(attribute);
      }
    }
    return nonIncrementList;
  }
  
  List<Attribute> get essentialAttributes {
    var essentialList= new List<Attribute>();
    for (Attribute attribute in attributes) {
      if (attribute.essential) {
        essentialList.add(attribute);
      }
    }
    return essentialList;
  }
  
  List<Parent> get externalParents {
    var externalList = new List<Parent>();
    for (Parent parent in parents) {
      if (parent.external) {
        externalList.add(parent);
      }
    }
    return externalList;
  }
  
  List<Parent> get externalRequiredParents {
    var externalRequiredList = new List<Parent>();
    for (Parent parent in parents) {
      if (parent.external && parent.required) {
        externalRequiredList.add(parent);
      }
    }
    return externalRequiredList;
  }
  
  List<Child> get internalChildren {
    var internalList = new List<Child>();
    for (Child child in children) {
      if (child.internal) {
        internalList.add(child);
      }
    }
    return internalList;
  }

  List<Property> get singleValueProperties {
    var propertyList = new List<Property>();
    propertyList.addAll(attributes.toList());
    propertyList.addAll(parents.toList());
    return propertyList;
  }
  
  bool get hasTwinParent {
    for (Parent parent in parents) {
      if (parent.twin) {
        return true;
      }
    }
    return false;
  }
  
  bool get hasReflexiveParent {
    for (Parent parent in parents) {
      if (parent.reflexive) {
        return true;
      }
    }
    return false;
  }
  
  bool get hasTwinChild {
    for (Child child in children) {
      if (child.twin) {
        return true;
      }
    }
    return false;
  }
  
  bool get hasReflexiveChild {
    for (Child child in children) {
      if (child.reflexive) {
        return true;
      }
    }
    return false;
  }

  bool get hasId {
    for (Property property in singleValueProperties) {
      if (property.identifier) {
        return true;
      }
    }
    return false;
  }
  
  bool get hasAttributeId {
    for (Attribute attribute in attributes) {
      if (attribute.identifier) {
        return true;
      }
    }
    return false;
  }
  
  bool get hasParentId {
    for (Parent parent in parents) {
      if (parent.identifier) {
        return true;
      }
    }
    return false;
  }

  Id get id {
    return new Id(this);
  }

  bool isAttributeSensitive(String attributeCode) {
    Attribute a = attributes.singleWhereCode(attributeCode);
    return a!= null && a.sensitive ? true : false;
  }

  bool isParentSensitive(String parentCode) {
    Parent p = parents.singleWhereCode(parentCode);
    return p!= null && p.sensitive ? true : false;
  }

  bool isChildSensitive(String childCode) {
    Child c = children.singleWhereCode(childCode);
    return c!= null && c.sensitive ? true : false;
  }

  bool isPropertySensitive(String propertyCode) {
    return isAttributeSensitive(propertyCode) ||
        isParentSensitive(propertyCode) ||
        isChildSensitive(propertyCode);
  }

  Concept get entryConcept {
    if (entry) {
      return this;
    } else {
      for (Parent parent in parents) {
        if (parent.internal) {
          return parent.destinationConcept.entryConcept;
        }
      }
      throw new ParentError('No internal parent for the ${code} concept');
    }
  }

  String get entryConceptThisConceptInternalPath {
    if (entry) {
      return code;
    } else {
      for (Parent parent in parents) {
        if (parent.internal) {
          return
            '${parent.destinationConcept.entryConceptThisConceptInternalPath}'
            '${code}';
        }
      }
      throw new ParentError('No internal parent for the ${code} concept');
    }
  }

  List<String> get childCodeInternalPaths {
    var childList = new List<String>();
    for (Child child in children) {
      Concept sourceConcept = child.sourceConcept;
      String entryConceptSourceConceptInternalPath =
          sourceConcept.entryConceptThisConceptInternalPath;
      Concept destinationConcept = child.destinationConcept;
      String childCodeInternalPath =
          '${entryConceptSourceConceptInternalPath}'
          '_${child.code}_${destinationConcept.code}';
      childList.add(childCodeInternalPath);
      if (!child.reflexive) {
        childList.addAll(child.destinationConcept.childCodeInternalPaths);
      }
    }
    return childList;
  }

}

  


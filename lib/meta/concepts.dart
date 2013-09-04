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

  // to allow for a specific plural name, different from
  // the plural name derivation in ConceptEntity
  String _codes; // code (in) plural
  String _codesFirstLetterLower;
  String _codesLowerUnderscore; // lower letters and undescore separator
  String description;

  Model model;

  Attributes attributes;
  Parents parents; // destination parent neighbors
  Children children; // destination child neighbors

  Parents sourceParents;
  Children sourceChildren;

  Concept(this.model, String conceptCode) {
    super.code = conceptCode;
    model.concepts.add(this);

    attributes = new Attributes();

    parents = new Parents();
    children = new Children();

    sourceParents = new Parents();
    sourceChildren = new Children();
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
      _codes = codePlural;
    }
    return _codes;
  }
  void set codes(String codes) {
    _codes = codes;
  }

  String get codesFirstLetterLower {
    if (_codesFirstLetterLower == null) {
      _codesFirstLetterLower = codePluralFirstLetterLower;
    }
    return _codesFirstLetterLower;
  }
  void set codesFirstLetterLower(String codesFirstLetterLower) {
    _codesFirstLetterLower = codesFirstLetterLower;
  }

  String get codesLowerUnderscore {
    if (_codesLowerUnderscore == null) {
      _codesLowerUnderscore = codePluralLowerUnderscore;
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

  List<Attribute> get essentialAttributes {
    List<Attribute> essentialList= new List<Attribute>();
    for (Attribute attribute in attributes) {
      if (attribute.essential) {
        essentialList.add(attribute);
      }
    }
    return essentialList;
  }

  List<Property> get singleValueProperties {
  List<Property> propertyList = new List<Property>();
    propertyList.addAll(attributes.toList());
    propertyList.addAll(parents.toList());
    return propertyList;
  }

  bool get identifier {
  for (Property property in singleValueProperties) {
      if (property.identifier) {
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
    List<String> childList = new List<String>();
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

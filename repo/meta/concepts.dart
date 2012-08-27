
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

  Attribute getAttribute(String attributeCode) =>
      attributes.findByCode(attributeCode);

  Parent getDestinationParent(String parentCode) =>
      parents.findByCode(parentCode);
  Child getDestinationChild(String childCode) =>
      children.findByCode(childCode);

  Parent getSourceParent(String parentCode) =>
      sourceParents.findByCode(parentCode);
  Child getSourceChild(String childCode) =>
      sourceChildren.findByCode(childCode);

  List<Property> get properties() {
    List<Property> properties = new List<Property>();
    properties.addAll(attributes.list);
    properties.addAll(parents.list);
    return properties;
  }

  bool get identifier() {
    for (Property property in properties) {
      if (property.identifier) {
        return true;
      }
    }
    return false;
  }

  Id get id() {
    return new Id(this);
  }

  bool isAttributeSensitive(String attributeCode) {
    Attribute a = attributes.findByCode(attributeCode);
    return a!= null && a.sensitive ? true : false;
  }

  bool isParentSensitive(String parentCode) {
    Parent p = parents.findByCode(parentCode);
    return p!= null && p.sensitive ? true : false;
  }

  bool isChildSensitive(String childCode) {
    Child c = children.findByCode(childCode);
    return c!= null && c.sensitive ? true : false;
  }

  bool isPropertySensitive(String propertyCode) {
    return isAttributeSensitive(propertyCode) ||
        isParentSensitive(propertyCode) ||
        isChildSensitive(propertyCode);
  }

  Concept get entryConcept() {
    if (entry) {
      return this;
    } else {
      for (Parent parent in parents) {
        if (parent.internal) {
          return parent.destinationConcept.entryConcept;
        }
      }
      throw new ParentException('No internal parent for the ${code} concept');
    }
  }

}

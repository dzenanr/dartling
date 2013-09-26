part of dartling;

Model fromJsonToModel(String json, Domain domain, String modelCode) {
  if (json == null || json.trim() == '') {
    return null;
  }
  Map<String, Object> boardMap = JSON.decode(json);
  List<Map<String, Object>> boxes = boardMap["boxes"];
  List<Map<String, Object>> lines = boardMap["lines"];

  Model model = new Model(domain, modelCode);

  for (Map<String, Object> box in boxes) {
    String conceptCode = box["name"];
    bool conceptEntry = box["entry"];
    Concept concept = new Concept(model, conceptCode);
    concept.entry = conceptEntry;

    List<Map<String, Object>> items = box["items"];
    for (Map<String, Object> item in items) {
      String attributeCode = item["name"];
      if (attributeCode != 'oid' && attributeCode != 'code') {
        Attribute attribute = new Attribute(concept, attributeCode);
        String itemCategory = item["category"];
        if (itemCategory == 'guid') {
          attribute.guid = true;
        } else if (itemCategory == 'identifier') {
          attribute.identifier = true;
        } else if (itemCategory == 'required') {
          attribute.minc = '1';
        }
        int itemSequence = item["sequence"];
        attribute.sequence = itemSequence;
        String itemInit = item["init"];
        if (itemInit == null || itemInit.trim() == '') {
          attribute.init = null;
        } else if (itemInit  == 'increment') {
          attribute.increment = 1;
          attribute.init = null;
        } else if (itemInit  == 'empty') {
          attribute.init = '';
        } else {
          attribute.init = itemInit;
        }
        bool itemEssential = item["essential"];
        attribute.essential = itemEssential;
        bool itemSensitive = item["sensitive"];
        attribute.sensitive = itemSensitive;
        String itemType = item["type"];
        AttributeType type = domain.types.singleWhereCode(itemType);
        if (type != null) {
          attribute.type = type;
        } else {
          attribute.type = domain.getType('String');
        }
      }
    }
  }

  for (Map<String, Object> line in lines) {
    String box1Name = line["box1Name"];
    String box2Name = line["box2Name"];

    Concept concept1 = model.concepts.singleWhereCode(box1Name);
    Concept concept2 = model.concepts.singleWhereCode(box2Name);
    if (concept1 == null) {
      throw new ConceptError(
        'Line concept is missing for the $box1Name box.');
    }
    if (concept2 == null) {
      throw new ConceptError(
        'Line concept is missing for the $box2Name box.');
    }

    String box1box2Name = line["box1box2Name"];
    String box1box2Min = line["box1box2Min"];
    String box1box2Max = line["box1box2Max"];
    bool box1box2Id = line["box1box2Id"];

    String box2box1Name = line["box2box1Name"];
    String box2box1Min = line["box2box1Min"];
    String box2box1Max = line["box2box1Max"];
    bool box2box1Id = line["box2box1Id"];

    bool lineInternal = line["internal"];
    String lineCategory = line["category"];

    bool d12Child;
    bool d21Child;
    bool d12Parent;
    bool d21Parent;

    if (box1box2Max != '1') {
      d12Child = true;
      if (box2box1Max != '1') {
        d21Child = true;
      } else {
        d21Child = false;
      }
    } else if (box2box1Max != '1') {
      d12Child = false;
      d21Child = true;
    } else if (box1box2Min == '0') {
      d12Child = true;
      d21Child = false;
    } else if (box2box1Min == '0') {
      d12Child = false;
      d21Child = true;
    } else {
      d12Child = true;
      d21Child = false;
    }

    d12Parent = !d12Child;
    d21Parent = !d21Child;

    if (d12Child && d21Child) {
      throw new Exception('$box1Name -- $box2Name line has two children.');
    }
    if (d12Parent && d21Parent) {
      throw new Exception('$box1Name -- $box2Name line has two parents.');
    }

    Neighbor neighbor12;
    Neighbor neighbor21;

    if (d12Child && d21Parent) {
      neighbor12 = new Child(concept1, concept2, box1box2Name);
      neighbor21 = new Parent(concept2, concept1, box2box1Name);
    } else if (d12Parent && d21Child) {
      neighbor12 = new Parent(concept1, concept2, box1box2Name);
      neighbor21 = new Child(concept2, concept1, box2box1Name);
    }

    neighbor12.opposite = neighbor21;
    neighbor21.opposite = neighbor12;

    neighbor12.minc = box1box2Min;
    neighbor12.maxc = box1box2Max;
    neighbor12.identifier = box1box2Id;

    neighbor21.minc = box2box1Min;
    neighbor21.maxc = box2box1Max;
    neighbor21.identifier = box2box1Id;

    neighbor12.internal = lineInternal;
    if (lineCategory == 'inheritance') {
      neighbor12.inheritance = true;
    } else if (lineCategory == 'reflexive') {
      neighbor12.reflexive = true;
    } else if (lineCategory == 'twin') {
      neighbor12.twin = true;
    }

    neighbor21.internal = lineInternal;
    if (lineCategory == 'inheritance') {
      neighbor21.inheritance = true;
    } else if (lineCategory == 'reflexive') {
      neighbor21.reflexive = true;
    } else if (lineCategory == 'twin') {
      neighbor21.twin = true;
    }
  }

  return model;
}

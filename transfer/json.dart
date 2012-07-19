
Domain fromMagicBoxes(String json) {
  Map<String, Object> boardMap = JSON.parse(json);
  List<Map<String, Object>> boxes = boardMap["boxes"];
  List<Map<String, Object>> lines = boardMap["lines"];

  Domain domain = new Domain();
  Model model = new Model(domain);

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
          attribute.id = true;
        } else if (itemCategory == 'required') {
          attribute.min = '1';
        }
        int itemSequence = item["sequence"];
        attribute.sequence = itemSequence;
        String itemInit = item["init"];
        attribute.init = itemInit;
        String itemType = item["type"];
        Type type = domain.types.getEntity(itemType);
        if (type != null) {
          attribute.type = type;
        }
      }
    }
  }

  for (Map<String, Object> line in lines) {
    String box1Name = line["box1Name"];
    String box2Name = line["box2Name"];

    Concept concept1 = model.concepts.getEntity(box1Name);
    Concept concept2 = model.concepts.getEntity(box2Name);
    if (concept1 == null) {
      throw new NullPointerException(
        'Line concept is missing for the $box1Name box.');
    }
    if (concept2 == null) {
      throw new NullPointerException(
        'Line concept is missing for the $box2Name box.');
    }
    String box1box2Name = line["box1box2Name"];
    Neighbor neighbor12 = new Neighbor(concept1, concept2, box1box2Name);
    String box2box1Name = line["box2box1Name"];
    Neighbor neighbor21 = new Neighbor(concept2, concept1, box2box1Name);
    neighbor12.opposite = neighbor21;
    neighbor21.opposite = neighbor12;

    String box1box2Min = line["box1box2Min"];
    neighbor12.min = box1box2Min;
    String box1box2Max = line["box1box2Max"];
    neighbor12.max = box1box2Max;
    bool box1box2Id = line["box1box2Id"];
    neighbor12.id = box1box2Id;
    bool lineInternal = line["internal"];
    neighbor12.internal = lineInternal;
    String lineCategory = line["category"];
    if (lineCategory == 'inheritance') {
      neighbor12.inheritance = true;
    }
    if (neighbor12.maxMany && !neighbor21.maxMany) {
      neighbor12.child = true;
      neighbor21.child = false;
    } else if (!neighbor12.maxMany && neighbor21.maxMany) {
      neighbor12.child = false;
      neighbor21.child = true;
    } else if (neighbor12.maxMany && neighbor21.maxMany) {
      throw new Exception('$box1Name -- $box2Name line has two max of N.');
    } else if (neighbor12.min.trim() == '0' && neighbor21.min.trim() == '1') {
      neighbor12.child = true;
      neighbor21.child = false;
    } else if (neighbor12.min.trim() == '1' && neighbor21.min.trim() == '0') {
      neighbor12.child = false;
      neighbor21.child = true;
    } else if (neighbor12.min.trim() == '0' && neighbor21.min.trim() == '0') {
      neighbor12.child = true;
      neighbor21.child = false;
    }
  }
  return domain;
}

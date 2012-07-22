
class Data {

  Model model;

  Map<String, Entities> _entryConceptMap;

  Data(this.model) {
    _entryConceptMap = new Map<String, Entities>();
    model.entryConcepts.forEach((c)
      {var entryEntities = new Entities.of(c);
      _entryConceptMap[c.code] = entryEntities;
      });
  }

  Entities getEntry(String code) => _entryConceptMap[code];

}

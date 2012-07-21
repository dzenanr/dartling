
class Entries {

  Model model;

  Map<String, Entities> _entryConceptMap;

  Entries(this.model) {
    _entryConceptMap = new Map<String, Entities>();
    model.entryConcepts.forEach((c)
      {var entryEntities = new Entities.of(c);
      _entryConceptMap[c.code] = entryEntities;
      });
  }

  int get length() => _entryConceptMap.length;

  Entities getEntry(String name) => _entryConceptMap[name];

}

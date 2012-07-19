
class Entry {
  
  Model model;
  
  Map<String, Entities> entryConceptMap;
  
  Entry(this.model) {
    entryConceptMap = new Map<String, Entities>();
    model.entryConcepts.forEach((c) 
      {var entryEntities = new Entities.of(c);
      entryConceptMap[c.code] = entryEntities;
      });
  }
  
}

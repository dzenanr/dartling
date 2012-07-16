
class Entry {
  
  Model model;
  
  Map<String, Entities> concepts;
  
  Entry(this.model) {
    concepts = new Map<String, Entities>();
    model.entryConcepts.forEach((c) 
      {var entryEntities = new Entities.of(c);
      concepts[c.code] = entryEntities;
      });
  }
  
}

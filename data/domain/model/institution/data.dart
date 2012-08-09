
class InstitutionData extends ModelData {

  InstitutionData(Model model) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept = model.concepts.findByCode('Ecole');
    entries[concept.code] = new Ecoles(concept);
    return entries;
  }

  Ecoles get ecoles() => getEntry('Ecole');

  Concept get ecoleConcept() => ecoles.concept;

}
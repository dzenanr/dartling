part of art_pen;

// src/data/gen/art/models.dart

class ArtModels extends DomainModels {

  ArtModels(Domain domain) : super(domain) {
    add(fromJsonToPenEntries());
  }

  PenEntries fromJsonToPenEntries() {
    return new PenEntries(fromJsonToModel(
      artPenModelJson,
      domain,
      ArtRepo.artPenModelCode));
  }

}


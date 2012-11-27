part of art_pen;

// src/data/gen/art/repository.dart

class ArtRepo extends Repo {

  static final artDomainCode = "Art";
  static final artPenModelCode = "Pen";

  ArtRepo([String code="ArtRepo"]) : super(code) {
    _initArtDomain();
  }

  _initArtDomain() {
    var artDomain = new Domain(artDomainCode);
    domains.add(artDomain);
    add(new ArtModels(artDomain));
  }

}

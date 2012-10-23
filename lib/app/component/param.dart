part of dartling_app;

class View {

  Repo repo;
  Entities entities;
  ConceptEntity entity;

  Document document;
  String did;
  String title;
  bool essentialOnly = false;

  View(this.document, this.did);

  View.from(View otherView, this.did) {
    repo = otherView.repo;
    entities = otherView.entities;
    entity = otherView.entity;

    document = otherView.document;
    title = otherView.title;
    essentialOnly = otherView.essentialOnly;
  }

}


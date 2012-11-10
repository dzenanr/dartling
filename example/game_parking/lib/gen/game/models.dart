part of game_parking;

// data/gen/game/models.dart

class GameModels extends DomainModels {

  GameModels(Domain domain) : super(domain) {
    add(fromJsonToParkingEntries());
  }

  ParkingEntries fromJsonToParkingEntries() {
    return new ParkingEntries(fromMagicBoxes(
      gameParkingModelJson,
      domain,
      GameRepo.gameParkingModelCode));
  }

}







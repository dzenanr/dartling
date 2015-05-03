part of game_parking; 
 
// lib/gen/game/models.dart 
 
class GameModels extends DomainModels { 
 
  GameModels(Domain domain) : super(domain) { 
    add(fromJsonToParkingEntries()); 
  } 
 
  ParkingEntries fromJsonToParkingEntries() { 
    return new ParkingEntries(fromJsonToModel( 
      gameParkingModelJson, 
      domain, 
      GameRepo.gameParkingModelCode)); 
  } 
 
}







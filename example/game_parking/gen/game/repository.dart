part of game_parking; 
 
// lib/gen/game/repository.dart

class GameRepo extends Repo { 
  
  static final gameDomainCode = "Game"; 
  static final gameParkingModelCode = "Parking"; 
 
  GameRepo([String code="GameRepo"]) : super(code) { 
    _initGameDomain(); 
  } 
 
  _initGameDomain() { 
    var gameDomain = new Domain(gameDomainCode); 
    domains.add(gameDomain); 
    add(new GameModels(gameDomain)); 
  } 
 
} 





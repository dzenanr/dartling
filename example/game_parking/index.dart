import 'dart:html';

import 'game_parking.dart';
import 'game_parking_app.dart';

initGameData(GameRepo gameRepo) {
   var gameModels =
       gameRepo.getDomainModels(GameRepo.gameDomainCode);

   var gameParkingEntries =
       gameModels.getModelEntries(GameRepo.gameParkingModelCode);
   initGameParking(gameParkingEntries);
}

main() {
  var gameRepo = new GameRepo();
  initGameData(gameRepo);

  // Get a reference to the canvas.
  CanvasElement canvas = document.querySelector("#canvas");
  new Board(canvas, gameRepo);
}




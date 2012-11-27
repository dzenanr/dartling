
import 'dart:html';
import 'dart:isolate';

import 'package:dartling/dartling.dart';
import 'package:dartling/dartling_app.dart';

import 'package:game_parking/game_parking.dart';
import 'package:game_parking/game_parking_app.dart';

initGameData(GameRepo gameRepo) {
   var gameModels =
       gameRepo.getDomainModels(GameRepo.gameDomainCode);

   var gameParkingEntries =
       gameModels.getModelEntries(GameRepo.gameParkingModelCode);
   initGameParking(gameParkingEntries);
   //gameParkingEntries.display();
   //gameParkingEntries.displayJson();
}

void main() {
  var gameRepo = new GameRepo();
  initGameData(gameRepo);

  // Get a reference to the canvas.
  CanvasElement canvas = document.query("#canvas");
  Board board = new Board(canvas, gameRepo);
}




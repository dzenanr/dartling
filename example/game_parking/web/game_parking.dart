
import 'dart:html';
import 'dart:isolate';

import 'package:dartling/dartling.dart';
import 'package:dartling/dartling_app.dart';

// pub
//import 'package:game_parking/game_parking.dart';

part '../lib/game/parking/json/data.dart';
part '../lib/game/parking/json/model.dart';
part '../lib/game/parking/init.dart';
part '../lib/game/parking/areas.dart';
part '../lib/game/parking/brands.dart';
part '../lib/game/parking/parkings.dart';
part '../lib/game/parking/cars.dart';
part '../lib/gen/game/parking/entries.dart';
part '../lib/gen/game/parking/areas.dart';
part '../lib/gen/game/parking/brands.dart';
part '../lib/gen/game/parking/parkings.dart';
part '../lib/gen/game/parking/cars.dart';
part '../lib/gen/game/models.dart';
part '../lib/gen/game/repository.dart';

//import 'package:game_parking/game_parking_app.dart';

part '../lib/app/home/board.dart';
part '../lib/app/home/dash.dart';
part '../lib/app/home/menu.dart';
// pub

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




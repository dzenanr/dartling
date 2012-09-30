
#import("dart:html");

#import("package:dartling/dartling.dart");
#import("package:dartling/dartling_app.dart");

//#import("package:game_parking/game_parking.dart");

#source("../lib/game/parking/json/data.dart");
#source("../lib/game/parking/json/model.dart");
#source("../lib/game/parking/init.dart");
#source("../lib/game/parking/areas.dart");
#source("../lib/game/parking/brands.dart");
#source("../lib/game/parking/parkings.dart");
#source("../lib/game/parking/cars.dart");
#source("../lib/gen/game/parking/entries.dart");
#source("../lib/gen/game/parking/areas.dart");
#source("../lib/gen/game/parking/brands.dart");
#source("../lib/gen/game/parking/parkings.dart");
#source("../lib/gen/game/parking/cars.dart");
#source("../lib/gen/game/models.dart");
#source("../lib/gen/game/repository.dart");

//#import("package:game_parking/game_parking_app.dart");

#source("../lib/app/home/board.dart");
#source("../lib/app/home/dash.dart");
#source("../lib/app/home/menu.dart");

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




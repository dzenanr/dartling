part of game_parking_app;

class MenuBar {

  final Board board;

  // Area
  ButtonElement beginnerAreaButton;
  ButtonElement intermediateAreaButton;

  // Parking
  ButtonElement parking1Button;
  ButtonElement parking2Button;

  MenuBar(this.board) {
    beginnerAreaButton = document.querySelector('#beginner');
    intermediateAreaButton = document.querySelector('#intermediate');

    parking1Button = document.querySelector('#parking1');
    parking2Button = document.querySelector('#parking2');

    beginnerAreaButton.onClick.listen((MouseEvent e) {
      board.currentArea = board.entries.areas.getArea('beginner');
    });
    intermediateAreaButton.onClick.listen((MouseEvent e) {
      board.currentArea = board.entries.areas.getArea('intermediate');
    });

    parking1Button.onClick.listen((MouseEvent e) {
      board.currentParking = board.currentArea.parkings.getParkingWithinArea(1);
    });
    parking2Button.onClick.listen((MouseEvent e) {
      board.currentParking = board.currentArea.parkings.getParkingWithinArea(2);
    });
  }

}

part of game_parking_app;

class ActionPanel {

  final Board board;

  ButtonElement restartButton;

  LabelElement areaLabel;
  LabelElement parkingLabel;

  ActionPanel(this.board) {
    restartButton = document.querySelector('#restart');
    restartButton.onClick.listen((MouseEvent e) {
      board.restart();
    });

    areaLabel = document.querySelector('#area');
    parkingLabel = document.querySelector('#parking');
  }

  void displayCurrentArea() {
    areaLabel.text = board.currentArea.name;
  }

  void displayCurrentParking() {
    parkingLabel.text = board.currentParking.number.toString();
  }

}

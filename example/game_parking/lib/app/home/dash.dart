part of game_parking_app;

class ActionPanel {

  final Board board;

  ButtonElement restartButton;

  LabelElement areaLabel;
  LabelElement parkingLabel;

  ActionPanel(this.board) {
    restartButton = document.query('#restart');
    restartButton.on.click.add((MouseEvent e) {
      board.restart();
    });

    areaLabel = document.query('#area');
    parkingLabel = document.query('#parking');
  }

  void displayCurrentArea() {
    areaLabel.text = board.currentArea.name;
  }

  void displayCurrentParking() {
    parkingLabel.text = board.currentParking.number.toString();
  }

}

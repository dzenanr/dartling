part of art_pen_app;

class Commands {

  final Pen pen;

  ButtonElement showButton;
  ButtonElement clearButton;
  ButtonElement drawButton;
  TextAreaElement commandsTextArea;

  Commands(this.pen) {
    showButton = document.querySelector('#show');
    showButton.onClick.listen((MouseEvent e) {
      clear();
      commandsTextArea.value = pen.fromCommands();
      commandsTextArea.select();
    });

    clearButton = document.querySelector('#clear');
    clearButton.onClick.listen((MouseEvent e) {
      clear();
    });

    drawButton = document.querySelector('#draw');
    drawButton.onClick.listen((MouseEvent e) {
      pen.interpret(commandsTextArea.value);
    });

    commandsTextArea = document.querySelector('#commands');
  }

  void clear() { commandsTextArea.value = ''; }
}

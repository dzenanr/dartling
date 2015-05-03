part of art_pen_app;

class Board {
  static const int interval = 10; // in ms; redraw every interval
  static final int artCount = 4;  // how many times segments are doubled
  static final num leftAngle = 22.5;
  static final num righttAngle = 45;
  static final num backwardSteps = 60;
  static final num forwardSteps = 120;

  Pen pen;

  Map<String, String> colors;
  SelectElement colorSelect;
  SelectElement widthSelect;
  InputElement downCheckbox;
  InputElement writeInput;
  InputElement visibleCheckbox;
  InputElement artCountInput;
  ButtonElement artButton;
  InputElement onDartCountInput;
  ButtonElement onDartButton;
  ButtonElement eraseButton;
  ButtonElement exampleButton;
  SelectElement programSelect;

  CanvasElement canvas;
  CanvasRenderingContext2D context;

  InputElement turnInput;
  InputElement advanceInput;
  InputElement repeatInput;
  ButtonElement moveButton;
  ButtonElement randomButton;
  ButtonElement startButton;

  InputElement leftInput;
  ButtonElement leftButton;
  InputElement rightInput;
  ButtonElement rightButton;
  InputElement backwardInput;
  ButtonElement backwardButton;
  InputElement forwardInput;
  ButtonElement forwardButton;

  Board(minRepo) {
    pen = new Pen(minRepo);

    colors = colorMap();
    // above drawing
    colorSelect = document.querySelector('#color');
    colorSelect.onChange.listen((Event e) {
      pen.color = colorSelect.value;
    });

    widthSelect = document.querySelector('#width');
    widthSelect.onChange.listen((Event e) {
      try {
        pen.width = int.parse(widthSelect.value);
      } on FormatException catch(error) {
        print('${widthSelect.value} must be an integer -- $error');
      }
    });

    downCheckbox = document.querySelector('#down');
    downCheckbox.onChange.listen((Event e) {
      pen.down = downCheckbox.checked;
    });

    writeInput = document.querySelector('#write');
    writeInput.onChange.listen((Event e) {
      pen.write = writeInput.value;
    });

    visibleCheckbox = document.querySelector('#visible');
    visibleCheckbox.onChange.listen((Event e) {
      pen.visible = visibleCheckbox.checked;
    });

    artCountInput = document.querySelector('#artCount');
    artButton = document.querySelector('#art');
    artButton.onClick.listen((MouseEvent e) {
      try {
        pen.art(int.parse(artCountInput.value));
      } on FormatException catch(error) {
        print('Art count (${artCountInput.value}) must be an integer -- $error');
      }
    });

    onDartCountInput = document.querySelector('#onDartCount');
    onDartButton = document.querySelector('#onDart');
    onDartButton.onClick.listen((MouseEvent e) {
      try {
        randomProgram(pen,
            int.parse(artCountInput.value), int.parse(onDartCountInput.value));
      } on FormatException {
        randomProgram(pen, artCount, randomCommandGenList.length + 1);
      }
    });

    eraseButton = document.querySelector('#erase');
    eraseButton.onClick.listen((MouseEvent e) {
      pen.erase();
      _init();
    });

    exampleButton = document.querySelector('#example');
    exampleButton.onClick.listen((MouseEvent e) {
      pen.example(randomInt(pen.examples.length - 1));
    });

    programSelect = document.querySelector('#program');
    programSelect.onChange.listen((Event e) {
      try {
        if (programSelect.value == 'random example') {
          randomExample(pen, artCount:int.parse(artCountInput.value));
        } else {
          demo(pen, int.parse(programSelect.value));
        }
      } on FormatException {
        randomExample(pen);
      }
    });

    // drawing

    canvas = document.querySelector('#canvas');
    context = canvas.getContext('2d');
    pen.drawingWidth = canvas.width;
    pen.drawingHeight = canvas.height;

    // bellow drawing

    turnInput = document.querySelector('#turn');
    advanceInput = document.querySelector('#advance');
    repeatInput = document.querySelector('#repeat');

    moveButton = document.querySelector('#move');
    moveButton.onClick.listen((MouseEvent e) {
      try {
        num turn = double.parse(turnInput.value);
        num advance = double.parse(advanceInput.value);
        int repeat = int.parse(repeatInput.value);
        pen.move(turn, advance, repeat);
      } on FormatException catch(error) {
        print('not a number -- $error');
      }
    });

    randomButton = document.querySelector('#random');
    randomButton.onClick.listen((MouseEvent e) {
      pen.moveRandom();
    });

    startButton = document.querySelector('#start');
    startButton.onClick.listen((MouseEvent e) {
      pen.moveTo(pen.startX, pen.startY);
    });

    leftInput = document.querySelector('#leftTurn');
    leftButton = document.querySelector('#left');
    leftButton.onClick.listen((MouseEvent e) {
      try {
        // num value = leftInput.valueAsNumber; // ??
        pen.left(double.parse(leftInput.value));
      } on FormatException catch(error) {
        print('${leftInput.value} must be a number -- $error');
      }
    });

    rightInput = document.querySelector('#rightTurn');
    rightButton = document.querySelector('#right');
    rightButton.onClick.listen((MouseEvent e) {
      try {
        pen.right(double.parse(rightInput.value));
      } on FormatException catch(error) {
        print('${rightInput.value} must be a number -- $error');
      }
    });

    backwardInput = document.querySelector('#backwardAdvance');
    backwardButton = document.querySelector('#backward');
    backwardButton.onClick.listen((MouseEvent e) {
      try {
        pen.backward(double.parse(backwardInput.value));
      } on FormatException catch(error) {
        print('${backwardInput.value} must be a number -- $error');
      }
    });

    forwardInput = document.querySelector('#forwardAdvance');
    forwardButton = document.querySelector('#forward');
    forwardButton.onClick.listen((MouseEvent e) {
      try {
        pen.forward(double.parse(forwardInput.value));
      } on FormatException catch(error) {
        print('${forwardInput.value} must be a number -- $error');
      }
    });

    _init();

    // redraw
    window.animationFrame.then(gameLoop);
  }

  void gameLoop(num delta) {
    draw();
    window.animationFrame.then(gameLoop);
  }

  void _init() {
    colorSelect.value = pen.color;
    widthSelect.value = pen.width.toString();
    downCheckbox.checked = pen.down;
    writeInput.value = pen.write;
    visibleCheckbox.checked = pen.visible;
    artCountInput.value = artCount.toString();
    onDartCountInput.value = (randomCommandGenList.length + 1).toString();
    programSelect.value = 'program';

    turnInput.value = Pen.angle.toString();
    advanceInput.value = Pen.steps.toString();
    repeatInput.value = Pen.repeat.toString();

    leftInput.value = leftAngle.toString();
    rightInput.value = righttAngle.toString();
    backwardInput.value = backwardSteps.toString();
    forwardInput.value = forwardSteps.toString();
  }

  void clear() {
    context.beginPath();
    context.fillStyle = colors['white'];
    context.lineWidth = pen.width;
    context.strokeStyle = colors[pen.color];
    context.clearRect(0, 0, canvas.width, canvas.height);
    context.rect(0, 0, canvas.width, canvas.height);
    context.fill();
    context.stroke();
    context.closePath();
  }

  void draw() {
    clear();

    for (Segment segment in pen.segments) {
      if (segment.visible) {
        // draw segment lines
        context.beginPath();
        context.lineWidth = segment.width;
        context.strokeStyle = colors[segment.color];
        for (Line line in segment.lines) {
          context.moveTo(line.beginX, line.beginY);
          context.lineTo(line.endX, line.endY);
          if (segment.text != null && segment.text.trim() != '') {
            var x = (line.beginX + line.endX) / 2;
            var y = (line.beginY + line.endY) / 2;
            context.font = '14px sans-serif';
            context.textAlign = 'center';
            context.strokeText(segment.text, x + 2, y - 2, line.pixels);
          }
        }
        context.stroke();
        context.closePath();
      }
    }

    if (pen.visible) {
      // draw pen as a circle with the current direction
      context.beginPath();
      context.fillStyle = colors[pen.color];
      context.lineWidth = pen.width;
      context.strokeStyle = colors[pen.color];
      Line direction;
      Map endPoint;
      if (pen.lastLine == null) {
        context.arc(pen.startX, pen.startY, pen.width + 1,
            0, PI * 2, false);
        direction = new Line.first(pen.lineConcept, pen.startX, pen.startY);
        endPoint = direction.findEndPoint(
            direction.beginX, direction.beginY, direction.cumulativeAngle,
            pen.width + 8);
      } else {
        context.arc(pen.lastLine.endX, pen.lastLine.endY, pen.width + 1,
            0, PI * 2, false);
        direction = new Line.next(pen.lastLine.concept, pen.lastLine);
        endPoint = direction.findEndPoint(
            direction.beginX, direction.beginY, pen.lastLine.cumulativeAngle,
            pen.width + 8);
      }
      direction.endX = endPoint['x'];
      direction.endY = endPoint['y'];
      context.moveTo(direction.beginX, direction.beginY);
      context.lineTo(direction.endX, direction.endY);

      context.fill();
      context.stroke();
      context.closePath();
    }
  }

}

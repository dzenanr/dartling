part of art_pen;

var basicCommands = ['color',
                     'width',
                     'down',
                     'write',
                     'moveTo',
                     'move',
                     'art'
                    ];

var shortcutCommands = ['left',
                        'right',
                        'backward',
                        'forward',
                        'moveToStart'
                        ];

var commands = ['color',
                'width',
                'down',
                'write',
                'moveToStart',
                'moveTo',
                'move',
                'left',
                'right',
                'backward',
                'forward',
                'art'
               ];

var randomCommands = [
                      'colorRandom',
                      'widthRandom',
                      'downRandom',
                      'moveToRandom',
                      'moveRandom',
                      'leftRandom',
                      'rightRandom',
                      'backwardRandom',
                      'forwardRandom',
                      'artRandom'
                     ];

var randomCommandGenList = ['colorRandom',
                            'moveRandom',
                            'widthRandom',
                            'moveRandom',
                            'moveRandom',
                            'leftRandom',
                            'moveRandom',
                            'artRandom',
                            'moveToRandom',
                            'moveRandom',
                            'leftRandom',
                            'colorRandom',
                            'moveRandom',
                            'backwardRandom',
                            'widthRandom',
                            'rightRandom',
                            'moveRandom',
                            'colorRandom',
                            'moveRandom',
                            'colorRandom',
                            'downRandom',
                            'widthRandom',
                            'forwardRandom',
                            'moveRandom',
                            'moveRandom',
                            'rightRandom',
                            'moveRandom',
                            'colorRandom',
                            'forwardRandom',
                            'widthRandom',
                            'moveRandom',
                            'moveRandom'
                           ];

randomProgram(Pen pen, [int artCount = 4, int commandsCount = 32]) {
  var program = '';
  var commandIndex;
  var command;
  var lastCommand = '';
  var lastArtCommand = false;
  for (var i = 0; i < commandsCount - 1; i++) {
    commandIndex = randomInt(randomCommandGenList.length);
    command = randomCommandGenList[commandIndex].trim();
    if (command == 'colorRandom' || command == 'widthRandom'
        || command == 'downRandom' || command == 'moveToStart') {
      if (command == lastCommand) {
        command = 'moveRandom';
      }
    } else if (command == 'artRandom') {
      if (lastArtCommand) {
        command = 'moveRandom';
      } else {
        lastArtCommand = true;
      }
    }
    program = '${program}${command}; \n';
    lastCommand = command;
  }
  if (artCount > 0 && !lastArtCommand) {
    program = '${program}art, ${artCount};';
  }
  pen.erase();
  pen.interpret(program);
}

randomExample(Pen pen, {int artCount: 4}) {
  var commands =
    'colorRandom; '
    'widthRandom; '
    'moveRandom; '
    'moveRandom; '
    'colorRandom; '
    'moveRandom; '
    'moveRandom; '
    'moveRandom; '
    'widthRandom; '
    'moveRandom; '
    'moveRandom; '
    'colorRandom; '
    'moveRandom; '
    'widthRandom; '
    'moveRandom; '
    'moveToStart; '
    'colorRandom; '
    'moveRandom; '
    'moveRandom; '
    'widthRandom; '
    'moveRandom; '
    'moveToRandom; '
    'moveRandom; '
    'widthRandom; '
    'moveRandom; '
    'moveRandom; '
    'art, ${artCount}; ';
  pen.erase();
  pen.interpret(commands);
}

demo(Pen pen, int demo) {
  switch(demo) {
    case 1:
      demo1(pen);
      break;
    case 2:
      demo2(pen);
      break;
    case 3:
      demo3(pen);
      break;
    case 4:
      demo4(pen);
      break;
    case 5:
      demo5(pen);
      break;
    case 6:
      demo6(pen);
      break;
    case 7:
      demo7(pen);
      break;
    case 8:
      demo8(pen);
      break;
    case 9:
      demo9(pen);
      break;
    case 10:
      demo10(pen);
      break;
    case 11:
      demo11(pen);
      break;
    case 12:
      demo12(pen);
      break;
    case 13:
      demo13(pen);
      break;
    case 14:
      demo14(pen);
      break;
    case 15:
      demo15(pen);
      break;
    case 16:
      demo16(pen);
      break;
    case 17:
      demo17(pen);
      break;
    case 18:
      demo18(pen);
      break;
    case 19:
      demo19(pen);
      break;
    case 20:
      demo20(pen);
      break;
    case 21:
      demo21(pen);
      break;
    default:
      randomExample(pen);
  }
}

List sequence(int count) {
  // based on: http://blog.zacharyabel.com/tag/turtle-programs/
  List seq(List sequence) {
    var seq = new List.from(sequence);
    for (var i in sequence) {
      if (i == 1) {
        seq.add(0);
      } else if (i == 0) {
        seq.add(1);
      }
    }
    return seq;
  }

  var sequence = new List();
  sequence.add(1);
  var s = seq(sequence);
  for (var j = 0; j < count; j++) {
    s = seq(s);
  }
  return s;
}

demo1(Pen pen) {
  pen.erase();
  pen.color = 'red';
  pen.move(45, 80, 1);
  pen.width = 2;
  pen.color = 'yellow';
  pen.move(50, 80, 1);
  pen.width = 1;
  pen.color = 'blue';
  pen.move(65, 80, 1);
  pen.art(4);
}

demo2(Pen pen) {
  pen.erase();
  pen.color = 'red';
  pen.move(90, 100, 0);
  pen.move(120, 100, 1);
  pen.color = 'gray';
  pen.move(60, 100, 0);
  pen.move(120, 100, 1);
  pen.color = 'blue';
  pen.move(60, 100, 0);
  pen.move(120, 100, 1);
  pen.art(3);
}

demo3(Pen pen) {
  pen.erase();
  pen.color = 'red';
  pen.move(33, 100, 0);
  pen.move(120, 100, 1);
  pen.color = 'gray';
  pen.move(60, 100, 0);
  pen.move(120, 100, 1);
  pen.color = 'blue';
  pen.move(60, 100, 0);
  pen.move(120, 100, 1);
  pen.art(6);
}

demo4(Pen pen) {
  pen.erase();
  pen.color = 'red';
  pen.move(33, 100, 2);
  pen.color = 'gray';
  pen.move(120, 100, 6);
  pen.color = 'orange';
  pen.move(-60, 100, 4);
  pen.color = 'yellow';
  pen.move(100, 100, 3);
  pen.color = 'blue';
  pen.move(60, 100, 2);
  pen.move(15, 100, 8);
  pen.art(8);
}

demo5(Pen pen) {
  pen.erase();
  pen.color = 'blue';
  pen.left(90);
  pen.forward(100);
  pen.write = 'a';
  pen.right(90);
  pen.forward(30);
  pen.write = '';
  pen.right(90);
  pen.forward(100);
  pen.color = 'black';
  pen.left(90);
  pen.forward(30);
  pen.color = 'red';
  pen.left(90);
  pen.forward(80);
  pen.write = 'b';
  pen.right(90);
  pen.forward(30);
  pen.write = '';
  pen.right(90);
  pen.forward(80);
  pen.color = 'black';
  pen.left(90);
  pen.forward(30);
  pen.color = 'green';
  pen.left(90);
  pen.forward(140);
  pen.write = 'c';
  pen.right(90);
  pen.forward(30);
  pen.write = '';
  pen.right(90);
  pen.forward(140);
  pen.color = 'black';
  pen.left(90);
}

demo6(Pen pen) {
  var colorList = ['blue', 'gray', 'red', 'yellow'];
  multicolorSquare(var size) {
    for (var color in colorList) {
      pen.color = color;
      pen.forward(size);
      pen.left(90);
    }
  }
  pen.erase();
  pen.width = 2;
  var size = 60;
  for (var i in new List(16)) {
    multicolorSquare(size);
    size = size + 10;         // Increase the size for next time
    pen.forward(10);
    pen.right(18);
  }
}

demo7(Pen pen) {
  f1(var length, var depth) {
    if (depth == 0) {
      pen.forward(length);
    } else {
      f1(length/3, depth-1);
      pen.right(60);
      f1(length/3, depth-1);
      pen.left(120);
      f1(length/3, depth-1);
      pen.right(60);
      f1(length/3, depth-1);
    }
  }
  pen.erase();
  f1(240, 4);
  //f1(320, 4);
  //f1(500, 4);
}

demo8(Pen pen) {
  f2(var length, var depth) {
    if (depth == 0) {
      pen.move(0, length);
    } else {
      f2(length/3, depth-1);
      pen.move(60, length);
      f2(length/3, depth-1);
      pen.move(120, length);
      f2(length/3, depth-1);
      pen.move(60, length);
      f2(length/3, depth-1);
    }
  }
  pen.erase();
  f2(240, 4);
}

demo9(Pen pen) {
  tri(num size) {
    pen.forward(size);
    pen.right(120);
    pen.forward(size);
    pen.right(120);
    pen.forward(size);
    pen.right(120);
  }
  pen.erase();
  var max = 40;
  for (var i = 0; i < max; i++) {
    tri(max - i);
    pen.right(i);
    pen.forward(max - i);
  }
}

demo10(Pen pen) {
  pen.erase();
  var max = 500;
  for (var i = 0; i < max; i++) {
    pen.down = false;
    pen.moveToRandom();
    pen.down = true;
    pen.move(45, 2, 0);
  }
}

demo11a(Pen pen) {
  f1() {
    for (var i in [1,2,3,4,5,6]) {
      pen.forward(1);
      pen.move(1, 1, 359);
      pen.right(60);
    }
  }

  f2() {
    for (var i in [1,2,3,4,5,6]) {
      pen.forward(1);
      pen.move(1, 1, 359);
      pen.down = false;
      pen.forward(1);
      pen.move(1, 1, 239);
      pen.down = true;
      pen.right(180);
    }
  }

  f3() {
    for (var i in [1,2,3,4,5,6]) {
      pen.down = false;
      pen.forward(1);
      pen.move(1, 1, 239);
      pen.down = true;
      pen.right(120);
      pen.forward(1);
      pen.move(1, 1, 359);
      pen.left(60);
      pen.forward(1);
      pen.move(1, 1, 359);
      pen.right(120);
    }
  }

  pen.erase();
  f1();
  pen.down = false;
  pen.move(0, 100, 0);
  pen.down = true;
  f2();
  f3();
}

demo11(Pen pen) {
  f1() {
    for (var i = 0; i < 6; i++) {
      pen.go(1, angle: 1, repeat: 359);
      pen.right(60);
    }
  }

  f2() {
    for (var i = 0; i < 6; i++) {
      pen.go(1, angle: 1, repeat: 359);
      pen.skip(1, angle: 1, repeat: 239);
      pen.right(180);
    }
  }

  f3() {
    for (var i = 0; i < 6; i++) {
      pen.skip(1, angle: 1, repeat: 239);
      pen.right(120);
      pen.go(1, angle: 1, repeat: 359);
      pen.left(60);
      pen.go(1, angle: 1, repeat: 359);
      pen.right(120);
    }
  }

  pen.erase();
  f1();
  pen.skip(99);
  f2();
  f3();
}

demo12(Pen pen) {
  f1() {
    for (var i = 0; i < 4; i++) {
      var j = 1;
      pen.go(100, angle: 100 - j++, repeat: 99);
    }
  }

  pen.erase();
  for (var k = 0; k < 8; k++) {
    pen.colorRandom();
    f1();
    pen.moveToRandom();
  }
}

demo13(Pen pen) {
  zig(int level) {
    pen.forward(level * 30);
    var l = level - 1;
    if (l > 0) {
      pen.left(45);
      for (var i = 0; i < 3; i++) {
        pen.colorRandom();
        zig(l);
        pen.right(90);
        pen.forward(level * i);
      }
    }
  }

  pen.erase();
  zig(6);
}

demo14(Pen pen) {
  square() {
    pen.move(90, 100, 3);
  }

  pen.erase();
  for (var k = 0; k < 52; k++) {
    pen.colorRandom();
    square();
    pen.right(10);
  }
}

demo15(Pen pen) {
  star() {
    pen.go(100, angle: 252, repeat: 4);
  }

  pen.erase();
  pen.color = 'yellow';
  for (var k = 0; k < 18; k++) {
    star();
    pen.right(20);
  }
}

demo16(Pen pen) {
  var s = sequence(11);
  pen.erase();
  pen.down = false;
  pen.moveTo(pen.drawingWidth, 0);
  pen.down = true;
  for (var k in s) {
    if (k == 1) {
      pen.forward(4);
    } else if (k == 0) {
      pen.left(60);
    }
  }
}

demo17(Pen pen) {
  var s = sequence(11);
  pen.erase();
  pen.down = false;
  pen.moveTo(0, 0);
  pen.down = true;
  for (var k in s) {
    if (k == 1) {
      pen.forward(1);
    } else if (k == 0) {
      pen.left(120);
    }
  }
}

demo18(Pen pen) {
  var s = sequence(10);
  pen.erase();
  pen.down = false;
  pen.moveTo(pen.drawingWidth, 0);
  pen.down = true;
  for (var k in s) {
    if (k == 1) {
      pen.left(180);
      pen.forward(4);

    } else if (k == 0) {
      pen.left(60);
      pen.forward(4);
    }
  }
}

demo19(Pen pen) {
  var s = sequence(10);
  pen.erase();
  pen.down = false;
  pen.moveTo(0, 0);
  pen.down = true;
  for (var k in s) {
    if (k == 1) {
      pen.left(180);
      pen.forward(8);
    } else if (k == 0) {
      pen.left(120);
      pen.forward(8);
    }
  }
}

demo20(Pen pen) {
  var s = sequence(10);
  pen.erase();
  pen.down = false;
  pen.moveTo(0, pen.drawingHeight);
  pen.down = true;
  for (var k in s) {
    if (k == 1) {
      pen.left(180);
    } else if (k == 0) {
      pen.left(15);
      pen.forward(10);
    }
  }
}

demo21(Pen pen) {
  var s = sequence(10);
  pen.erase();
  pen.down = false;
  pen.moveTo(0, pen.drawingHeight/2);
  pen.down = true;
  for (var k in s) {
    if (k == 1) {
      pen.forward(4);
      pen.left(60);
    } else if (k == 0) {
      pen.left(180);
    }
  }
}


















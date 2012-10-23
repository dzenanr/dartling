//part of art_pen;

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

randomDemo(Pen pen, [int artCount = 4]) {
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
    default:
      randomDemo(pen);
  }
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
  var commandsString = 'color, red; move, 45, 80, 1; width, 3; color, yellow; '
                       'move, 50, 80, 1; width, 2; color, blue; '
                       'move, 65, 80, 1; down, false; moveTo, 333, 333; '
                       'down, true; move, 15, 120, 4; art, 7';
  pen.erase();
  pen.interpret(commandsString);
}

demo7(Pen pen) {
  var commandsString = '''
    color, red; width, 2; move, 15, 160, 2; 
    color, green; width, 1; move, -45, 200, 3; move, 66, 80, 6; 
    color, brown;  width, 2; move, -20, 40, 8; 
    art, 6;
''';
  pen.erase();
  pen.interpret(commandsString);
}

demo8(Pen pen) {
  var commandsString = '''
    color, gray; 
    width, 2; 
    move, 45, 80, 1; 
    color, green; 
    width, 1; 
    move, 33, 80, 1; 
    color, orange;  
    width, 3; 
    move, 15, 80, 1; 
    move, 90, 80, 4; 
    art, 5;
  ''';
  pen.erase();
  pen.interpret(commandsString);
}

demo9(Pen pen) {
  var commandsString =
    'color, yellow; '
    'width, 3; '
    'move, 80, 80, 3; '
    'color, gray; '
    'width, 1; '
    'move, -18, 60, 6; '
    'color, blue; '
    'width, 2; '
    'move, 120, 100, 5; '
    'move, 5, -80, 9; '
    'art, 4';
  pen.erase();
  pen.interpret(commandsString);
}

demo10(Pen pen) {
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

demo11(Pen pen) {
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

demo12(Pen pen) {
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

demo13(Pen pen) {
  var commands = '''
    move, 42.01246604295291, -1.142012567612971, 1;
    move, 48.52620034897903, 43.14868290189112, 28;
    color, brown;
    move, 29.06482878482821, 51.560819096097134, 17;
    art, 6;
    move, 1.2732170133395448, 97.7458238280595, 35;
    moveTo, 39.37073653231643, 66.97052551259245;
    move, 39.01482992912967, 17.558562873382634, 10;
    color, black;
    move, 18.02374525564643, 36.826835199825545, 1;
  ''';
  pen.erase();
  pen.interpret(commands);
}

demo14(Pen pen) {
  var commands = '''
    color, gray;
    move, 0, 45.66565312845289, 0;
    move, -99.38460907562418, 92.87422111341486, 1;
    move, 75.98250546328629, 0, 0;
    color, blue;
    move, 0, 42.80726019177635, 0;
    move, 0, 64.7614818513695, 0;
    color, gray;
    art, 5;
    width, 5;
    moveTo, 61.814343366788414, 84.41862729966128;
    color, green;
    move, -84.33745375108191, 16.456424645201594, 16;
    move, 95.9475652149315, 25.807066659237744, 2;
    move, 61.67024789315273, -26.563942514476878, 12;
    moveTo, 70.35186397400587, 3.0725338294673943;
    color, orange;
    move, 42.44470594293037, 95.60803984993771, 1;
    width, 7;
    move, 6.276786796185507, 17.144485081156024, 3;
    color, gray;
    move, -77.29213408881598, 39.95947369130499, 31;
    color, orange;
    move, 9.000324536252169, 0, 0;
    move, 42.04681030385875, 13.687720992555574, 1;
    width, 1;
    move, 44.62764519729795, 39.21123290012656, 7;
    move, 47.098441319902484, 40.914600556427885, 3;
    width, 1;
    color, orange;
    move, 81.66318136219168, 0, 0;
    color, gray;
  ''';
  pen.erase();
  pen.interpret(commands);
}

demo15(Pen pen) {
  var commands = '''
    move, 44.95256637472088, 48.13786299342821, 34;
    width, 6;
    move, 53.38205217427732, 0.21820327816437501, 31;
    color, red;
    move, -42.989494026940314, 89.00936065576082, 31;
    color, white;
    width, 4;
    move, 9.425757530379354, 71.25089566386113, 3;
    color, red;
    move, 0.0, 48.8225280765833, 0;
    color, green;
    move, 16.443267342768632, 0.0, 0;
    move, 86.62641849775139, 45.164164084321314, 33;
    move, -76.84238338732095, 0.0, 0;
    move, 0.0, -72.26757704344567, 0;
    move, -58.75264895350127, 0.0, 0;
    move, 0.0, 16.43693436425957, 0;
    art, 5;
  ''';
  pen.erase();
  pen.interpret(commands);
}

demo16(Pen pen) {
  var commands = '''
    move, 49.60172122810036, 4.888942162506282, 8;
    move, 20.86279431823641, 52.99268572125584, 12;
    color, gray;
    move, 56.694106850773096, 27.524887723848224, 7;
    move, 27.597979735583067, 53.447500918991864, 4;
    color, brown;
    move, 74.37689632643014, 7.960581453517079, 32;
    move, 0, -10.682069044560194, 0;
    width, 2;
    art, 7;
  ''';
  pen.erase();
  pen.interpret(commands);
}















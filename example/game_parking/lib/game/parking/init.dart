part of game_parking;

// repo/code/specific/game/parking/init.dart

initGameParking(var entries) {
  _initBrands(entries);
  _initAreas(entries);
}

_initBrands(var entries) {
  Brand carBrandA = new Brand.withId(entries.brands.concept, 'A');
  carBrandA.length = 2;
  carBrandA.colorName = 'green';
  carBrandA.color = '#66CC99';
  carBrandA.red = 102;
  carBrandA.green = 204;
  carBrandA.blue = 153;
  entries.brands.add(carBrandA);

  Brand carBrandB = new Brand.withId(entries.brands.concept, 'B');
  carBrandB.length = 2;
  carBrandB.colorName = 'orange';
  carBrandB.color = '#FFCC66';
  carBrandB.red = 255;
  carBrandB.green = 204;
  carBrandB.blue = 102;
  entries.brands.add(carBrandB);

  Brand carBrandC = new Brand.withId(entries.brands.concept, 'C');
  carBrandC.length = 2;
  carBrandC.colorName = 'cyan';
  carBrandC.color = '#00FFFF';
  carBrandC.red = 0;
  carBrandC.green = 255;
  carBrandC.blue = 255;
  entries.brands.add(carBrandC);

  Brand carBrandD = new Brand.withId(entries.brands.concept, 'D');
  carBrandD.length = 2;
  carBrandD.colorName = 'light pink';
  carBrandD.color = '#FF99CC';
  carBrandD.red = 255;
  carBrandD.green = 153;
  carBrandD.blue = 204;
  entries.brands.add(carBrandD);

  Brand carBrandE = new Brand.withId(entries.brands.concept, 'E');
  carBrandE.length = 2;
  carBrandE.colorName = 'dark magenta';
  carBrandE.color = '#660033';
  carBrandE.red = 102;
  carBrandE.green = 0;
  carBrandE.blue = 51;
  entries.brands.add(carBrandE);

  Brand carBrandF = new Brand.withId(entries.brands.concept, 'F');
  carBrandF.length = 2;
  carBrandF.colorName = 'dark green';
  carBrandF.color = '#009966';
  carBrandF.red = 0;
  carBrandF.green = 153;
  carBrandF.blue = 102;
  entries.brands.add(carBrandF);

  Brand carBrandG = new Brand.withId(entries.brands.concept, 'G');
  carBrandG.length = 2;
  carBrandG.colorName = 'gray';
  carBrandG.color = '#BEBEBE';
  carBrandG.red = 190;
  carBrandG.green = 190;
  carBrandG.blue = 190;
  entries.brands.add(carBrandG);

  Brand carBrandH = new Brand.withId(entries.brands.concept, 'H');
  carBrandH.length = 2;
  carBrandH.colorName = 'peach';
  carBrandH.color = '#FF9966';
  carBrandH.red = 255;
  carBrandH.green = 153;
  carBrandH.blue = 102;
  entries.brands.add(carBrandH);

  Brand carBrandI = new Brand.withId(entries.brands.concept, 'I');
  carBrandI.length = 2;
  carBrandI.colorName = 'light gray';
  carBrandI.color = '#D3D3D3';
  carBrandI.red = 211;
  carBrandI.green = 211;
  carBrandI.blue = 211;
  entries.brands.add(carBrandI);

  Brand carBrandJ = new Brand.withId(entries.brands.concept, 'J');
  carBrandJ.length = 2;
  carBrandJ.colorName = 'brown';
  carBrandJ.color = '#996600';
  carBrandJ.red = 153;
  carBrandJ.green = 102;
  carBrandJ.blue = 0;
  entries.brands.add(carBrandJ);

  Brand carBrandK = new Brand.withId(entries.brands.concept, 'K');
  carBrandK.length = 2;
  carBrandK.colorName = 'mustard';
  carBrandK.color = '#CC9900';
  carBrandK.red = 204;
  carBrandK.green = 153;
  carBrandK.blue = 0;
  entries.brands.add(carBrandK);

  Brand carBrandO = new Brand.withId(entries.brands.concept, 'O');
  carBrandO.length = 3;
  carBrandO.colorName = 'light yellow';
  carBrandO.color = '#FFFF99';
  carBrandO.red = 255;
  carBrandO.green = 255;
  carBrandO.blue = 153;
  entries.brands.add(carBrandO);

  Brand carBrandP = new Brand.withId(entries.brands.concept, 'P');
  carBrandP.length = 3;
  carBrandP.colorName = 'magenta';
  carBrandP.color = '#993366';
  carBrandP.red = 153;
  carBrandP.green = 51;
  carBrandP.blue = 102;
  entries.brands.add(carBrandP);

  Brand carBrandQ = new Brand.withId(entries.brands.concept, 'Q');
  carBrandQ.length = 3;
  carBrandQ.colorName = 'gray blue';
  carBrandQ.color = '#6699CC';
  carBrandQ.red = 102;
  carBrandQ.green = 153;
  carBrandQ.blue = 204;
  entries.brands.add(carBrandQ);

  Brand carBrandR = new Brand.withId(entries.brands.concept, 'R');
  carBrandR.length = 3;
  carBrandR.colorName = 'deep sky blue';
  carBrandR.color = '#00BFFF';
  carBrandR.red = 0;
  carBrandR.green = 191;
  carBrandR.blue = 255;
  entries.brands.add(carBrandR);

  Brand carBrandX = new Brand.withId(entries.brands.concept, 'X');
  carBrandX.length = 2;
  carBrandX.colorName = 'red';
  carBrandX.color = '#CC0033';
  carBrandX.red = 204;
  carBrandX.green = 0;
  carBrandX.blue = 51;
  entries.brands.add(carBrandX);
}

_initAreas(var entries) {
  Area area1 = new Area.withId(entries.areas.concept, 'beginner');
  entries.areas.add(area1);
  _initParkingsOfBeginnerArea(entries, area1);

  Area area2 = new Area.withId(entries.areas.concept, 'intermediate');
  entries.areas.add(area2);
  _initParkingsOfIntermediateArea(entries, area2);
}

_initParkingsOfBeginnerArea(var entries, Area area) {
  assert(area != null);
  assert(area.parkings != null);
  assert(entries.parkings != null);
  Parking parking1 = new Parking.withId(entries.parkings.concept, area, 1);
  entries.parkings.add(parking1);
  area.parkings.add(parking1);
  _initCarsOfParkingOneOfBeginnerArea(entries, parking1);

  Parking parking2 = new Parking.withId(entries.parkings.concept, area, 2);
  entries.parkings.add(parking2);
  area.parkings.add(parking2);
  _initCarsOfParkingTwoOfBeginnerArea(entries, parking2);
}

_initParkingsOfIntermediateArea(var entries, Area area) {
  assert(area != null);
  assert(area.parkings != null);
  assert(entries.parkings != null);
  Parking parking1 = new Parking.withId(entries.parkings.concept, area, 1);
  entries.parkings.add(parking1);
  area.parkings.add(parking1);
  _initCarsOfParkingOneOfIntermediateArea(entries, parking1);

  Parking parking2 = new Parking.withId(entries.parkings.concept, area, 2);
  entries.parkings.add(parking2);
  area.parkings.add(parking2);
  _initCarsOfParkingTwoOfIntermediateArea(entries, parking2);
}

_initCarsOfParkingOneOfBeginnerArea(var entries, Parking parking) {
  Concept carConcept = entries.getConcept('Car');
  Brand carBrandA = entries.brands.getBrand('A');
  if (carBrandA != null) {
    Car car1A = new Car.withId(carConcept, parking, carBrandA);
    car1A.orientation = 'horizontal';
    car1A.startRow = 0;
    car1A.startColumn = 0;
    parking.cars.add(car1A);
    assert(carBrandA.cars != null);
    carBrandA.cars.add(car1A);
  }

  Brand carBrandB = entries.brands.getBrand('B');
  if (carBrandB != null) {
    Car car1B = new Car.withId(carConcept, parking, carBrandB);
    car1B.orientation = 'vertical';
    car1B.startRow = 4;
    car1B.startColumn = 0;
    parking.cars.add(car1B);
    carBrandB.cars.add(car1B);
  }

  Brand carBrandC = entries.brands.getBrand('C');
  if (carBrandC != null) {
    Car car1C = new Car.withId(carConcept, parking, carBrandC);
    car1C.orientation = 'horizontal';
    car1C.startRow = 4;
    car1C.startColumn = 4;
    parking.cars.add(car1C);
    carBrandC.cars.add(car1C);
  }

  Brand carBrandO = entries.brands.getBrand('O');
  if (carBrandO != null) {
    Car car1O = new Car.withId(carConcept, parking, carBrandO);
    car1O.orientation = 'vertical';
    car1O.startRow = 0;
    car1O.startColumn = 5;
    parking.cars.add(car1O);
    carBrandO.cars.add(car1O);
  }

  Brand carBrandP = entries.brands.getBrand('P');
  if (carBrandP != null) {
    Car car1P = new Car.withId(carConcept, parking, carBrandP);
    car1P.orientation = 'vertical';
    car1P.startRow = 1;
    car1P.startColumn = 0;
    parking.cars.add(car1P);
    carBrandP.cars.add(car1P);
  }

  Brand carBrandQ = entries.brands.getBrand('Q');
  if (carBrandQ != null) {
    Car car1Q = new Car.withId(carConcept, parking, carBrandQ);
    car1Q.orientation = 'vertical';
    car1Q.startRow = 1;
    car1Q.startColumn = 3;
    parking.cars.add(car1Q);
    carBrandQ.cars.add(car1Q);
  }

  Brand carBrandR = entries.brands.getBrand('R');
  if (carBrandR != null) {
    Car car1R = new Car.withId(carConcept, parking, carBrandR);
    car1R.orientation = 'horizontal';
    car1R.startRow = 5;
    car1R.startColumn = 2;
    parking.cars.add(car1R);
    carBrandR.cars.add(car1R);
  }

  Brand carBrandX = entries.brands.getBrand('X');
  if (carBrandX != null) {
    Car car1X = new Car.withId(carConcept, parking, carBrandX);
    car1X.orientation = 'horizontal';
    car1X.startRow = 2;
    car1X.startColumn = 1;
    parking.cars.add(car1X);
    carBrandX.cars.add(car1X);
  }
}

_initCarsOfParkingTwoOfBeginnerArea(var entries, Parking parking) {
  Concept carConcept = entries.getConcept('Car');
  Brand carBrandA = entries.brands.getBrand('A');
  if (carBrandA != null) {
    Car car1A = new Car.withId(carConcept, parking, carBrandA);
    car1A.orientation = 'vertical';
    car1A.startRow = 0;
    car1A.startColumn = 0;
    parking.cars.add(car1A);
    carBrandA.cars.add(car1A);
  }

  Brand carBrandB = entries.brands.getBrand('B');
  if (carBrandB != null) {
    Car car1B = new Car.withId(carConcept, parking, carBrandB);
    car1B.orientation = 'vertical';
    car1B.startRow = 1;
    car1B.startColumn = 3;
    parking.cars.add(car1B);
    carBrandB.cars.add(car1B);
  }

  Brand carBrandC = entries.brands.getBrand('C');
  if (carBrandC != null) {
    Car car1C = new Car.withId(carConcept, parking, carBrandC);
    car1C.orientation = 'vertical';
    car1C.startRow = 2;
    car1C.startColumn = 4;
    parking.cars.add(car1C);
    carBrandC.cars.add(car1C);
  }

  Brand carBrandD = entries.brands.getBrand('D');
  if (carBrandD != null) {
    Car car1D = new Car.withId(carConcept, parking, carBrandD);
    car1D.orientation = 'vertical';
    car1D.startRow = 4;
    car1D.startColumn = 2;
    parking.cars.add(car1D);
    carBrandD.cars.add(car1D);
  }

  Brand carBrandE = entries.brands.getBrand('E');
  if (carBrandE != null) {
    Car car1E = new Car.withId(carConcept, parking, carBrandE);
    car1E.orientation = 'horizontal';
    car1E.startRow = 4;
    car1E.startColumn = 4;
    parking.cars.add(car1E);
    carBrandE.cars.add(car1E);
  }

  Brand carBrandF = entries.brands.getBrand('F');
  if (carBrandF != null) {
    Car car1F = new Car.withId(carConcept, parking, carBrandF);
    car1F.orientation = 'horizontal';
    car1F.startRow = 5;
    car1F.startColumn = 0;
    parking.cars.add(car1F);
    carBrandF.cars.add(car1F);
  }

  Brand carBrandG = entries.brands.getBrand('G');
  if (carBrandG != null) {
    Car car1G = new Car.withId(carConcept, parking, carBrandG);
    car1G.orientation = 'horizontal';
    car1G.startRow = 5;
    car1G.startColumn = 3;
    parking.cars.add(car1G);
    carBrandG.cars.add(car1G);
  }

  Brand carBrandO = entries.brands.getBrand('O');
  if (carBrandO != null) {
    Car car1O = new Car.withId(carConcept, parking, carBrandO);
    car1O.orientation = 'horizontal';
    car1O.startRow = 0;
    car1O.startColumn = 3;
    parking.cars.add(car1O);
    carBrandO.cars.add(car1O);
  }

  Brand carBrandP = entries.brands.getBrand('P');
  if (carBrandP != null) {
    Car car1P = new Car.withId(carConcept, parking, carBrandP);
    car1P.orientation = 'vertical';
    car1P.startRow = 1;
    car1P.startColumn = 5;
    parking.cars.add(car1P);
    carBrandP.cars.add(car1P);
  }

  Brand carBrandQ = entries.brands.getBrand('Q');
  if (carBrandQ != null) {
    Car car1Q = new Car.withId(carConcept, parking, carBrandQ);
    car1Q.orientation = 'horizontal';
    car1Q.startRow = 3;
    car1Q.startColumn = 0;
    parking.cars.add(car1Q);
    carBrandQ.cars.add(car1Q);
  }

  Brand carBrandX = entries.brands.getBrand('X');
  if (carBrandX != null) {
    Car car1X = new Car.withId(carConcept, parking, carBrandX);
    car1X.orientation = 'horizontal';
    car1X.startRow = 2;
    car1X.startColumn = 0;
    parking.cars.add(car1X);
    carBrandX.cars.add(car1X);
  }
}

_initCarsOfParkingOneOfIntermediateArea(var entries, Parking parking) {
  Concept carConcept = entries.getConcept('Car');
  Brand carBrandA = entries.brands.getBrand('A');
  if (carBrandA != null) {
    Car car1A = new Car.withId(carConcept, parking, carBrandA);
    car1A.orientation = 'horizontal';
    car1A.startRow = 0;
    car1A.startColumn = 1;
    parking.cars.add(car1A);
    carBrandA.cars.add(car1A);
  }

  Brand carBrandB = entries.brands.getBrand('B');
  if (carBrandB != null) {
    Car car1B = new Car.withId(carConcept, parking, carBrandB);
    car1B.orientation = 'vertical';
    car1B.startRow = 3;
    car1B.startColumn = 2;
    parking.cars.add(car1B);
    carBrandB.cars.add(car1B);
  }

  Brand carBrandE = entries.brands.getBrand('E');
  if (carBrandE != null) {
    Car car1E = new Car.withId(carConcept, parking, carBrandE);
    car1E.orientation = 'vertical';
    car1E.startRow = 4;
    car1E.startColumn = 5;
    parking.cars.add(car1E);
    carBrandE.cars.add(car1E);
  }

  Brand carBrandO = entries.brands.getBrand('O');
  if (carBrandO != null) {
    Car car1O = new Car.withId(carConcept, parking, carBrandO);
    car1O.orientation = 'vertical';
    car1O.startRow = 0;
    car1O.startColumn = 0;
    parking.cars.add(car1O);
    carBrandO.cars.add(car1O);
  }

  Brand carBrandP = entries.brands.getBrand('P');
  if (carBrandP != null) {
    Car car1P = new Car.withId(carConcept, parking, carBrandP);
    car1P.orientation = 'vertical';
    car1P.startRow = 0;
    car1P.startColumn = 3;
    parking.cars.add(car1P);
    carBrandP.cars.add(car1P);
  }

  Brand carBrandQ = entries.brands.getBrand('Q');
  if (carBrandQ != null) {
    Car car1Q = new Car.withId(carConcept, parking, carBrandQ);
    car1Q.orientation = 'horizontal';
    car1Q.startRow = 3;
    car1Q.startColumn = 3;
    parking.cars.add(car1Q);
    carBrandQ.cars.add(car1Q);
  }

  Brand carBrandR = entries.brands.getBrand('R');
  if (carBrandR != null) {
    Car car1R = new Car.withId(carConcept, parking, carBrandR);
    car1R.orientation = 'horizontal';
    car1R.startRow = 5;
    car1R.startColumn = 2;
    parking.cars.add(car1R);
    carBrandR.cars.add(car1R);
  }

  Brand carBrandX = entries.brands.getBrand('X');
  if (carBrandX != null) {
    Car car1X = new Car.withId(carConcept, parking, carBrandX);
    car1X.orientation = 'horizontal';
    car1X.startRow = 2;
    car1X.startColumn = 1;
    parking.cars.add(car1X);
    carBrandX.cars.add(car1X);
  }
}

_initCarsOfParkingTwoOfIntermediateArea(var entries, Parking parking) {
  Concept carConcept = entries.getConcept('Car');
  Brand carBrandA = entries.brands.getBrand('A');
  if (carBrandA != null) {
    Car car1A = new Car.withId(carConcept, parking, carBrandA);
    car1A.orientation = 'vertical';
    car1A.startRow = 0;
    car1A.startColumn = 0;
    parking.cars.add(car1A);
    carBrandA.cars.add(car1A);
  }

  Brand carBrandB = entries.brands.getBrand('B');
  if (carBrandB != null) {
    Car car1B = new Car.withId(carConcept, parking, carBrandB);
    car1B.orientation = 'horizontal';
    car1B.startRow = 0;
    car1B.startColumn = 1;
    parking.cars.add(car1B);
    carBrandB.cars.add(car1B);
  }

  Brand carBrandC = entries.brands.getBrand('C');
  if (carBrandC != null) {
    Car car1C = new Car.withId(carConcept, parking, carBrandC);
    car1C.orientation = 'vertical';
    car1C.startRow = 4;
    car1C.startColumn = 4;
    parking.cars.add(car1C);
    carBrandC.cars.add(car1C);
  }

  Brand carBrandO = entries.brands.getBrand('O');
  if (carBrandO != null) {
    Car car1O = new Car.withId(carConcept, parking, carBrandO);
    car1O.orientation = 'vertical';
    car1O.startRow = 0;
    car1O.startColumn = 5;
    parking.cars.add(car1O);
    carBrandO.cars.add(car1O);
  }

  Brand carBrandP = entries.brands.getBrand('P');
  if (carBrandP != null) {
    Car car1P = new Car.withId(carConcept, parking, carBrandP);
    car1P.orientation = 'vertical';
    car1P.startRow = 1;
    car1P.startColumn = 2;
    parking.cars.add(car1P);
    carBrandP.cars.add(car1P);
  }

  Brand carBrandQ = entries.brands.getBrand('Q');
  if (carBrandQ != null) {
    Car car1Q = new Car.withId(carConcept, parking, carBrandQ);
    car1Q.orientation = 'horizontal';
    car1Q.startRow = 3;
    car1Q.startColumn = 3;
    parking.cars.add(car1Q);
    carBrandQ.cars.add(car1Q);
  }

  Brand carBrandR = entries.brands.getBrand('R');
  if (carBrandR != null) {
    Car car1R = new Car.withId(carConcept, parking, carBrandR);
    car1R.orientation = 'horizontal';
    car1R.startRow = 5;
    car1R.startColumn = 0;
    parking.cars.add(car1R);
    carBrandR.cars.add(car1R);
  }

  Brand carBrandX = entries.brands.getBrand('X');
  if (carBrandX != null) {
    Car car1X = new Car.withId(carConcept, parking, carBrandX);
    car1X.orientation = 'horizontal';
    car1X.startRow = 2;
    car1X.startColumn = 0;
    parking.cars.add(car1X);
    carBrandX.cars.add(car1X);
  }
}





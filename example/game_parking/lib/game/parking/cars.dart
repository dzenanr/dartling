part of game_parking;

// data/game/parking/cars.dart

class Car extends CarGen {

  Car(Concept concept) : super(concept);

  Car.withId(Concept concept, Parking parking, Brand brand) :
    super.withId(concept, parking, brand);

  set startRow(int a) {
    super.startRow = a;
    currentRow = a;
  }

  set startColumn(int a) {
    super.startColumn = a;
    currentColumn = a;
  }

  bool inCell(int row, int column) {
    if (currentRow == row && currentColumn == column) {
      return true;
    } else if (orientation == 'horizontal' && brand.length == 2) {
      if (currentRow == row && currentColumn == column - 1) {
        return true;
      }
    } else if (orientation == 'horizontal' && brand.length == 3) {
      if (currentRow == row && (currentColumn == column - 1 || currentColumn == column - 2)) {
        return true;
      }
    } else if (orientation == 'vertical' && brand.length == 2) {
      if (currentRow == row - 1 && currentColumn == column) {
        return true;
      }
    } else if (orientation == 'vertical' && brand.length == 3) {
      if ((currentRow == row - 1 || currentRow == row - 2) && currentColumn == column) {
        return true;
      }
    }
    return false;
  }

  bool afterCell(int row, int column) {
    if (orientation == 'horizontal') {
      if (currentRow == row && currentColumn == column + 1) {
        return true;
      }
    } else if (orientation == 'vertical') {
      if (currentRow == row + 1 && currentColumn == column) {
        return true;
      }
    }
    return false;
  }

  bool beforeCell(int row, int column) {
    if (orientation == 'horizontal') {
      if (currentRow == row && brand.length == 2 && currentColumn == column - 2) {
        return true;
      } else if (currentRow == row && brand.length == 3 && currentColumn == column - 3) {
        return true;
      }
    } else if (orientation == 'vertical') {
      if (currentRow == row - 2 && brand.length == 2 && currentColumn == column) {
        return true;
      } else if (currentRow == row - 3 && brand.length == 3 && currentColumn == column) {
        return true;
      }
    }
    return false;
  }

  bool afterOrBeforeCell(int row, int column) {
    return afterCell(row, column) || beforeCell(row, column);
  }

  moveToOrTowardCell(int row, int column) {
    if (afterCell(row, column)) {
      currentRow = row;
      currentColumn = column;
    } else if (beforeCell(row, column)) {
      if (orientation == 'horizontal') {
        currentColumn = currentColumn + 1;
      } else if (orientation == 'vertical') {
        currentRow = currentRow + 1;
      }
    }
  }

}

class Cars extends CarsGen {

  Cars(Concept concept) : super(concept);

  void deselect() {
    for (Car car in this) {
      car.selected = false;
    }
  }

  Car getSelectedCar() {
    for (Car car in this) {
      if (car.selected) {
        return car;
      }
    }
  }

}




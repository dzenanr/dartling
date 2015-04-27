part of game_parking_app;

class Board {

  // The board is redrawn every INTERVAL ms.
  static const int INTERVAL = 8;

  static final int LINE_WIDTH = 1;
  static final String LINE_COLOR = '#000000'; // black
  static final int SSS = 8; // selection square size

  static final int ROWS_COUNT = 6;
  static final int COLUMNS_COUNT = 6;

  CanvasElement canvas;
  CanvasRenderingContext2D context;

  int width;
  int height;
  int cellWidth;
  int cellHeight;

  ParkingEntries entries;
  Area _currentArea;
  Parking _currentParking;

  MenuBar menuBar;
  ActionPanel actionPanel;

  Board(this.canvas, GameRepo gameParkingRepo) {
    context = canvas.getContext('2d');
    width = canvas.width;
    height = canvas.height;
    cellWidth = width ~/ COLUMNS_COUNT;
    cellHeight = height ~/ ROWS_COUNT;

    menuBar = new MenuBar(this);
    actionPanel = new ActionPanel(this);

    var models = gameParkingRepo.getDomainModels('Game');
    entries = models.getModelEntries('Parking');
    currentArea = entries.areas.getArea('beginner');
    currentParking = currentArea.parkings.getParkingWithinArea(1);

    // Canvas event.
    document.querySelector('#canvas').onMouseDown.listen(onMouseDown);
    // Redraw every INTERVAL ms.
    new Timer.periodic(const Duration(milliseconds: INTERVAL),
        (t) => redraw());
  }

  set currentArea(Area area) {
    _currentArea = area;
    currentParking = area.parkings.getParkingWithinArea(1);
    actionPanel.displayCurrentArea();
  }

  Area get currentArea {
    return _currentArea;
  }

  set currentParking(Parking parking) {
    _currentParking = parking;
    actionPanel.displayCurrentParking();
  }

  Parking get currentParking {
    return _currentParking;
  }

  redraw() {
    clear();
    displayCars();
  }

  restart() {
    for (Car car in currentParking.cars) {
      car.currentRow = car.startRow;
      car.currentColumn = car.startColumn;
      car.selected = false;
    }
  }

  clear() {
    context.clearRect(0, 0, width, height);
  }

  border() {
    context.beginPath();
    context.rect(0, 0, width, height);
    context.lineWidth = LINE_WIDTH;
    context.strokeStyle = LINE_COLOR;
    context.stroke();
    context.closePath();
  }

  displayCars() {
    for (Car car in currentParking.cars) {
      displayCar(car);
    }
  }

  displayCar(Car car) {
    context.beginPath();
    int row = car.currentRow;
    int column = car.currentColumn;
    int x = column * cellWidth;
    int y = row * cellHeight;
    int carLength = car.brand.length;
    int carWidth = cellWidth;
    int carHeight = cellHeight;
    if (car.orientation == 'horizontal') {
      carWidth = cellWidth * carLength;
    } else {
      carHeight = cellHeight * carLength;
    }
    context.lineWidth = LINE_WIDTH;
    context.strokeStyle = LINE_COLOR;
    context.fillStyle = car.brand.color;
    context.fillRect(x, y , carWidth, carHeight);
    if (car.selected) {
      context.rect(x, y, SSS, SSS);
      context.rect(x + carWidth - SSS, y, SSS, SSS);
      context.rect(x + carWidth - SSS, y + carHeight - SSS, SSS, SSS);
      context.rect(x, y + carHeight - SSS, SSS, SSS);
    }
    context.stroke();
    context.closePath();
  }

  Car getCarInCell(int row, int column) {
    for (Car car in currentParking.cars) {
      if (car.inCell(row, column)) {
        return car;
      }
    }
    return null;
  }

  Car getSelectedCarAfterOrBeforeCell(int row, int column) {
    for (Car car in currentParking.cars) {
      if (car.selected && car.afterOrBeforeCell(row, column)) {
        return car;
      }
    }
    return null;
  }

  onMouseDown(MouseEvent e) {
    int row = e.offset.y ~/ cellHeight;
    int column = e.offset.x ~/ cellWidth;
    Car car = getCarInCell(row, column);
    if (car != null) {
      currentParking.cars.deselect();
      car.selected = true;
    } else {
      car = getSelectedCarAfterOrBeforeCell(row, column);
      if (car != null) {
        car.moveToOrTowardCell(row, column);
        if (car.brand.name == 'X' && car.currentColumn ==
            COLUMNS_COUNT - car.brand.length) {
          car.currentColumn = COLUMNS_COUNT; // the car exits the parking
        }
      }
    }
  }

}

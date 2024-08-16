int coordinateToIndex((int, int) position) {
  final index = position.$1 * 8 + position.$2;
  return index;
}

(int, int) indexToCoordinate(int index) {
  final x = index % 8;
  final y = index ~/ 8;
  return (y, x);
}

bool isValidPosition(int col, int row) {
  if (row >= 0 && row < 8 && col >= 0 && col < 8) {
    return true;
  }
  return false;
}

class ShipModel {
  final int id;
  final int length;
  final (int, int) direction;
  final List<int> positions;
  final bool isLocationSet;

  ShipModel({
    required this.id,
    required this.length,
    required this.positions,
    this.direction = (1, 0),
    this.isLocationSet = false,
  });

  ShipModel changeDirection((int, int) newDirection) {
    return ShipModel(
      id: id,
      length: length,
      direction: newDirection,
      positions: positions,
      isLocationSet: isLocationSet,
    );
  }

  ShipModel changeIsLocationSet(bool value) {
    return ShipModel(
      id: id,
      length: length,
      direction: direction,
      positions: positions,
      isLocationSet: value,
    );
  }

  ShipModel changePositions(List<int> newPositions) {
    
    return ShipModel(
      id: id,
      length: length,
      direction: direction,
      positions: newPositions,
      isLocationSet: isLocationSet,
    );
  }

  (int, int) getStartPosition() {
    if (positions.isNotEmpty) {
      return indexToCoordinate(positions.first);
    } else {
      return (0, 0);
    }
  }
}

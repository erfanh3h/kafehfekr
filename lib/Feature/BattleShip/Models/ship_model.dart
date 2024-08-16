int coordinateToIndex((int, int) position) {
  final index = position.$1 * 8 + position.$2;
  return index;
}

(int, int) indexToCoordinate(int index) {
  final x = index % 8;
  final y = index ~/ 8;
  return (y, x);
}

class ShipModel {
  final int id;
  final int length;
  final (int, int) direction;
  final List<int> positions;

  ShipModel({
    required this.id,
    required this.length,
    required this.positions,
    this.direction = (-1, 0),
  });

  ShipModel changeDirection((int, int) newDirection) {
    return ShipModel(
      id: id,
      length: length,
      direction: newDirection,
      positions: positions,
    );
  }

  ShipModel changePositions(List<int> newPositions) {
    return ShipModel(
      id: id,
      length: length,
      direction: direction,
      positions: newPositions,
    );
  }

  (int, int) getStartPosition() {
    return indexToCoordinate(positions.first);
  }
}

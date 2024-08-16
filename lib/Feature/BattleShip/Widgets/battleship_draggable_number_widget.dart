import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Feature/BattleShip/Models/ship_model.dart';

import 'dart:math' as math;

class BattleShipDraggableWidget extends StatelessWidget {
  const BattleShipDraggableWidget({
    super.key,
    required this.ship,
  });

  final ShipModel ship;

  @override
  Widget build(BuildContext context) {
    double heightSize = 0;
    double widthSize = 20;
    heightSize += (ship.length * 42);
    (int, int) startPosition = ship.getStartPosition();
    return Positioned(
      right: (41 * startPosition.$2.toDouble()) + 11,
      top: 41 * startPosition.$1.toDouble(),
      child: Transform.rotate(
        angle: 2 * math.pi,
        child: Draggable<ShipModel>(
          data: ship,
          feedback: Container(
            width: widthSize,
            height: heightSize,
            decoration: BoxDecoration(
              color: AppColors.goldenColor,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          childWhenDragging: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white.withOpacity(0.4),
            ),
            width: widthSize,
            height: heightSize,
          ),
          onDraggableCanceled: (_, __) {},
          child: Container(
            width: widthSize,
            height: heightSize,
            decoration: BoxDecoration(
              color: AppColors.goldenColor,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}

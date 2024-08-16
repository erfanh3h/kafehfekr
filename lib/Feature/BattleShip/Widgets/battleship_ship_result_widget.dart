import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Feature/BattleShip/Models/ship_model.dart';

import 'dart:math' as math;

class BattleShipShipResultWidget extends StatelessWidget {
  const BattleShipShipResultWidget({
    super.key,
    required this.ship,
    required this.onRemove,
  });

  final ShipModel ship;
  final Function(ShipModel) onRemove;

  @override
  Widget build(BuildContext context) {
    double heightSize = 0;
    double widthSize = 20;
    heightSize += (ship.length * 42);
    (int, int) startPosition = ship.getStartPosition();
    return ship.isLocationSet
        ? Positioned(
            left: (42 * startPosition.$2.toDouble()) + 10,
            top: 42 * startPosition.$1.toDouble(),
            child: InkWell(
              onTap: () => onRemove(ship),
              child: Transform.rotate(
                angle: 2 * math.pi,
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
          )
        : Container();
  }
}

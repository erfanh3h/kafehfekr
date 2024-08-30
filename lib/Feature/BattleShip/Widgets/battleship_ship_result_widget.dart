import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
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
    double rotation = 0;
    Offset offset = const Offset(0, 0);
    switch (ship.direction) {
      case (1, 0):
        rotation = 2 * math.pi;
        break;
      case (0, 1):
        rotation = math.pi / 2;
        offset =
            Offset(22 + (-(ship.length) * 20), -22 - ((ship.length - 2) * 20));
        break;
      default:
    }
    heightSize += (ship.length * 40);
    (int, int) startPosition = ship.getStartPosition();
    return ship.isLocationSet
        ? Positioned(
            left: (42 * startPosition.$2.toDouble()) + 10,
            top: 42 * startPosition.$1.toDouble(),
            child: Transform.rotate(
              angle: rotation,
              child: Transform.translate(
                offset: offset,
                child: InkWell(
                  onTap: () => onRemove(ship),
                  child: Container(
                    width: widthSize,
                    height: heightSize,
                    decoration: BoxDecoration(
                      color: AppColors.goldenColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Padding(
                      padding: AppSpacings.s10Vertical,
                      child: VerticalDivider(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container();
  }
}

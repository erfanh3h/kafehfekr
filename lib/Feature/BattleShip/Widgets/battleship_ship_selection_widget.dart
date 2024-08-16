import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/BattleShip/Models/ship_model.dart';

import 'dart:math' as math;

class BattleShipShipSelectionWidget extends StatelessWidget {
  const BattleShipShipSelectionWidget({
    super.key,
    required this.ship,
    required this.isSelected,
    required this.onTap,
  });

  final ShipModel ship;
  final bool isSelected;
  final Function(ShipModel) onTap;

  @override
  Widget build(BuildContext context) {
    double heightSize = 0;
    double widthSize = 15;
    heightSize += (ship.length * 25);
    return Column(
      children: [
        Text(
          ship.length.toString(),
          style: TextStyle(
            color: ship.isLocationSet ? Colors.green : Colors.white,
            fontFamily: FontFamilies.dastnevis,
            fontSize: 21,
          ),
        ),
        Transform.rotate(
          angle: 2 * math.pi / 2,
          child: InkWell(
            onTap: () => onTap(ship),
            child: Card(
              color: isSelected ? Colors.white : null,
              child: Container(
                height: heightSize,
                padding: AppSpacings.s5All,
                child: Container(
                  width: widthSize,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.goldenColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

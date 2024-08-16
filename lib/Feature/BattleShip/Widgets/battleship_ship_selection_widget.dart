import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/BattleShip/Models/ship_model.dart';

class BattleShipShipSelectionWidget extends StatelessWidget {
  const BattleShipShipSelectionWidget({
    super.key,
    required this.ship,
    required this.isSelected,
    required this.onTap,
    required this.onHold,
  });

  final ShipModel ship;
  final bool isSelected;
  final Function(ShipModel) onTap;
  final Function(ShipModel) onHold;

  @override
  Widget build(BuildContext context) {
    bool isVertical = true;
    if (ship.direction == (0, 1)) {
      isVertical = false;
    }
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
        InkWell(
          onTap: () => onTap(ship),
          onLongPress: () => onHold(ship),
          child: Card(
            color: isSelected ? Colors.white : null,
            child: Container(
              height: isVertical ? heightSize : widthSize,
              padding: AppSpacings.s5All,
              margin: AppSpacings.s5All,
              width: !isVertical ? heightSize : widthSize,
              decoration: BoxDecoration(
                color: AppColors.goldenColor,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        )
      ],
    );
  }
}

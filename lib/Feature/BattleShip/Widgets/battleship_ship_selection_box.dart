import 'package:flutter/material.dart';
import 'package:kafehfekr/Feature/BattleShip/Controllers/battleship_controller.dart';
import 'package:kafehfekr/Feature/BattleShip/Widgets/battleship_ship_selection_widget.dart';
import 'package:refreshed/refreshed.dart';

class BattleShipShipSelectionBox extends StatelessWidget {
  const BattleShipShipSelectionBox({
    super.key,
    required this.controller,
  });

  final BattleShipController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 336,
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        runAlignment: WrapAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < controller.ships.length; i++)
            Obx(
              () => BattleShipShipSelectionWidget(
                ship: controller.ships[i].value,
                isSelected: controller.selectedShip.value == i,
                onTap: controller.onTapSelectionShip,
                onHold: controller.onRotateShip,
              ),
            ),
        ],
      ),
    );
  }
}

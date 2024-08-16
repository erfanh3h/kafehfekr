import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Feature/BattleShip/Controllers/battleship_controller.dart';
import 'package:kafehfekr/Feature/BattleShip/Widgets/battleship_drag_target_widget.dart';
import 'package:kafehfekr/Feature/BattleShip/Widgets/battleship_draggable_number_widget.dart';
import 'package:refreshed/refreshed.dart';

class BattleShipBoardWidget extends StatelessWidget {
  const BattleShipBoardWidget({
    super.key,
    required this.controller,
  });

  final BattleShipController controller;

  int coordinateToIndex((int, int) position) {
    final index = position.$1 * 8 + position.$2;
    return index;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    for (var i = 0; i < 8; i++) {
      List<Widget> widgets = [];
      for (var j = 0; j < 8; j++) {
        int index = coordinateToIndex((i, j));
        widgets.add(BattleShipDragTargetWidget(
          shipId: controller.getShipIdOfPiece(index),
          index: index,
          onAccept: controller.onPositionAccept,
          onRemove: controller.onShipRemove,
        ));
      }
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widgets,
        ),
      );
    }
    Widget column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: rows,
    );
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        constraints: BoxConstraints(
          minHeight:
              (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        ),
        width: 336,
        // height:
        //     (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        child: Stack(
          children: [
            column,
            BattleShipDraggableWidget(
              ship: controller.ships[0].value,
            ),
            BattleShipDraggableWidget(
              ship: controller.ships[1].value,
            ),
            BattleShipDraggableWidget(
              ship: controller.ships[2].value,
            ),
            BattleShipDraggableWidget(
              ship: controller.ships[3].value,
            ),
          ],
        ),
      ),
    );
  }
}

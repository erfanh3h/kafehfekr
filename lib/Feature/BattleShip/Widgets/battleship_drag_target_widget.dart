import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/BattleShip/Models/ship_model.dart';

class BattleShipDragTargetWidget extends StatelessWidget {
  const BattleShipDragTargetWidget({
    super.key,
    required this.shipId,
    required this.index,
    required this.onAccept,
    required this.onRemove,
  });
  final int shipId;
  final int index;
  final Function(int, ShipModel) onAccept;
  final Function(int) onRemove;
  @override
  Widget build(BuildContext context) {
    return DragTarget<ShipModel>(
      onAcceptWithDetails: (details) => onAccept(index, details.data),
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 40,
          height: 40,
          margin: AppSpacings.s1All,
          child: InkWell(
            onTap: () => onRemove(index),
            child: Container(
              // padding: AppSpacings.s15Vertical5Horizental,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white.withOpacity(0.5),
              ),
              child: Center(
                child: Text(
                  shipId.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: FontFamilies.dastnevis,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

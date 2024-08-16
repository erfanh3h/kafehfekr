import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class BattleShipDragTargetOperatorWidget extends StatelessWidget {
  const BattleShipDragTargetOperatorWidget({
    super.key,
    required this.value,
    required this.index,
    required this.onAccept,
    required this.onRemove,
  });
  final String value;
  final int index;
  final Function(String, int) onAccept;
  final Function(int) onRemove;
  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onAcceptWithDetails: (details) => onAccept(details.data, index),
      builder: (context, candidateData, rejectedData) {
        return InkWell(
          onTap: () => onRemove(index),
          child: Container(
            padding: AppSpacings.s15Vertical5Horizental,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white.withOpacity(0.25),
            ),
            child: Center(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
                textDirection: TextDirection.ltr,
              ),
            ),
          ),
        );
      },
    );
  }
}

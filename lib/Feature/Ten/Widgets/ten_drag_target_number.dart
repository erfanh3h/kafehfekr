import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class TenDragTargetNumberWidget extends StatelessWidget {
  const TenDragTargetNumberWidget({
    super.key,
    required this.value,
    required this.index,
    required this.onAccept,
    required this.onRemove,
  });
  final int value;
  final int index;
  final Function(int, int) onAccept;
  final Function(int) onRemove;
  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      onAcceptWithDetails: (details) => onAccept(details.data, index),
      builder: (context, candidateData, rejectedData) {
        return InkWell(
          onTap: () => onRemove(index),
          child: Container(
            padding: AppSpacings.s10All,
            // width: 50,
            // height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white.withOpacity(0.5),
            ),
            child: Center(
              child: Text(
                value >= 0 ? value.toString() : "",
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

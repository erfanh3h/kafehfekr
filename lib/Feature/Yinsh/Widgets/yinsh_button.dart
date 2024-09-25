import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/Yinsh/Models/yinsh_piece_model.dart';

class YinshButton extends StatelessWidget {
  const YinshButton({
    super.key,
    required this.pieceData,
    required this.onTap,
  });

  final YinshPieceModel pieceData;
  final Function(YinshPieceModel) onTap;

  @override
  Widget build(BuildContext context) {
    Color? color;
    if (pieceData.selectedRing != null) {
      color = pieceData.selectedRing == 1
          ? const Color.fromARGB(255, 233, 55, 55)
          : const Color.fromARGB(255, 30, 139, 228);
    } else if (pieceData.selectedDisk != null) {
      color = pieceData.selectedDisk == 1
          ? const Color.fromARGB(255, 233, 55, 55)
          : const Color.fromARGB(255, 30, 139, 228);
    }
    // late double borderWidth;
    // Color borderColor;
    // final isLastTurnPlayed =
    //     pieceData.currentStatuses.contains(PeaceStatusTypes.lastTurnPlayed);
    return InkWell(
      onTap: () {
        onTap(pieceData);
      },
      child: Transform.translate(
        offset: const Offset(0, -15),
        child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // color: Colors.blue,
            border: pieceData.selectedRing != null
                ? Border.all(
                    color: color!,
                    width: 5,
                  )
                : null,
          ),
          child: Container(
            margin: pieceData.selectedRing != null
                ? AppSpacings.s2All
                : AppSpacings.s5All,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  pieceData.selectedDisk != null ? color : Colors.transparent,
              border: pieceData.selectedDisk != null
                  ? Border.all(
                      color: Colors.black,
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

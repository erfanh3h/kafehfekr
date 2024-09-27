import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
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
    Color? ringColor;
    Color? diskColor;
    bool isLastTurnPlayed =
        pieceData.currentStatuses.contains(PeaceStatusTypes.lastTurnPlayed);
    if (pieceData.selectedRing != null) {
      ringColor = pieceData.selectedRing == 1
          ? const Color.fromARGB(255, 233, 55, 55)
          : const Color.fromARGB(255, 30, 139, 228);
    }
    if (pieceData.selectedDisk != null) {
      diskColor = pieceData.selectedDisk == 1
          ? const Color.fromARGB(255, 233, 55, 55)
          : const Color.fromARGB(255, 30, 139, 228);
    }
    if (pieceData.currentStatuses.contains(PeaceStatusTypes.canHitted)) {
      ringColor = AppColors.yellow;
    }
    if (pieceData.currentStatuses.contains(PeaceStatusTypes.canSelected)) {
      diskColor = AppColors.yellow;
    }
    // if (isLastTurnPlayed) {
    //   diskColor = AppColors.yellow;
    // }
    // late double borderWidth;
    // Color borderColor;
    // final isLastTurnPlayed =
    //     pieceData.currentStatuses.contains(PeaceStatusTypes.lastTurnPlayed);
    return Transform.translate(
      offset: const Offset(0, -15),
      child: SizedBox(
        width: 35,
        height: 35,
        child: OverflowBox(
          minHeight: 35,
          minWidth: 35,
          maxHeight: 35,
          maxWidth: 35,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: ringColor != null
                  ? Border.all(
                      color: ringColor,
                      width: 5,
                    )
                  : null,
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: diskColor ?? Colors.transparent,
                border: diskColor != null
                    ? Border.all(
                        color: Colors.black,
                        width: isLastTurnPlayed ? 4 : 1,
                      )
                    : null,
              ),
              margin: diskColor != null && pieceData.selectedRing != null
                  ? AppSpacings.s2All
                  : AppSpacings.s5All,
              child: Center(
                child: InkWell(
                  onTap: () {
                    onTap(pieceData);
                  },
                  child: const SizedBox(
                    width: 35,
                    height: 35,
                    child: Opacity(
                      opacity: 0,
                      child: Text(
                        '00',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

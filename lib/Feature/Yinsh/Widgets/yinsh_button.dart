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
    Color? color = const Color.fromARGB(255, 23, 105, 172);
    // late double borderWidth;
    // Color borderColor;
    // final isLastTurnPlayed =
    //     pieceData.currentStatuses.contains(PeaceStatusTypes.lastTurnPlayed);
    return InkWell(
      onTap: () {
        onTap(pieceData);
      },
      child: Transform.translate(
        offset: const Offset(0, -12),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // color: Colors.blue,
            border: Border.all(
              color: color,
              width: 4,
            ),
          ),
          child: Container(
            margin: AppSpacings.s2All,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

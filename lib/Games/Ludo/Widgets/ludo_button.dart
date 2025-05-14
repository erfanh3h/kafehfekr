import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Games/Ludo/Models/ludo_piece_model.dart';

class LudoButton extends StatelessWidget {
  const LudoButton({
    super.key,
    required this.pieceData,
    required this.onTap,
    required this.baseColor,
  });

  final LudoPieceModel pieceData;
  final Function(LudoPieceModel) onTap;
  final Color? baseColor;

  @override
  Widget build(BuildContext context) {
    Color? color;
    // String? image;
    late double borderWidth;
    Color? borderColor;
    // final isLastTurnPlayed =
    //     pieceData.currentStatuses.contains(PeaceStatusTypes.lastTurnPlayed);
    switch (pieceData.selectedUser) {
      case 1:
        color = AppColors.redWarmColor;
        break;
      case 2:
        color = AppColors.blueWarmColor;
        break;
      default:
        color = Colors.transparent;
        break;
    }
    if (pieceData.currentStatuses.contains(PeaceStatusTypes.canSelected)) {
      borderWidth = 5;
      borderColor = AppColors.goldenColor;
    } else {
      borderWidth = 2;
      borderColor = baseColor ?? AppColors.lightColor;
    }
    // if (pieceData.currentStatuses.contains(PeaceStatusTypes.canHitted)) {
    //   borderWidth = 5;
    //   borderColor = AppColors.goldenColor;
    // }
    return InkWell(
      onTap: () {
        onTap(pieceData);
      },
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.bottomLeft,
            //   end: Alignment.topRight,
            //   colors: [Colors.white24, (imageColor ?? Colors.white)],
            //   // stops: imageColor != null ? const [0, 0] : null,
            // ),
            color: Colors.transparent,
            // color: AppColors.lightColor,
            border: Border.all(color: borderColor, width: borderWidth),
            shape: BoxShape.circle),
        child: pieceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
            ? const GlobalLoadingWidget()
            : pieceData.currentStatuses.contains(PeaceStatusTypes.selected)
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                        child: const Text(" "),
                      ),
                      if (pieceData.count > 1)
                        Text(
                          pieceData.count.toString(),
                          style: const TextStyle(
                            color: AppColors.lightColor,
                            fontSize: 13,
                            fontFamily: FontFamilies.hekayat,
                          ),
                          textAlign: TextAlign.center,
                        ),
                    ],
                  )
                : Container(),
      ),
    );
  }
}

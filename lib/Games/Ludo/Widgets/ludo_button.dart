import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Games/Ludo/Models/ludo_piece_model.dart';

class LudoButton extends StatelessWidget {
  const LudoButton({
    super.key,
    required this.pieceData,
    required this.onTap,
    required this.color,
  });

  final LudoPieceModel pieceData;
  final Function(LudoPieceModel) onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    // Color? imageColor;
    // String? image;
    // late double borderWidth;
    // Color borderColor;
    // final isLastTurnPlayed =
    //     pieceData.currentStatuses.contains(PeaceStatusTypes.lastTurnPlayed);
    // switch (pieceData.selectedUser) {
    //   case 1:
    //     imageColor = AppColors.imageRedColor;
    //     image = GeneralIcons.circle2;
    //     break;
    //   case 2:
    //     imageColor = AppColors.imageBlueColor;
    //     image = GeneralIcons.circle2;
    //     break;
    //   default:
    //     imageColor = null;
    //     image = null;
    //     break;
    // }
    // if (pieceData.currentStatuses.contains(PeaceStatusTypes.canSelected) ||
    //     pieceData.currentStatuses.contains(PeaceStatusTypes.equiped)) {
    //   borderWidth = 5;
    //   borderColor = imageColor ?? AppColors.goldenColor;
    // } else {
    //   borderWidth = 1;
    //   borderColor = imageColor ?? AppColors.goldenColor;
    // }
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
              border: Border.all(
                color: color ?? AppColors.lightColor,
                width: 2,
              ),
              shape: BoxShape.circle),
          child: pieceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
              ? const GlobalLoadingWidget()
              : Container()
          // Stack(
          //     alignment: Alignment.center,
          //     children: [
          //       Container(
          //         width: 15,
          //         height: 15,
          //         decoration: BoxDecoration(
          //           color: color,
          //           shape: BoxShape.circle,
          //         ),
          //         child: const Text(" "),
          //       ),
          //       // const Text(
          //       //   "2",
          //       //   style: TextStyle(color: AppColors.lightColor),
          //       // ),
          //     ],
          //   ),
          ),
    );
  }
}

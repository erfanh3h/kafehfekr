import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/Chess/Models/chess_spot_piece_model.dart';

class ChessButton extends StatelessWidget {
  const ChessButton({
    super.key,
    required this.peaceData,
    required this.onTap,
    required this.mustRotate,
  });

  final ChessSpotModel peaceData;
  final Function(ChessSpotModel) onTap;
  final bool mustRotate;

  @override
  Widget build(BuildContext context) {
    Color? imageColor;
    Color? borderColor;
    String? image;
    double borderSize = 2;
    double imageScale = 1;
    final isLastTurnPlayed =
        peaceData.currentStatuses.contains(PeaceStatusTypes.lastTurnPlayed);
    if (peaceData.piece.gamerId != 0) {
      image = peaceData.piece.image;
      if (peaceData.piece.gamerId == 1) {
        imageColor = AppColors.imageRedColor;
      } else {
        imageColor = AppColors.imageBlueColor;
      }
    }
    if (peaceData.currentStatuses.contains(PeaceStatusTypes.equiped)) {
      borderColor = AppColors.goldenColor;
      borderSize = 5;
    }
    if (peaceData.currentStatuses.contains(PeaceStatusTypes.canSelected)) {
      image = GeneralIcons.checkers1;
      imageColor = AppColors.guideGreen;
      imageScale = .33;
    }
    if (peaceData.currentStatuses.contains(PeaceStatusTypes.canHitted)) {
      borderColor = AppColors.darkGreen;
      borderSize = 5;
    }
    if (peaceData.currentStatuses.contains(PeaceStatusTypes.selected)) {
      if (peaceData.piece.gamerId == 1) {
        borderColor = AppColors.imageRedColor;
      } else {
        borderColor = AppColors.imageBlueColor;
      }
      borderSize = 5;
    }
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: Container(
        padding: AppSpacings.s5All,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: (peaceData.id % 2 + peaceData.id ~/ 8) % 2 == 0
                ? [Colors.white24, Colors.white]
                : [Colors.white38, Colors.white38],
          ),
          border: Border.all(
            color: isLastTurnPlayed
                ? AppColors.yellow
                : borderColor ?? AppColors.black,
            width: isLastTurnPlayed ? 3 : borderSize,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
            ? const GlobalLoadingWidget()
            : image != null
                ? Transform.flip(
                    flipY: mustRotate,
                    child: Transform.scale(
                      scale: imageScale,
                      child: ElasticIn(
                        duration: const Duration(milliseconds: 750),
                        child: Image.asset(
                          image,
                          color: imageColor,
                        ),
                      ),
                    ),
                  )
                : Container(),
      ),
    );
  }
}

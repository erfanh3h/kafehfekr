import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/BattleShip/Models/battleship_game_piece_model.dart';

class BattleShipGameButton extends StatelessWidget {
  const BattleShipGameButton({
    super.key,
    required this.peaceData,
    required this.onTap,
    required this.baseColor,
  });

  final BattleShipGamePieceModel peaceData;
  final Function(BattleShipGamePieceModel) onTap;
  final Color baseColor;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.transparent;
    Color? imageColor;
    String? image;
    final isLastTurnPlayed =
        peaceData.currentStatuses.contains(PeaceStatusTypes.lastTurnPlayed);
    if (peaceData.isShipCompleted) {
      backgroundColor = baseColor;
    }
    if (peaceData.isSelected) {
      if (peaceData.number == 0) {
        image = GeneralIcons.cross;
        imageColor = AppColors.buttonRed;
      } else {
        image = GeneralIcons.checkers1;
        imageColor = AppColors.lightColor;
      }
    }
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: Container(
        padding: AppSpacings.s5All,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: isLastTurnPlayed ? AppColors.yellow : AppColors.lightColor,
            width: isLastTurnPlayed ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
            ? const GlobalLoadingWidget()
            : image != null
                ? ElasticIn(
                    duration: const Duration(seconds: 1),
                    child: Image.asset(
                      image,
                      color: imageColor,
                    ),
                  )
                : Container(),
      ),
    );
  }
}

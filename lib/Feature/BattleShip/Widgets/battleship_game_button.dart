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
  });

  final BattleShipGamePieceModel peaceData;
  final Function(BattleShipGamePieceModel) onTap;

  @override
  Widget build(BuildContext context) {
    Color? imageColor;
    String? image;
    if (peaceData.isSelected) {
      if (peaceData.number == 0) {
        image = GeneralIcons.cross;
        imageColor = AppColors.imageRedColor;
      } else {
        image = GeneralIcons.check;
        imageColor = AppColors.green;
      }
    }
    // switch (peaceData.selectedUser) {
    //   case 1:
    //     imageColor = AppColors.imageRedColor;
    //     if (peaceData.isSuperPawn) {
    //       image = GeneralIcons.checkers2;
    //     } else {
    //       image = GeneralIcons.checkers1;
    //     }
    //     break;
    //   case 2:
    //     imageColor = AppColors.imageBlueColor;
    //     if (peaceData.isSuperPawn) {
    //       image = GeneralIcons.checkers2;
    //     } else {
    //       image = GeneralIcons.checkers1;
    //     }
    //     break;
    //   default:
    //     imageColor = null;
    //     image = null;
    //     break;
    // }
    // if (peaceData.currentStatuses.contains(PeaceStatusTypes.equiped)) {
    //   borderColor = AppColors.goldenColor;
    //   borderSize = 5;
    // }
    // if (peaceData.currentStatuses.contains(PeaceStatusTypes.canSelected)) {
    //   if (peaceData.isSuperPawn) {
    //     image = GeneralIcons.checkers2;
    //   } else {
    //     image = GeneralIcons.checkers1;
    //   }
    //   imageColor = AppColors.guideGreen;
    //   imageScale = .33;
    // }
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: Container(
        padding: AppSpacings.s5All,
        decoration: BoxDecoration(
          color: AppColors.transparent,
          border: Border.all(
            color: AppColors.peaceBorderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
            ? const GlobalLoadingWidget()
            : image != null
                ? Image.asset(
                    image,
                    color: imageColor,
                  )
                : Container(),
      ),
    );
  }
}

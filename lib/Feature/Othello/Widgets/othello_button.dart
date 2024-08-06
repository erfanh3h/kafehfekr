import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/Othello/Models/othello_peace_model.dart';

class OthelloButton extends StatelessWidget {
  const OthelloButton({
    super.key,
    required this.peaceData,
    required this.onTap,
  });

  final OthelloPeaceModel peaceData;
  final Function(OthelloPeaceModel) onTap;

  @override
  Widget build(BuildContext context) {
    Color? imageColor;
    Color? borderColor;
    String? image;
    double borderSize = 2;
    double imageScale = 1;
    switch (peaceData.selectedUser) {
      case 1:
        imageColor = AppColors.imageRedColor;
        if (peaceData.isSuperPawn) {
          image = GeneralIcons.checkers2;
        } else {
          image = GeneralIcons.checkers1;
        }
        break;
      case 2:
        imageColor = AppColors.imageBlueColor;
        if (peaceData.isSuperPawn) {
          image = GeneralIcons.checkers2;
        } else {
          image = GeneralIcons.checkers1;
        }
        break;
      default:
        imageColor = null;
        image = null;
        break;
    }
    // imageColor = AppColors.imageBlueColor;
    // borderColor = AppColors.imageRedColor;
    // if (peaceData.isSuperPawn) {
    //   image = GeneralIcons.checkers1;
    // } else {
    //   image = GeneralIcons.checkers1;
    // }
    if (peaceData.currentStatuses.contains(PeaceStatusTypes.equiped)) {
      borderColor = AppColors.goldenColor;
      borderSize = 5;
    }
    if (peaceData.currentStatuses.contains(PeaceStatusTypes.canSelected)) {
      if (peaceData.isSuperPawn) {
        image = GeneralIcons.checkers2;
      } else {
        image = GeneralIcons.checkers1;
      }
      imageColor = AppColors.guideGreen;
      imageScale = .33;
    }
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: Container(
        padding: AppSpacings.s5All,
        decoration: BoxDecoration(
          color: (peaceData.id % 2 + peaceData.id ~/ 8) % 2 == 0
              ? Colors.grey
              : AppColors.lightColor,
          border: Border.all(
            color: borderColor ?? AppColors.black,
            width: borderSize,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
            ? const GlobalLoadingWidget()
            : image != null
                ? Transform.scale(
                    scale: imageScale,
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

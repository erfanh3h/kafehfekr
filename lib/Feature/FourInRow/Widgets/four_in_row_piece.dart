import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/FourInRow/Models/four_in_row_peace_model.dart';

class FourInRowPiece extends StatelessWidget {
  const FourInRowPiece({
    super.key,
    required this.peaceData,
  });

  final FourInRowPeaceModel peaceData;

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
        image = GeneralIcons.checkers1;
        break;
      case 2:
        imageColor = AppColors.imageBlueColor;
        image = GeneralIcons.checkers1;
        break;
      default:
        imageColor = null;
        image = null;
        break;
    }
    if (peaceData.currentStatuses.contains(PeaceStatusTypes.canSelected)) {
      image = GeneralIcons.checkers1;
      imageColor = AppColors.guideGreen;
      imageScale = .33;
    }
    return Container(
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
    );
  }
}

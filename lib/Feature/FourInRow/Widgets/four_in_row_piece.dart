import 'package:flutter/material.dart';
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
    Color backgroundColor = Colors.transparent;
    String? image;
    double borderSize = 3;
    switch (peaceData.selectedUser) {
      case 1:
        imageColor = AppColors.imageRedColor;
        image = GeneralIcons.checkers1;
        backgroundColor = AppColors.lightColor.withOpacity(.2);
        break;
      case 2:
        imageColor = AppColors.imageBlueColor;
        image = GeneralIcons.checkers1;
        backgroundColor = AppColors.lightColor.withOpacity(.2);
        break;
      default:
        imageColor = null;
        image = null;
        backgroundColor = Colors.transparent;
        break;
    }
    return Container(
      padding: AppSpacings.s5All,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: AppColors.black,
          width: borderSize,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: image != null
          ? Image.asset(
              image,
              color: imageColor,
            )
          : Container(),
    );
  }
}

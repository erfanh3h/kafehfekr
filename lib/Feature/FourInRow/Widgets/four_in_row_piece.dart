import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
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
    String? image;
    double borderSize = 3;
    final isLastTurnPlayed =
        peaceData.currentStatuses.contains(PeaceStatusTypes.lastTurnPlayed);
    switch (peaceData.selectedUser) {
      case 1:
        imageColor = AppColors.darkRed;
        image = GeneralIcons.checkers1;
        break;
      case 2:
        imageColor = AppColors.imageBlueColor;
        image = GeneralIcons.checkers1;
        break;
      default:
        imageColor = null;
        image = null;
        // backgroundColor = Colors.transparent;
        break;
    }
    return Container(
      padding: AppSpacings.s5All,
      decoration: BoxDecoration(
        // color: backgroundColor,
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Colors.white24,
            (imageColor ?? Colors.white70).withOpacity(.5)
          ],
          // stops: imageColor != null ? const [0, 0] : null,
        ),
        border: Border.all(
          color: isLastTurnPlayed ? AppColors.yellow : AppColors.black,
          width: borderSize,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: image != null
          ? FadeInDown(
              child: Image.asset(
                image,
                color: imageColor,
              ),
            )
          : Container(),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/FourInRow/Models/four_in_row_peace_model.dart';

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
    return GlobalFrameWrapper(
      padding: AppSpacings.s5All,
      frame: AppImages.button4,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isLastTurnPlayed ? AppColors.yellow : Colors.transparent,
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
      ),
    );
  }
}

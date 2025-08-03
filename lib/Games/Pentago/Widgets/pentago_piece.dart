import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/Pentago/Models/pentago_peace_model.dart';

class PentagoPiece extends StatelessWidget {
  const PentagoPiece({
    super.key,
    required this.peaceData,
    required this.onTap,
  });

  final PentagoPeaceModel peaceData;
  final Function(PentagoPeaceModel) onTap;

  @override
  Widget build(BuildContext context) {
    Color? imageColor;
    switch (peaceData.selectedUser) {
      case 1:
        imageColor = AppColors.darkRed;
        break;
      case 2:
        imageColor = AppColors.imageBlueColor;
        break;
      default:
        imageColor = null;
        // backgroundColor = Colors.transparent;
        break;
    }
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: GlobalFrameWrapper(
        frame: AppImages.button2,
        padding: AppSpacings.s2All,
        child: Container(
          padding: AppSpacings.s10All,
          decoration: BoxDecoration(
            color: imageColor,
            shape: BoxShape.circle,
            // gradient: LinearGradient(
            //   begin: Alignment.bottomLeft,
            //   end: Alignment.topRight,
            //   colors: [
            //     Colors.white24,
            //     (imageColor ?? Colors.white70).withOpacity(.5)
            //   ],
            //   // stops: imageColor != null ? const [0, 0] : null,
            // ),
          ),
          child: Container(),
        ),
      ),
    );
  }
}

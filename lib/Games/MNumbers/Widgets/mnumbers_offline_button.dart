import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/MNumbers/Models/mnumbers_peace_model.dart';

class MNumbersOfflineButton extends StatelessWidget {
  const MNumbersOfflineButton({
    super.key,
    required this.peaceData,
    required this.onTap,
  });

  final MNumbersPeaceModel peaceData;
  final Function(MNumbersPeaceModel) onTap;

  @override
  Widget build(BuildContext context) {
    Color? imageColor;
    String? text;

    if (peaceData.currentStatuses.contains(PeaceStatusTypes.selected)) {
      imageColor = AppColors.darkGreen;
      text = peaceData.value.toString();
    } else if (peaceData.currentStatuses.contains(PeaceStatusTypes.equiped)) {
      imageColor = AppColors.goldenColor;
      text = peaceData.value.toString();
    } else {
      text = null;
    }
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: GlobalFrameWrapper(
        frame: AppImages.button2,
        padding: AppSpacings.s2All,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Colors.white24, (imageColor ?? Colors.white)],
            ),
            shape: BoxShape.circle,
          ),
          child: text != null
              ? ElasticIn(
                  duration: const Duration(milliseconds: 750),
                  child: Center(
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontFamily: FontFamilies.dastnevis,
                        fontSize: 25,
                        color: AppColors.lightColor,
                      ),
                    ),
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}

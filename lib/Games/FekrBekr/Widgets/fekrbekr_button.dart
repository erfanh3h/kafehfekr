import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/FekrBekr/Models/fekrbekr_piece_model.dart';

class FekrBekrButton extends StatelessWidget {
  const FekrBekrButton({
    super.key,
    required this.peaceData,
    required this.onTap,
  });

  final FekrBekrPeaceModel peaceData;
  final Function(FekrBekrPeaceModel) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: GlobalFrameWrapper(
        padding: AppSpacings.s2All,
        width: 50,
        height: 50,
        frame: AppImages.button2,
        child: peaceData.value != 0
            ? ElasticIn(
                duration: const Duration(milliseconds: 500),
                child: Center(
                  child: Text(
                    peaceData.value.toString(),
                    style: const TextStyle(
                      fontFamily: FontFamilies.playPen,
                      fontSize: 20,
                      color: AppColors.lightColor,
                    ),
                  ),
                ),
              )
            : Container(),
      ),
    );
  }
}

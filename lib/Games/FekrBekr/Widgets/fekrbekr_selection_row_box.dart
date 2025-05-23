import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class FekrBekrSelectionRowBox extends StatelessWidget {
  const FekrBekrSelectionRowBox({super.key, required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    return GlobalFrameWrapper(
      width: 40,
      height: 40,
      frame: AppImages.button2,
      padding: AppSpacings.s2All,
      child: ElasticIn(
        duration: const Duration(milliseconds: 750),
        child: Center(
          child: Text(
            value.toString(),
            style: const TextStyle(
              fontFamily: FontFamilies.playPen,
              fontSize: 18,
              color: AppColors.lightColor,
            ),
          ),
        ),
      ),
    );
  }
}

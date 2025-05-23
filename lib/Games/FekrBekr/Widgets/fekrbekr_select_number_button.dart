import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class FekrBekrSelectNumberButton extends StatelessWidget {
  const FekrBekrSelectNumberButton({
    super.key,
    required this.number,
    required this.onTap,
    required this.isTapped,
  });

  final int number;
  final Function(int) onTap;
  final bool isTapped;

  @override
  Widget build(BuildContext context) {
    return GlobalFrameWrapper(
      frame: AppImages.button4,
      padding: AppSpacings.s2All,
      child: InkWell(
        onTap: () {
          onTap(number);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                isTapped ? Colors.white38 : Colors.transparent,
                isTapped ? AppColors.darkGreen : Colors.transparent
              ],
              // stops: imageColor != null ? const [0, 0] : null,
            ),
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: const TextStyle(
                fontFamily: FontFamilies.playPen,
                fontSize: 18,
                color: AppColors.lightColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

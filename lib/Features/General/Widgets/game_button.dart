import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:refreshed/refreshed.dart';

class GameButtonWidget extends StatelessWidget {
  const GameButtonWidget({
    super.key,
    required this.onTap,
    required this.image,
    required this.text,
    this.imageColor = AppColors.lightColor,
    this.fontSize,
    this.buttonPadding,
  });

  final Function() onTap;
  final String image, text;
  final Color? imageColor;
  final double? fontSize;
  final EdgeInsets? buttonPadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: GlobalFrameWrapper(
        height: 150,
        frame: AppImages.dialog3,
        padding: buttonPadding ?? AppSpacings.s12All,
        child: Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black38,
                ),
                child: Text(
                  text.tr,
                  style: TextStyle(
                    color: AppColors.lightColor2,
                    fontFamily: FontFamilies.dastnevis,
                    fontSize: fontSize ?? 35,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

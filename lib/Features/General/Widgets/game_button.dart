import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:refreshed/refreshed.dart';

class GameButtonWidget extends StatelessWidget {
  const GameButtonWidget({
    super.key,
    required this.onTap,
    required this.image,
    required this.text,
    this.imageColor = AppColors.lightColor,
    this.fontSize,
  });

  final Function() onTap;
  final String image, text;
  final Color? imageColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.transparent.withValues(alpha: .5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Center(
              child: Opacity(
                opacity: .25,
                child: Image.asset(
                  image,
                  color: imageColor,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Text(
                text.tr,
                style: TextStyle(
                  color: AppColors.lightColor,
                  fontFamily: FontFamilies.dastnevis,
                  fontSize: fontSize ?? 35,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

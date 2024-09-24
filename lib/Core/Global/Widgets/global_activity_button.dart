import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class GlobalActivityButton extends StatelessWidget {
  const GlobalActivityButton({
    super.key,
    required this.icon,
    this.onTap,
    this.color,
    this.backgroundColor,
    required this.text,
  });

  final VoidCallback? onTap;
  final String icon;
  final Color? color;
  final Color? backgroundColor;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: AppSpacings.s2All,
        decoration: BoxDecoration(
            color: backgroundColor,
            // shape: BoxShape.circle,
            border: Border.all(color: AppColors.lightColor),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                icon,
                width: 25,
                height: 25,
                color: color ?? AppColors.lightColor,
              ),
            ),
            const SizedBox(height: 3),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: FontFamilies.dastnevis,
                  fontSize: 12,
                  color: color ?? Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}

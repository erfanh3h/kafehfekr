import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class GlobalActivityButton extends StatelessWidget {
  const GlobalActivityButton({
    super.key,
    required this.icon,
    this.onTap,
    this.color,
    this.backgroundColor,
  });

  final VoidCallback? onTap;
  final String icon;
  final Color? color;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: AppSpacings.s10All,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.lightColor),
        ),
        child: Image.asset(
          icon,
          // width: 45,
          // height: 45,
          color: color ?? AppColors.lightColor,
        ),
      ),
    );
  }
}

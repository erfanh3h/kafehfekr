import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class GlobalActivityButton extends StatelessWidget {
  const GlobalActivityButton({
    super.key,
    required this.icon,
    this.onTap,
  });

  final VoidCallback? onTap;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: AppSpacings.s10All,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.lightColor),
        ),
        child: Image.asset(
          icon,
          width: 50.w,
          height: 50.w,
          color: AppColors.lightColor,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class GlobalButtonWidget extends StatelessWidget {
  const GlobalButtonWidget({
    super.key,
    required this.onTap,
    this.text = "",
    this.color,
    this.fontColor,
  });

  final VoidCallback onTap;
  final String text;
  final Color? color;
  final Color? fontColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: AppSpacings.s10Vertical,
        decoration: BoxDecoration(
          color: color ?? AppColors.blueWarmColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18.sp,
              color: fontColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';

class GlobalLoadingWidget extends StatelessWidget {
  const GlobalLoadingWidget({
    this.color,
    this.size,
    super.key,
  });
  final int? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: (size ?? 25).r,
        height: (size ?? 25).r,
        child: CircularProgressIndicator(
          color: color ?? AppColors.primary,
        ),
      ),
    );
  }
}

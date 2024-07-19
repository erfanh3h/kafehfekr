import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refreshed/refreshed.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class GlobalNavigatorButton extends StatelessWidget {
  const GlobalNavigatorButton({
    super.key,
    this.function,
    required this.title,
    required this.icon,
  });

  final VoidCallback? function;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        padding: AppSpacings.s10All,
        color: AppColors.white,
        child: Row(children: [
          Icon(icon, color: AppColors.primary, size: 25.r),
          SizedBox(width: 5.r),
          Text(title, style: Get.textTheme.displaySmall),
        ]),
      ),
    );
  }
}

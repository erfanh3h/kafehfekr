import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:refreshed/refreshed.dart';

import '../Components/timer.dart';

class GlobalShowTimerWidget extends StatelessWidget {
  const GlobalShowTimerWidget({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final TimerCompanent controller = Get.find<TimerCompanent>();
    return Obx(
      () => Container(
        padding: AppSpacings.s5All,
        decoration: BoxDecoration(
          color: AppColors.lightColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color ?? AppColors.darkColor,
            width: 5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              controller.timerLabel.value,
              style: TextStyle(
                color: color ?? AppColors.darkColor,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(width: 3.w),
            Image.asset(
              GeneralIcons.timeCounter,
              color: color ?? AppColors.darkColor,
              width: 24.w,
              height: 24.w,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:refreshed/refreshed.dart';

class CountdownTimerWidget extends StatelessWidget {
  const CountdownTimerWidget({
    super.key,
    this.color,
  });

  final Color? color;
  @override
  Widget build(BuildContext context) {
    final TimerCompanent controller = Get.find<TimerCompanent>();
    return Obx(
      () => CircularProgressIndicator(
        value: controller.percent.value,
        color: color ?? AppColors.theme,
        backgroundColor: Colors.grey,
        strokeWidth: 14.w,
        strokeAlign: -.5,
      ),
    );
  }
}

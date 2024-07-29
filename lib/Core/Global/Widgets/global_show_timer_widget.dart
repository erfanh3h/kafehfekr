import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
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
                fontFamily: FontFamilies.dastnevis,
                fontSize: 15,
              ),
            ),
            const SizedBox(width: 3),
            Image.asset(
              GeneralIcons.timeCounter,
              color: color ?? AppColors.darkColor,
              width: 20,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

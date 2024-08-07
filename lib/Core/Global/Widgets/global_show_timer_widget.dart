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
          color: color ?? AppColors.darkColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.white,
            width: 3,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                controller.timerLabel.value,
                style: const TextStyle(
                  color: AppColors.lightColor,
                  fontFamily: FontFamilies.dastnevis,
                  fontSize: 25,
                  height: .5,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(width: 2),
            Expanded(
              child: Image.asset(
                GeneralIcons.timeCounter,
                color: AppColors.lightColor,
                width: 22,
                height: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

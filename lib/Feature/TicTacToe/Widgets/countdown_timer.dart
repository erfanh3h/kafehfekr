import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:refreshed/refreshed.dart';

class CountdownTimerWidget extends StatelessWidget {
  const CountdownTimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TimerCompanent controller = Get.find<TimerCompanent>();
    return Obx(
      () => controller.isCounting.value
          ? Stack(
              children: [
                CircularProgressIndicator(
                  value: controller.percent.value,
                  color: AppColors.theme,
                  backgroundColor: Colors.grey,
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Text(
                    controller.timerLabel.value,
                    textAlign: TextAlign.end,
                  ),
                )
              ],
            )
          : Container(),
    );
  }
}

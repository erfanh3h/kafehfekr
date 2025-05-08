import 'package:kafehfekr/Core/Global/Components/date_actions.dart';
import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Games/Spy/Controllers/spy_offline_controller.dart';
import 'package:refreshed/refreshed.dart';

class SpyTimerWidget extends StatelessWidget {
  const SpyTimerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TimerCompanent timerController = Get.find<TimerCompanent>();
    final SpyOfflineController spyController = Get.find<SpyOfflineController>();
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              DateActionsComponent.formatSecondsToMinutes(
                  int.tryParse(timerController.timerLabel.value) ?? 0),
              style: const TextStyle(
                color: AppColors.lightColor,
                fontSize: 60,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          IconButton(
            onPressed: spyController.triggerTimerStatus,
            icon: Icon(
              spyController.isTimerCounting.value
                  ? Icons.pause
                  : Icons.play_arrow_rounded,
              color: AppColors.lightColor,
              size: 100,
            ),
          )
        ],
      ),
    );
  }
}

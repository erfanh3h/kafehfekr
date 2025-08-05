import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/Risk/Controllers/risk_controller.dart';
import 'package:refreshed/refreshed.dart';

class RiskLogWidget extends StatelessWidget {
  const RiskLogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final RiskController controller = Get.find<RiskController>();

    return GlobalFrameWrapper(
      frame: AppImages.dialog3,
      child: Text(
        controller.gameLog.value,
        style: const TextStyle(
          color: AppColors.lightColor,
          fontSize: 22,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

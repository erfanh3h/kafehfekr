import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/Risk/Controllers/risk_controller.dart';
import 'package:refreshed/refreshed.dart';

class RiskDrawResultPartWidget extends StatelessWidget {
  const RiskDrawResultPartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final RiskController controller = Get.find<RiskController>();
    return Obx(
      () => GlobalFrameWrapper(
        frame: AppImages.dialog3,
        padding: AppSpacings.s30All,
        child: Text(
          controller.gameLog.value,
          style: const TextStyle(
            color: AppColors.lightColor,
            fontSize: 25,
          ),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

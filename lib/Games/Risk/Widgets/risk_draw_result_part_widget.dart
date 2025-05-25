import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
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
      () => Text(
        controller.gameLog.value,
        style: const TextStyle(
          color: AppColors.lightColor,
          fontSize: 20,
        ),
      ),
    );
  }
}

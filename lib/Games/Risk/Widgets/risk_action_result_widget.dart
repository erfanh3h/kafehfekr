import 'package:flutter/material.dart';
import 'package:kafehfekr/Games/Risk/Models/enums.dart';
import 'package:kafehfekr/Games/Risk/Widgets/risk_card_widget.dart';
import 'package:kafehfekr/Games/Risk/Widgets/risk_log_widget.dart';
import 'package:refreshed/refreshed.dart';

import '../Controllers/risk_controller.dart';

class RiskActionResultWidget extends StatelessWidget {
  const RiskActionResultWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final RiskController controller = Get.find<RiskController>();

    return Obx(
      () => controller.isMyTurn()
          ? SizedBox(
              height: 140,
              width: 100,
              child: RiskCardWidget(
                iconData: strategyToImage(
                  controller.drawedStrategiess.value[0],
                ),
                text: controller.drawedStrategiess.value[0].name.tr,
              ),
            )
          : const RiskLogWidget(),
    );
  }
}

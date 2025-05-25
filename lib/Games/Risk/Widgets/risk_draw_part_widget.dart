import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_wait_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Risk/Controllers/risk_controller.dart';
import 'package:refreshed/refreshed.dart';

class RiskDrawPartWidget extends StatelessWidget {
  const RiskDrawPartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final RiskController controller = Get.find<RiskController>();
    return Obx(
      () => controller.isMyTurn()
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: [
                  Text(
                    AppTexts.selectDrawType.tr,
                    style: const TextStyle(
                      color: AppColors.lightColor,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GlobalButtonWidget(
                    onTap: () {
                      controller.drawCard(1);
                    },
                    text: AppTexts.twoContinent.tr,
                  ),
                  GlobalButtonWidget(
                    onTap: () {
                      controller.drawCard(2);
                    },
                    text: AppTexts.twoStrategy.tr,
                  ),
                  GlobalButtonWidget(
                    onTap: () {
                      controller.drawCard(3);
                    },
                    text: AppTexts.oneContinentOneStrategy.tr,
                    width: 200,
                  ),
                ],
              ),
            )
          : GlobalWaitWidget(text: AppTexts.waitOpponent.tr),
    );
  }
}

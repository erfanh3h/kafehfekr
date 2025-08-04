import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Risk/Controllers/risk_controller.dart';
import 'package:kafehfekr/Games/Risk/Models/enums.dart';
import 'package:kafehfekr/Games/Risk/Widgets/risk_card_widget.dart';
import 'package:refreshed/refreshed.dart';

class RiskDrawResultPartWidget extends StatelessWidget {
  const RiskDrawResultPartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final RiskController controller = Get.find<RiskController>();
    return Obx(
      () => controller.isMyTurn()
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlobalFrameWrapper(
                    frame: AppImages.dialog3,
                    child: Text(
                      AppTexts.drawResult.tr,
                      style: const TextStyle(
                        color: AppColors.lightColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 140,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            final strategy =
                                controller.drawedStrategiess.value[index];
                            final iconData = strategyToImage(strategy);
                            final text = strategy.name.tr;
                            return SizedBox(
                              height: 140,
                              width: 100,
                              child: RiskCardWidget(
                                  iconData: iconData, text: text),
                            );
                          },
                          itemCount: controller.drawedStrategiess.length,
                        ),
                        const SizedBox(width: 5),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            final continent =
                                controller.drawedContinents.value[index];
                            final iconData = continentToImage(continent);
                            final text = continent.name.tr;
                            return SizedBox(
                              height: 140,
                              width: 100,
                              child: RiskCardWidget(
                                  iconData: iconData, text: text),
                            );
                          },
                          itemCount: controller.drawedContinents.length,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GlobalButtonWidget(
                        onTap: controller.attackHandler.startAttack,
                        text: AppTexts.attack.tr,
                        width: 100,
                        height: 50,
                      ),
                      GlobalButtonWidget(
                        onTap: controller.passTurn,
                        text: AppTexts.passTurn.tr,
                        width: 100,
                        height: 50,
                      ),
                    ],
                  )
                ],
              ),
            )
          : GlobalFrameWrapper(
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

import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Risk/Models/enums.dart';
import 'package:kafehfekr/Games/Risk/Widgets/risk_card_widget.dart';
import 'package:refreshed/route_manager.dart';
import 'package:refreshed/utils.dart';

class RiskMyStrategiesWidget extends StatelessWidget {
  const RiskMyStrategiesWidget({super.key, required this.strategies});

  final List<StrategyTypes> strategies;
  @override
  Widget build(BuildContext context) {
    return GlobalFrameWrapper(
      frame: AppImages.board,
      height: Get.size.height / 2,
      width: Get.size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          GlobalFrameWrapper(
            frame: AppImages.frame4,
            padding: AppSpacings.s5All,
            child: Text(
              AppTexts.myStrategies.tr,
              style: const TextStyle(color: AppColors.lightColor, fontSize: 25),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Center(
              child: GridView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 3,
                  childAspectRatio: 3 / 4,
                ),
                itemBuilder: (ctx, index) {
                  final strategy = strategies.toList()[index];
                  final iconData = strategyToImage(strategy);
                  final text = strategy.name.tr;
                  return RiskCardWidget(iconData: iconData, text: text);
                },
                itemCount: strategies.length,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}


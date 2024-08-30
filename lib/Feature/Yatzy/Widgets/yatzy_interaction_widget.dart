import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_wait_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/Yatzy/Controllers/yatzy_controller.dart';
import 'package:kafehfekr/Feature/Yatzy/Widgets/yatzy_dice_selection_box.dart';
import 'package:refreshed/refreshed.dart';

class YatzyInteractionWidget extends StatelessWidget {
  const YatzyInteractionWidget({
    super.key,
    required this.controller,
  });

  final YatzyController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
      padding: AppSpacings.s10All,
      child: controller.isRoundPlayed.value
          ? const Center(
              child: GlobalWaitWidget(),
            )
          : Column(
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    children: [
                      for (int index = 0; index < 5; index++)
                        GetBuilder<YatzyController>(
                          builder: (context) {
                            return Expanded(
                              child: DiceSelectionBox(
                                value: controller.currentDices[index],
                                onSelect: controller.onEachDiceTapped,
                                index: index,
                                isSelected:
                                    controller.isDiceSelected(index).value,
                              ),
                            );
                          },
                        )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Obx(
                        () => ButtonWidget(
                          onSelect: controller.rollDice,
                          remainingCount: controller.remainingDice.value,
                          label: AppTexts.rollDice.tr,
                          color: AppColors.blueWarmColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ButtonWidget(
                        onSelect: controller.sendResult,
                        label: AppTexts.playGame.tr,
                        color: AppColors.darkGreen,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onSelect,
    required this.label,
    required this.color,
    this.remainingCount,
  });

  final Function() onSelect;
  final String label;
  final int? remainingCount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Container(
        padding: AppSpacings.s10All,
        margin: AppSpacings.s5All,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontFamily: FontFamilies.dastnevis,
                  ),
                  textDirection: TextDirection.ltr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (remainingCount != null)
                Container(
                  margin: AppSpacings.s10r,
                  padding: AppSpacings.s10All,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white),
                  ),
                  child: Center(
                    child: Text(
                      remainingCount.toString(),
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontFamily: FontFamilies.dastnevis,
                        height: .5,
                      ),
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

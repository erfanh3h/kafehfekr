import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/BackGammon/Controllers/backgammon_controller.dart';
import 'package:kafehfekr/Games/BackGammon/Widgets/backgammon_dice_box.dart';
import 'package:refreshed/refreshed.dart';

class BackGammonDicesBox extends StatelessWidget {
  const BackGammonDicesBox({
    super.key,
    required this.controller,
  });

  final BackGammonController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          height: 40.h,
          padding: AppSpacings.s20Horizental,
          // width: 180,
          child: controller.dicesRolled.value
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < controller.currentDices.length; i++)
                      BackGammonDiceBox(
                        dice: controller.currentDices[i],
                        onTap: controller.onEachDiceButtonTap,
                        isSelected: controller.equippedDiceIndex.value == i,
                        index: i,
                      )
                  ],
                )
              : controller.currentTurn.value == controller.myGameId
                  ? GlobalButtonWidget(
                      onTap: controller.rollDices,
                      text: AppTexts.rollDice.tr,
                      color: AppColors.redWarmColor,
                    )
                  : Container(),
        ),
      ),
    );
  }
}

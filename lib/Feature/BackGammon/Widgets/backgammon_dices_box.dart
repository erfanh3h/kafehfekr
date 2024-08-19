import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Feature/BackGammon/Controllers/backgammon_controller.dart';
import 'package:kafehfekr/Feature/BackGammon/Widgets/backgammon_dice_box.dart';
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
      () => SizedBox(
        height: 40.h,
        // width: 180,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < controller.currentDices.length; i++)
              BackGammonDiceBox(
                dice: controller.currentDices[i],
                onTap: controller.onEachDiceButtonTap,
                isSelected: controller.equippedDiceIndex.value == i,
                index: i,
              )
          ],
        ),
      ),
    );
  }
}

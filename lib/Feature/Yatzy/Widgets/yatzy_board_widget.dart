import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/Yatzy/Controllers/yatzy_controller.dart';
import 'package:refreshed/refreshed.dart';

class YatzyBoardWidget extends StatelessWidget {
  const YatzyBoardWidget({
    super.key,
    required this.controller,
  });

  final YatzyController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: AppSpacings.s5All,
        height:
            (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        width:
            (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        child: Obx(
          () => Card(
            child: Padding(
              padding: AppSpacings.s5All,
              child: Row(
                children: [],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

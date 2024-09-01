import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/Yatzy/Controllers/yatzy_controller.dart';
import 'package:kafehfekr/Feature/Yatzy/Widgets/yatzy_row_widget.dart';
import 'package:refreshed/refreshed.dart';

class YatzyBoardWidget extends StatelessWidget {
  YatzyBoardWidget({
    super.key,
    required this.controller,
  });

  final YatzyController controller;

  final List<String> headerImages = [
    GeneralIcons.dice1,
    GeneralIcons.dice2,
    GeneralIcons.dice3,
    GeneralIcons.dice4,
    GeneralIcons.dice5,
    GeneralIcons.dice6,
    GeneralIcons.yatzy3,
    GeneralIcons.yatzy4,
    GeneralIcons.yatzyq,
    GeneralIcons.yatzy23,
    GeneralIcons.yatzy15,
    GeneralIcons.yatzy5,
  ];
  final List<String> headerGuides = [
    AppTexts.yatzy1,
    AppTexts.yatzy2,
    AppTexts.yatzy3,
    AppTexts.yatzy4,
    AppTexts.yatzy5,
    AppTexts.yatzy6,
    AppTexts.yatzy33,
    AppTexts.yatzy44,
    AppTexts.yatzy66,
    AppTexts.yatzy23,
    AppTexts.yatzy15,
    AppTexts.yatzy55,
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // padding: AppSpacings.s5All,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.darkColor,
            width: 15,
          ),
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Colors.transparent, Colors.black38],
            // stops: imageColor != null ? const [0, 0] : null,
          ),
        ),
        height:
            (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        width:
            (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  for (int index = 0; index < 6; index++)
                    Expanded(
                      child: YatzyRowWidget(
                        headerImage: headerImages[index],
                        headerGuide: headerGuides[index].tr,
                        index: index,
                        controller: controller,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                children: [
                  for (int index = 6; index < 12; index++)
                    Expanded(
                      child: YatzyRowWidget(
                        headerImage: headerImages[index],
                        headerGuide: headerGuides[index].tr,
                        index: index,
                        controller: controller,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

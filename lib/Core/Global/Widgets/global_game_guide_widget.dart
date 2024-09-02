import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class GlobalGameGuideWidget extends StatefulWidget {
  const GlobalGameGuideWidget({
    super.key,
    required this.gameType,
  });

  final GameTypes gameType;

  @override
  State<GlobalGameGuideWidget> createState() => _GlobalGameGuideWidgetState();
}

class _GlobalGameGuideWidgetState extends State<GlobalGameGuideWidget> {
  int index = 0;
  final ScrollController sc = ScrollController();
  changeIndex(int newIndex) {
    sc.jumpTo(0);
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacings.s10All,
      child: Column(
        children: [
          Center(
            child: Text(
              widget.gameType.name.tr,
              style: const TextStyle(
                fontSize: 30,
                fontFamily: FontFamilies.dastnevis,
                color: AppColors.lightColor,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GlobalButtonWidget(
                  onTap: () => changeIndex(0),
                  text: AppTexts.gamePlay.tr,
                  color:
                      index == 0 ? AppColors.darkGreen : AppColors.goldenColor2,
                ),
              ),
              Expanded(
                child: GlobalButtonWidget(
                  onTap: () => changeIndex(1),
                  text: AppTexts.howToPlay.tr,
                  color:
                      index == 1 ? AppColors.darkGreen : AppColors.goldenColor2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              controller: sc,
              children: [
                Text(
                  index == 0
                      ? '${widget.gameType.name.toLowerCase()}Guide'.tr
                      : '${widget.gameType.name.toLowerCase()}GameGuide'.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: FontFamilies.vazir,
                    color: AppColors.lightColor,
                    height: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

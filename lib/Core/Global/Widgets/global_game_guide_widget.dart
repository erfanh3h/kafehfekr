import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';
import 'package:url_launcher/url_launcher.dart';

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
  String? guideLink;
  changeIndex(int newIndex) {
    sc.jumpTo(0);
    setState(() {
      index = newIndex;
    });
  }

  @override
  void initState() {
    guideLink = GameTypeConvertor(gameType: widget.gameType).toGameGuideLink();
    super.initState();
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
          const SizedBox(height: 15),
          FadeIn(
            delay: const Duration(milliseconds: 150),
            child: Center(
              child: Container(
                padding: AppSpacings.s5All,
                width: 250.w,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.lightColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: index == 0
                              ? AppColors.lightColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () => changeIndex(0),
                          child: Text(
                            AppTexts.gamePlay.tr,
                            style: TextStyle(
                              color: index == 0
                                  ? AppColors.darkColor
                                  : AppColors.lightColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: index == 1
                              ? AppColors.lightColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () => changeIndex(1),
                          child: Text(
                            AppTexts.howToPlay.tr,
                            style: TextStyle(
                              color: index == 1
                                  ? AppColors.darkColor
                                  : AppColors.lightColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView(
              controller: sc,
              children: [
                if (guideLink != null && index == 0)
                  Container(
                    margin: AppSpacings.s20Bottom,
                    child: Center(
                      child: InkWell(
                        onTap: () async {
                          final Uri url = Uri.parse(guideLink!);
                          await launchUrl(url);
                        },
                        child: Text(
                          AppTexts.taturialLink.tr,
                          style: const TextStyle(
                            fontSize: 25,
                            fontFamily: FontFamilies.vazir,
                            color: AppColors.lightColor,
                            height: 2,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.lightColor,
                          ),
                        ),
                      ),
                    ),
                  ),
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

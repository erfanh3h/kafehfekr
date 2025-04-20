import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
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
  String? gameNarrative;
  String? gameImage;
  String? gameTime;
  GameDifficulties? gameDifficulty;
  changeIndex(int newIndex) {
    sc.jumpTo(0);
    setState(() {
      index = newIndex;
    });
  }

  @override
  void initState() {
    final convertor = GameTypeConvertor(gameType: widget.gameType);
    guideLink = convertor.toGameGuideLink();
    gameNarrative = convertor.toGameNarrative();
    gameImage = convertor.toGameImage();
    gameTime = convertor.toGameTime();
    gameDifficulty = convertor.toGameDifficallty();
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
          const SizedBox(height: 10),
          FadeIn(
            delay: const Duration(milliseconds: 150),
            child: Center(
              child: Container(
                padding: AppSpacings.s5All,
                margin: AppSpacings.s10Horizental,
                // width: 250.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.darkRed,
                      AppColors.darkRed.withValues(alpha: .6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
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
                            AppTexts.overview.tr,
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
                            AppTexts.gamePlay.tr,
                            style: TextStyle(
                              color: index == 1
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
                          color: index == 2
                              ? AppColors.lightColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () => changeIndex(2),
                          child: Text(
                            AppTexts.howToPlay.tr,
                            style: TextStyle(
                              color: index == 2
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
            child: Padding(
              padding: AppSpacings.s10All,
              child: ListView(
                controller: sc,
                children: index == 0
                    ? [
                        Row(
                          children: [
                            FadeInRight(
                              child: Padding(
                                padding: AppSpacings.s20Horizental,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff7c94b6),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        gameImage ?? "",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    border: Border.all(
                                      color: AppColors.lightColor,
                                      width: 1.4,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Image.asset(
                              GeneralIcons.time,
                              color: AppColors.lightColor,
                              width: 35,
                              height: 35,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              gameTime?.tr ?? "",
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: FontFamilies.playPen,
                                color: AppColors.lightColor,
                                height: 1.75,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(width: 20),
                            Image.asset(
                              ReactionIcons().generalIconsPath(4),
                              color: AppColors.lightColor,
                              width: 35,
                              height: 35,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              gameDifficulty?.name.tr ?? "",
                              style: const TextStyle(
                                fontSize: 18,
                                color: AppColors.lightColor,
                                height: 1.75,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: AppSpacings.s5All,
                          child: FadeIn(
                            delay: const Duration(milliseconds: 400),
                            child: Text(
                              gameNarrative ?? "",
                              style: const TextStyle(
                                fontSize: 25,
                                fontFamily: FontFamilies.dastnevis,
                                color: AppColors.lightColor,
                                height: 1.75,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ]
                    : [
                        if (guideLink != null && index == 1)
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
                        FadeIn(
                          delay: const Duration(milliseconds: 100),
                          child: Text(
                            index == 1
                                ? '${widget.gameType.name.toLowerCase()}Guide'
                                    .tr
                                : '${widget.gameType.name.toLowerCase()}GameGuide'
                                    .tr,
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: FontFamilies.vazir,
                              color: AppColors.lightColor,
                              height: 2,
                            ),
                          ),
                        ),
                      ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

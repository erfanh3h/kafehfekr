import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_guide_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final gameTypesParts = GameTypes.values.toList();
    final int gamesLength = marketType == MarketTypes.Bazaar
        ? gameTypesParts.length - 1
        : gameTypesParts.length;

    return Padding(
      padding: AppSpacings.s10Horizental,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            AppTexts.library.tr,
            style: const TextStyle(
              fontSize: 25,
              color: AppColors.goldenColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppTexts.gameType.tr,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.goldenColor,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      ListView(
                        children: [
                          Padding(
                            padding: AppSpacings.s20All,
                            child: Text(
                              AppTexts.rankGuide.tr,
                              style: const TextStyle(
                                color: AppColors.lightColor,
                                fontSize: 20,
                                height: 1.75,
                              ),
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: AppColors.darkColor,
                    );
                  },
                  child: Container(
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.transparent.withValues(alpha: .25),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        AppTexts.rankGame.tr,
                        style: const TextStyle(
                          color: AppColors.lightColor,
                          fontFamily: FontFamilies.dastnevis,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      ListView(
                        children: [
                          Padding(
                            padding: AppSpacings.s20All,
                            child: Text(
                              AppTexts.normalGuide.tr,
                              style: const TextStyle(
                                color: AppColors.lightColor,
                                fontSize: 20,
                                height: 1.75,
                              ),
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: AppColors.darkColor,
                    );
                  },
                  child: Container(
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.transparent.withValues(alpha: .25),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        AppTexts.normalGame.tr,
                        style: const TextStyle(
                          color: AppColors.lightColor,
                          fontFamily: FontFamilies.dastnevis,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      ListView(
                        children: [
                          Padding(
                            padding: AppSpacings.s20All,
                            child: Text(
                              AppTexts.lobbyGuide.tr,
                              style: const TextStyle(
                                color: AppColors.lightColor,
                                fontSize: 20,
                                height: 1.75,
                              ),
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: AppColors.darkColor,
                    );
                  },
                  child: Container(
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.transparent.withValues(alpha: .25),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        AppTexts.lobbyGame.tr,
                        style: const TextStyle(
                          color: AppColors.lightColor,
                          fontFamily: FontFamilies.dastnevis,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(child: Container()),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            AppTexts.games.tr,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.goldenColor,
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 2,
              ),
              itemBuilder: (ctx, index) => InkWell(
                onTap: () {
                  Get.bottomSheet(
                    GlobalGameGuideWidget(gameType: GameTypes.values[index]),
                    backgroundColor: AppColors.darkColor,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent.withValues(alpha: .25),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      GameTypes.values[index].name.tr,
                      style: const TextStyle(
                        color: AppColors.lightColor,
                        fontFamily: FontFamilies.dastnevis,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: gamesLength,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

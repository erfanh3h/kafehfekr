import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_guide_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Resources/app_theme.dart';
import 'package:kafehfekr/Feature/General/Widgets/game_button.dart';
import 'package:refreshed/refreshed.dart';

class LibraryPage extends BaseView<GlobalController> {
  const LibraryPage({super.key});

  @override
  bool setWillPopScope() {
    return false;
  }

  @override
  Widget body(BuildContext context) {
    final gameTypesParts = GameTypes.values.toList();
    final int gamesLength = marketType == MarketTypes.Bazaar
        ? gameTypesParts.length - 1
        : gameTypesParts.length;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background3),
          fit: BoxFit.fill,
        ),
      ),
      padding: AppSpacings.s10Horizental,
      child: ListView(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  AppTexts.gameType.tr,
                  style: const TextStyle(
                    fontSize: 25,
                    color: AppColors.lightColor,
                  ),
                ),
              ),
              backButton
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: GameButtonWidget(
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
                  image: GeneralIcons.rank,
                  text: AppTexts.rankGame,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: GameButtonWidget(
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
                  image: GeneralIcons.normal,
                  text: AppTexts.normal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 2,
                child: GameButtonWidget(
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
                  image: GeneralIcons.lobby,
                  text: AppTexts.lobbyGame,
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            AppTexts.games.tr,
            style: const TextStyle(
              fontSize: 25,
              color: AppColors.lightColor,
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1,
            ),
            itemBuilder: (ctx, index) => GameButtonWidget(
              onTap: () {
                Get.bottomSheet(
                  GlobalGameGuideWidget(gameType: GameTypes.values[index]),
                  backgroundColor: AppColors.darkColor,
                );
              },
              image: GameTypeConvertor(gameType: GameTypes.values[index])
                  .toGameImage(),
              text: GameTypes.values[index].name,
              imageColor: null,
            ),
            itemCount: gamesLength,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_guide_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_page_header.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/General/Widgets/game_button.dart';
import 'package:refreshed/refreshed.dart';

class LibraryPage extends BaseView<GlobalController> {
  const LibraryPage({super.key});

  @override
  bool preventPop() {
    return false;
  }

  @override
  String? backgroundImage() {
    return AppImages.background2;
  }

  @override
  Widget body(BuildContext context) {
    final gameTypesParts = GameTypes.values.toList();
    final int gamesLength = marketType == MarketTypes.Bazaar
        ? gameTypesParts.length - 1
        : gameTypesParts.length;

    return Padding(
      padding: AppSpacings.s10Horizental,
      child: Column(
        children: [
          const SizedBox(height: 20),
          GlobalPageHeader(label: AppTexts.library.tr),
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: AppSpacings.s10Vertical,
                  alignment: Alignment.center,
                  child: GlobalFrameWrapper(
                    frame: AppImages.frame4,
                    width: Get.size.width / 2,
                    child: Center(
                      child: Text(
                        AppTexts.gameType.tr,
                        style: const TextStyle(
                            color: AppColors.lightColor, fontSize: 25),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GameButtonWidget(
                        onTap: () {
                          Get.bottomSheet(
                            GlobalFrameWrapper(
                              frame: AppImages.dialog3,
                              padding: AppSpacings.s70All,
                              child: ListView(
                                children: [
                                  Text(
                                    AppTexts.rankGuide.tr,
                                    style: const TextStyle(
                                      color: AppColors.lightColor,
                                      fontSize: 20,
                                      height: 1.75,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            backgroundColor: AppColors.transparent,
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
                        buttonPadding: AppSpacings.s25All,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Container(
                  padding: AppSpacings.s10Vertical,
                  alignment: Alignment.center,
                  child: GlobalFrameWrapper(
                    frame: AppImages.frame4,
                    width: Get.size.width / 2,
                    child: Center(
                      child: Text(
                        AppTexts.games.tr,
                        style: const TextStyle(
                            color: AppColors.lightColor, fontSize: 25),
                      ),
                    ),
                  ),
                ),
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
                        GlobalGameGuideWidget(
                          gameType: GameTypes.values[index],
                        ),
                        backgroundColor: AppColors.transparent,
                      );
                    },
                    image: GameTypeConvertor(gameType: GameTypes.values[index])
                        .toGameImage(),
                    text: GameTypes.values[index].name,
                    imageColor: null,
                    buttonPadding: AppSpacings.s25All,
                  ),
                  itemCount: gamesLength,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

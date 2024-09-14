import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_button.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/General/Widgets/avatars_selection_box.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Feature/General/Widgets/game_history_row_widget.dart';
import 'package:kafehfekr/Feature/General/Widgets/user_games_history_widget.dart';
import 'package:refreshed/refreshed.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GlobalController>();
    if (controller.myHistoryData.value == null) {
      controller.fetchMyHistoryData();
    }
    return Obx(
      () => controller.isLoadingHistory.value
          ? const Center(
              child: GlobalLoadingWidget(
                color: AppColors.lightColor,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                FadeInDown(
                  child: Padding(
                    padding: AppSpacings.s20Horizental,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 45.w,
                          height: 45.w,
                          child: GlobalActivityButton(
                            icon: GeneralIcons.exit,
                            color: AppColors.buttonRed,
                            onTap: () {
                              exit(0);
                            },
                          ),
                        ),
                        const SizedBox(width: 5),
                        GetBuilder<SoundPlayerComponent>(builder: (cont) {
                          return Obx(
                            () => SizedBox(
                              width: 45.w,
                              height: 45.w,
                              child: GlobalActivityButton(
                                icon: cont.letPlayMusic.value
                                    ? GeneralIcons.soundOn
                                    : GeneralIcons.soundOff,
                                onTap: () => cont.changeLetPlayerSound(
                                    !cont.letPlayMusic.value,
                                    isGame: false),
                                color: cont.letPlayMusic.value
                                    ? AppColors.buttonGreen
                                    : AppColors.buttonRed,
                              ),
                            ),
                          );
                        }),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              controller.myData.value!.name,
                              style: const TextStyle(
                                fontSize: 20,
                                color: AppColors.lightColor,
                                fontFamily: FontFamilies.typo,
                                letterSpacing: 2.5,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              controller.myData.value!.id,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontFamily: FontFamilies.typo,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Get.bottomSheet(
                              AvatarsSelectionBox(
                                onTap: controller.changeProfile,
                              ),
                              backgroundColor: AppColors.darkColor,
                            );
                          },
                          child: Container(
                            width: 65.w,
                            height: 65.w,
                            padding: AppSpacings.s5All,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.goldenColor, width: 3)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(150),
                              child: Image.asset(
                                AvatarIcons().generalAvatarPath(
                                    controller.myData.value!.image),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeIn(
                  delay: const Duration(milliseconds: 250),
                  child: Column(
                    children: [
                      GameHistoryRowWidget(
                        data: (
                          controller.myHistoryData.value!.winNormal,
                          controller.myHistoryData.value!.drawNormal,
                          controller.myHistoryData.value!.loseNormal,
                        ),
                        name: AppTexts.normalGame.tr,
                      ),
                      GameHistoryRowWidget(
                        data: (
                          controller.myHistoryData.value!.winRank,
                          controller.myHistoryData.value!.drawRank,
                          controller.myHistoryData.value!.loseRank,
                        ),
                        name: AppTexts.rankGame.tr,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: AppSpacings.s20Horizental,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      AppTexts.rankHistoryDetails.tr,
                      style: const TextStyle(
                        color: AppColors.lightColor,
                        fontSize: 30,
                        fontFamily: FontFamilies.dastnevis,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                if (controller.myHistoryData.value != null)
                  Expanded(
                    child: FadeIn(
                      delay: const Duration(milliseconds: 400),
                      child: UserGamesHistoryWidget(
                        data: controller.myHistoryData.value!,
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

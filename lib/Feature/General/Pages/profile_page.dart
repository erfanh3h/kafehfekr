import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
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
                  child: InkWell(
                    onTap: () {
                      Get.bottomSheet(
                        AvatarsSelectionBox(
                          onTap: controller.changeProfile,
                        ),
                        backgroundColor: AppColors.darkColor,
                      );
                    },
                    child: Container(
                      width: 100.w,
                      height: 100.w,
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
                ),
                const SizedBox(height: 15),
                FadeIn(
                  child: Text(
                    controller.myData.value!.name,
                    style: const TextStyle(
                      fontSize: 25,
                      color: AppColors.lightColor,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                FadeIn(
                  delay: const Duration(milliseconds: 200),
                  child: GameHistoryRowWidget(
                    data: (
                      controller.myHistoryData.value!.winNormal,
                      controller.myHistoryData.value!.drawNormal,
                      controller.myHistoryData.value!.loseNormal,
                    ),
                    name: AppTexts.normalGame.tr,
                  ),
                ),
                const SizedBox(
                  height: 30,
                  child: Divider(
                    color: AppColors.lightColor,
                  ),
                ),
                Padding(
                  padding: AppSpacings.s20Horizental,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      AppTexts.rankGame.tr,
                      style: const TextStyle(
                        color: AppColors.lightColor,
                        fontSize: 30,
                        fontFamily: FontFamilies.dastnevis,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                if (controller.myHistoryData.value != null)
                  Expanded(
                    child: FadeIn(
                      delay: const Duration(milliseconds: 400),
                      child: UserGamesHistoryWidget(
                        data: controller.myHistoryData.value!,
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 5,
                  child: Divider(
                    color: AppColors.lightColor,
                  ),
                ),
                ElasticIn(
                  child: Padding(
                    padding: AppSpacings.s20Horizental,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'پخش آهنگ',
                          style: TextStyle(
                            color: AppColors.lightColor,
                            fontSize: 20,
                          ),
                        ),
                        const Spacer(flex: 1),
                        GetBuilder<SoundPlayerComponent>(builder: (cont) {
                          return Obx(
                            () => Switch(
                              value: cont.letPlayMusic.value,
                              onChanged: (value) => cont
                                  .changeLetPlayerSound(value, isGame: false),
                            ),
                          );
                        }),
                        const Spacer(flex: 5),
                        GlobalButtonWidget(
                          onTap: () {
                            exit(0);
                          },
                          text: AppTexts.exit.tr,
                          color: AppColors.redWarmColor,
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

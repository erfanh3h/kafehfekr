import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_button.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class GlobalActivityBox<T extends BaseGameController> extends StatelessWidget {
  GlobalActivityBox({
    super.key,
  });

  final T controller = Get.find<T>();
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: GeneralGameConsts.maxGameWidth,
        maxHeight: 50,
      ),
      child: LayoutBuilder(builder: (context, cons) {
        double maxWidth = cons.maxWidth;
        return Obx(
          () => controller.isGameFinished.value
              ? Padding(
                  padding: AppSpacings.s20Horizental,
                  child: GlobalButtonWidget(
                    onTap: () {
                      Get.find<SoundPlayerComponent>()
                          .startPlayMusic(isGame: false);
                      Get.back();
                    },
                    text: AppTexts.exit.tr,
                    color: AppColors.buttonRed,
                    fontColor: AppColors.lightColor,
                    height: 70,
                    width: double.maxFinite,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: maxWidth / 7,
                      child: GlobalActivityButton(
                        icon: GeneralIcons.death,
                        onTap: FunctionsLibraryClass.surrenderFunction,
                        text: AppTexts.surrender.tr,
                      ),
                    ),
                    SizedBox(
                      width: maxWidth / 7,
                      child: Obx(
                        () => GlobalActivityButton(
                          icon: GeneralIcons.kori,
                          onTap: (controller.letSendKori.value == true &&
                                  controller.showKoris.value == true)
                              ? controller.showKoriBox
                              : null,
                          backgroundColor:
                              (controller.letSendKori.value == true &&
                                      controller.showKoris.value == true)
                                  ? null
                                  : Colors.grey,
                          text: AppTexts.kori.tr,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: maxWidth / 7,
                      child: GlobalActivityButton(
                          icon: GeneralIcons.setting,
                          text: AppTexts.settings.tr,
                          onTap: () {
                            Get.bottomSheet(
                              Padding(
                                padding: AppSpacings.s40All,
                                child: ListView(
                                  children: [
                                    Obx(
                                      () => GlobalButtonWidget(
                                        onTap:
                                            controller.changeShowStickerStatus,
                                        text: controller.showStickers.value ==
                                                false
                                            ? AppTexts.enableSticker.tr
                                            : AppTexts.disableSticker.tr,
                                        color: controller.showStickers.value ==
                                                false
                                            ? AppColors.darkGreen
                                            : AppColors.buttonRed,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Obx(
                                      () => GlobalButtonWidget(
                                        onTap: controller.changeShowKoriStatus,
                                        text:
                                            controller.showKoris.value == false
                                                ? AppTexts.enableKori.tr
                                                : AppTexts.disableKori.tr,
                                        color:
                                            controller.showKoris.value == false
                                                ? AppColors.darkGreen
                                                : AppColors.buttonRed,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Obx(
                                      () => GlobalButtonWidget(
                                        onTap: controller.changeLetPlayMusic,
                                        text: controller.letPlayMusic.value ==
                                                false
                                            ? AppTexts.enableGameMusic.tr
                                            : AppTexts.disableGameMusic.tr,
                                        color: controller.letPlayMusic.value ==
                                                false
                                            ? AppColors.darkGreen
                                            : AppColors.buttonRed,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              backgroundColor: AppColors.darkColor,
                            );
                          }),
                    ),
                    SizedBox(
                      width: maxWidth / 7,
                      child: Obx(
                        () => GlobalActivityButton(
                          icon: ReactionIcons().generalIconsPath(5),
                          text: AppTexts.sticker.tr,
                          onTap: (controller.letSendSticker.value == true &&
                                  controller.showStickers.value == true)
                              ? controller.showStickerBox
                              : null,
                          backgroundColor:
                              (controller.letSendSticker.value == true &&
                                      controller.showStickers.value == true)
                                  ? null
                                  : Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: maxWidth / 7,
                      child: GlobalActivityButton(
                        text: AppTexts.info.tr,
                        icon: GeneralIcons.info,
                        onTap: controller.showInfo,
                      ),
                    ),
                  ],
                ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:kafehfekr/Features/General/Widgets/avatars_selection_box.dart';
import 'package:refreshed/refreshed.dart';

class GlobalUserDataHeader extends StatelessWidget {
  const GlobalUserDataHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppSpacings.s20All,
      child: GlobalFrameWrapper(
        frame: AppImages.frame4,
        padding: AppSpacings.s20All,
        child: GetBuilder<GlobalController>(builder: (controller) {
          return Obx(
            () => controller.isNoNetwork.value
                ? NoNetworkPart(controller: controller)
                : controller.token.value != null
                    ? MainPart(controller: controller)
                    : const QuestPart(),
          );
        }),
      ),
    );
  }
}

class NoNetworkPart extends StatelessWidget {
  const NoNetworkPart({super.key, required this.controller});
  final GlobalController controller;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Text(
        AppTexts.serverError.tr,
        style: const TextStyle(color: AppColors.lightColor, fontSize: 18),
      ),
      GlobalButtonWidget(
        onTap: () {
          controller.tryReconnect();
        },
        text: AppTexts.tryAgain.tr,
      )
    ]);
  }
}

class QuestPart extends StatelessWidget {
  const QuestPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          AppTexts.quest.tr,
          style: const TextStyle(color: AppColors.lightColor, fontSize: 23),
        ),
        GlobalButtonWidget(
          width: 200,
          onTap: () {
            Get.toNamed(AppRoutes.auth);
          },
          text: AppTexts.login.tr,
        )
      ],
    );
  }
}

class MainPart extends StatelessWidget {
  const MainPart({
    super.key,
    required this.controller,
  });

  final GlobalController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  GlobalFrameWrapper(
                    frame: AppImages.button5,
                    padding: AppSpacings.s10All,
                    child: Row(
                      children: [
                        Obx(
                          () => Text(
                            controller.myData.value!.score.toString(),
                            style: const TextStyle(
                              fontFamily: FontFamilies.playPen,
                              fontSize: 16,
                              color: AppColors.lightColor,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        const SizedBox(width: 1),
                        Image.asset(
                          GeneralIcons.cup,
                          width: 20,
                          height: 20,
                          color: AppColors.lightColor,
                        )
                      ],
                    ),
                  ),
                  const Spacer(flex: 1),
                  GlobalFrameWrapper(
                    padding: AppSpacings.s10All,
                    frame: AppImages.button5,
                    child: Row(
                      children: [
                        Obx(
                          () => Text(
                            (FunctionsLibraryClass.expToLevel(
                                        controller.myData.value!.xp) +
                                    1)
                                .toString(),
                            style: const TextStyle(
                              fontFamily: FontFamilies.playPen,
                              fontSize: 16,
                              color: AppColors.lightColor,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        const SizedBox(width: 1),
                        const GlobalFrameWrapper(
                          frame: AppImages.level,
                          padding: EdgeInsets.zero,
                          child: SizedBox(
                            width: 20,
                            height: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 5),
              Stack(
                children: <Widget>[
                  GlobalFrameWrapper(
                    frame: AppImages.xpBar,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width / 2,
                    height: 10,
                    child: Container(),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.goldenColor,
                    ),
                    width: MediaQuery.of(context).size.width /
                        2 *
                        FunctionsLibraryClass.expPercent(
                            controller.myData.value!.xp),
                    height: 8,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          flex: 5,
          child: GlobalFrameWrapper(
            frame: AppImages.frame4,
            padding: AppSpacings.s10All,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                    controller.myData.value!.name,
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.lightColor,
                      fontFamily: FontFamilies.playPen,
                      letterSpacing: 2.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.ltr,
                  ),
                ),
                const SizedBox(height: 2),
                InkWell(
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(text: controller.myData.value!.id),
                    );
                  },
                  child: Text(
                    "id: ${controller.myData.value!.id}",
                    style: const TextStyle(
                      fontSize: 9,
                      color: AppColors.lightColor2,
                      fontFamily: FontFamilies.playPen,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 5.w),
        InkWell(
          onTap: () {
            Get.bottomSheet(
              AvatarsSelectionBox(onTap: controller.changeProfile),
              backgroundColor: AppColors.transparent,
            );
          },
          child: GlobalFrameWrapper(
            width: 60,
            height: 60,
            padding: AppSpacings.s5All,
            frame: AppImages.button5,
            // decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     border: Border.all(color: AppColors.lightColor, width: 3)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(150),
              child: Obx(
                () => Image.asset(
                  AvatarIcons()
                      .generalAvatarPath(controller.myData.value!.image),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

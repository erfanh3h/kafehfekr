import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Spy/Controllers/spy_offline_controller.dart';
import 'package:refreshed/get_state_manager/get_state_manager.dart';
import 'package:refreshed/utils.dart';

class SpyOfflineRolesWidget extends StatelessWidget {
  const SpyOfflineRolesWidget({super.key, required this.controller});

  final SpyOfflineController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacings.s5All,
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: GlobalFrameWrapper(
                frame: AppImages.frame3,
                padding: AppSpacings.s20Vertical40Horizental,
                child: Text(
                  ' ${controller.playersCount} / ${controller.showerCounter.value + 1}',
                  style: const TextStyle(
                      color: AppColors.lightColor, fontSize: 30),
                ),
              ),
            ),
            Expanded(
              child: FadeIn(
                key: Key(controller.showerCounter.value.toString()),
                child: Center(
                  child: InkWell(
                    onTap: controller.onChangeShowRole,
                    child: GlobalFrameWrapper(
                      frame: AppImages.frame4,
                      padding: AppSpacings.s30All,
                      child: Text(
                        controller.showRole.value
                            ? controller.users[controller.showerCounter.value]
                                    .isSpy.value
                                ? AppTexts.youAreSpy.tr
                                : controller.gameText.value
                            : AppTexts.showWord.tr,
                        style: const TextStyle(
                          color: AppColors.lightColor,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

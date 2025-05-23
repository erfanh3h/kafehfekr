import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Mafia/Controllers/mafia_offline_controller.dart';
import 'package:refreshed/utils.dart';

class MafiaOfflineRolesPage extends BaseView<MafiaOfflineController> {
  const MafiaOfflineRolesPage({super.key});
  @override
  String? backgroundImage() {
    return AppImages.background1;
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: AppSpacings.s5All,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Center(
            child: GlobalFrameWrapper(
              frame: AppImages.frame3,
              padding: AppSpacings.s20Vertical40Horizental,
              child: Text(
                ' ${controller.playersCount} / ${controller.showerCounter.value + 1}',
                style:
                    const TextStyle(color: AppColors.lightColor, fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: InkWell(
                onTap: controller.onChangeShowRole,
                child: controller.showRole.value
                    ? GlobalFrameWrapper(
                        frame: AppImages.frame4,
                        padding: AppSpacings.s30All,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GlobalFrameWrapper(
                              frame: AppImages.frame4,
                              child: Text(
                                controller.getUserSideLabel(
                                  controller.showerCounter.value,
                                ),
                                style: const TextStyle(
                                  color: AppColors.lightColor,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            GlobalFrameWrapper(
                              frame: AppImages.frame2,
                              padding: AppSpacings.s20Vertical70Horizental,
                              child: Text(
                                controller.users[controller.showerCounter.value]
                                    .role.value,
                                style: const TextStyle(
                                  color: AppColors.lightColor,
                                  fontSize: 50,
                                  fontFamily: FontFamilies.hekayat,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            GlobalFrameWrapper(
                              frame: AppImages.frame,
                              padding: AppSpacings.s25All,
                              child: Text(
                                controller.getUserSideDescription(
                                  controller.showerCounter.value,
                                ),
                                style: const TextStyle(
                                  color: AppColors.lightColor,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      )
                    : GlobalFrameWrapper(
                        frame: AppImages.frame4,
                        padding: AppSpacings.s20Vertical50Horizental,
                        child: Text(
                          AppTexts.showRole.tr,
                          style: const TextStyle(
                            color: AppColors.lightColor,
                            fontSize: 40,
                          ),
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: GlobalButtonWidget(
              onTap: controller.onNextShower,
              text: AppTexts.next.tr,
            ),
          ),
        ],
      ),
    );
  }
}

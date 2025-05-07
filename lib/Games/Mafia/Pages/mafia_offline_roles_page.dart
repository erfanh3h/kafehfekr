import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
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
            child: Text(
              ' ${controller.playersCount} / ${controller.showerCounter.value + 1}',
              style: const TextStyle(color: AppColors.lightColor, fontSize: 30),
            ),
          ),
          Expanded(
            child: Center(
              child: TextButton(
                onPressed: controller.onChangeShowRole,
                child: Text(
                  controller.showRole.value
                      ? controller
                          .users[controller.showerCounter.value].role.value
                      : AppTexts.showRole.tr,
                  style: const TextStyle(
                    color: AppColors.lightColor,
                    fontSize: 40,
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

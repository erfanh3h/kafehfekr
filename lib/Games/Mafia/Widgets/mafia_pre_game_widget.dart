import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Mafia/Controllers/mafia_offline_controller.dart';
import 'package:kafehfekr/Games/Mafia/Widgets/mafia_role_button.dart';
import 'package:refreshed/refreshed.dart';

class MafiaPreGameWidget extends StatelessWidget {
  const MafiaPreGameWidget({
    super.key,
    required this.controller,
  });

  final MafiaOfflineController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GlobalButtonWidget(
                  onTap: () => controller.changeSelectorIndex(0),
                  text: AppTexts.citizens.tr,
                  frame: AppImages.frame4,
                ),
              ),
              Expanded(
                child: GlobalButtonWidget(
                  onTap: () => controller.changeSelectorIndex(1),
                  text: AppTexts.mafia.tr,
                  frame: AppImages.frame4,
                ),
              ),
              Expanded(
                child: GlobalButtonWidget(
                  onTap: () => controller.changeSelectorIndex(2),
                  text: AppTexts.indipendents.tr,
                  frame: AppImages.frame4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Expanded(
            flex: 10,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 2,
              ),
              itemCount: controller.activeRoles.length,
              itemBuilder: (context, index) => MafiaButton(
                onTap: controller.onAddNewRole,
                text: controller.activeRoles[index]['name'] ?? "",
              ),
            ),
          ),
          const SizedBox(height: 10),
          GlobalFrameWrapper(
            padding: AppSpacings.s30All,
            height: 100,
            width: Get.size.width / 5 * 4,
            frame: AppImages.frame3,
            child: Center(
              child: Text(
                '${AppTexts.currentRoles.tr} (${controller.roles.length} / ${controller.playersCount})',
                style:
                    const TextStyle(color: AppColors.lightColor, fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 4,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 2,
              ),
              itemCount: controller.roles.length,
              itemBuilder: (context, index) => MafiaButton(
                onTap: controller.onRemoveRole,
                text: controller.roles[index],
                icon: Icons.remove,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_offline_games_activity_buttons.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Mafia/Controllers/mafia_offline_controller.dart';
import 'package:kafehfekr/Games/Mafia/Widgets/mafia_role_button.dart';
import 'package:refreshed/utils.dart';

class MafiaOfflinePage extends BaseView<MafiaOfflineController> {
  const MafiaOfflinePage({super.key});
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GlobalButtonWidget(
                onTap: () => controller.changeSelectorIndex(0),
                text: AppTexts.citizens.tr,
              ),
              GlobalButtonWidget(
                onTap: () => controller.changeSelectorIndex(1),
                text: AppTexts.mafia.tr,
              ),
              GlobalButtonWidget(
                onTap: () => controller.changeSelectorIndex(2),
                text: AppTexts.indipendents.tr,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 10,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
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
          Text(
            AppTexts.currentRoles.tr,
            style: const TextStyle(color: AppColors.lightColor , fontSize: 20),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
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
          Expanded(
            child: OfflineActivityButtons(controller: controller),
          )
        ],
      ),
    );
  }
}

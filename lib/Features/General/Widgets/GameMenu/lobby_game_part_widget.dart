import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/General/Controllers/game_menu_controller.dart';
import 'package:refreshed/refreshed.dart';

class LobbyGamePartWidget extends StatelessWidget {
  const LobbyGamePartWidget({
    super.key,
    required this.controller,
  });

  final GameMenuController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacings.s10Horizental,
      child: Column(
        children: [
          FadeInDown(
            child: Padding(
              padding: AppSpacings.s20All,
              child: Text(
                AppTexts.lobbyGameMenu.tr,
                style: const TextStyle(
                  color: AppColors.lightColor,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Spacer(),
          Obx(
            () => !Get.find<GlobalController>().isQueueActive.value
                ? FadeInUp(
                    child: GlobalButtonWidget(
                      onTap: controller.goToLobbiesPage,
                      text: AppTexts.goLobbyPage.tr,
                      color: const Color.fromARGB(255, 12, 63, 32),
                      fontColor: AppColors.lightColor,
                      width: double.maxFinite,
                    ),
                  )
                : Container(),
          ),
          // const SizedBox(height: 5),
        ],
      ),
    );
  }
}

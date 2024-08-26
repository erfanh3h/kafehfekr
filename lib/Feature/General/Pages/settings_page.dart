import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_bottom_navigation_bar.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/General/Controllers/game_menu_controller.dart';
import 'package:refreshed/refreshed.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GameMenuController controller = Get.find<GameMenuController>();
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          AppTexts.kafehFekr.tr,
          style: const TextStyle(
            color: AppColors.lightColor,
            fontFamily: FontFamilies.dastnevis,
            fontSize: 30,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(child: Container()),
        const SizedBox(height: 10),
        const GlobalBottomNavigationBar(),
      ],
    );
  }
}

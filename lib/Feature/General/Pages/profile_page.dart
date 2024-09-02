import 'package:flutter/material.dart';
import 'package:kafehfekr/Feature/General/Widgets/avatars_selection_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Feature/General/Controllers/game_menu_controller.dart';
import 'package:refreshed/refreshed.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GameMenuController controller = Get.find<GameMenuController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        GlobalButtonWidget(
          onTap: () {
            Get.bottomSheet(
              AvatarsSelectionBox(
                onTap: (int index) {
                },
              ),
              backgroundColor: AppColors.darkColor,
            );
          },
          text: "profile",
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

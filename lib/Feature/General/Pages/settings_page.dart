import 'package:flutter/material.dart';
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
        const SizedBox(height: 10),
        Expanded(child: Container()),
      ],
    );
  }
}

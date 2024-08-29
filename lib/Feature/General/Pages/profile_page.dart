import 'package:flutter/material.dart';
import 'package:kafehfekr/Feature/General/Controllers/game_menu_controller.dart';
import 'package:refreshed/refreshed.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GameMenuController controller = Get.find<GameMenuController>();
    return Column(
      children: [
        const SizedBox(height: 10),
        Expanded(child: Container()),
        const SizedBox(height: 10),
      ],
    );
  }
}

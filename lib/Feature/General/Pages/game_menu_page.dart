import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_bottom_navigation_bar.dart';
import 'package:kafehfekr/Feature/General/Controllers/game_menu_controller.dart';
import 'package:refreshed/refreshed.dart';

class GameMenuPage extends StatelessWidget {
  const GameMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GameMenuController controller = Get.find<GameMenuController>();
    return const Column(
      children: [Text("Menu"), Spacer(), GlobalBottomNavigationBar()],
    );
  }
}

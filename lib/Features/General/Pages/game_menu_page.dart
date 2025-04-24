import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_theme.dart';
import 'package:kafehfekr/Features/General/Controllers/game_menu_controller.dart';
import 'package:kafehfekr/Features/General/Widgets/GameMenu/game_menu_type_selector_widget.dart';
import 'package:kafehfekr/Features/General/Widgets/GameMenu/lobby_game_part_widget.dart';
import 'package:kafehfekr/Features/General/Widgets/GameMenu/normal_game_part_widget.dart';
import 'package:kafehfekr/Features/General/Widgets/GameMenu/rank_game_part_widget.dart';
import 'package:refreshed/refreshed.dart';

class GameMenuPage extends BaseView<GameMenuController> {
  const GameMenuPage({super.key});

  @override
  bool setWillPopScope() {
    return false;
  }

  @override
  Widget body(BuildContext context) {
    super.build(context);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background3),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GameMenuTypeSelectorWidget(controller: controller),
              ),
              backButton
            ],
          ),
          Expanded(
            child: Obx(
              () {
                switch (controller.selectedTab.value) {
                  case 1:
                    return const NormalGamePartWidget();
                  case 2:
                    return const RankGamePartWidget();
                  case 0:
                    return LobbyGamePartWidget(controller: controller);
                  default:
                    return const NormalGamePartWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

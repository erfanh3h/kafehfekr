import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Feature/General/Controllers/game_menu_controller.dart';
import 'package:kafehfekr/Feature/General/Widgets/GameMenu/game_menu_type_selector_widget.dart';
import 'package:kafehfekr/Feature/General/Widgets/GameMenu/lobby_game_part_widget.dart';
import 'package:kafehfekr/Feature/General/Widgets/GameMenu/normal_game_part_widget.dart';
import 'package:kafehfekr/Feature/General/Widgets/GameMenu/rank_game_part_widget.dart';
import 'package:refreshed/refreshed.dart';

class GameMenuPage extends StatefulWidget {
  const GameMenuPage({super.key});

  @override
  State<GameMenuPage> createState() => _GameMenuPageState();
}

class _GameMenuPageState extends State<GameMenuPage>
    with AutomaticKeepAliveClientMixin {
  final GameMenuController controller = Get.find<GameMenuController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      constraints: BoxConstraints(maxHeight: Get.width * 5 / 6),
      child: Column(
        children: [
          const SizedBox(height: 10),
          GameMenuTypeSelectorWidget(controller: controller),
          Expanded(
            child: Obx(
              () {
                switch (controller.selectedTab.value) {
                  case 1:
                    return NormalGamePartWidget(controller: controller);
                  case 2:
                    return RankGamePartWidget(controller: controller);
                  case 0:
                    return LobbyGamePartWidget(controller: controller);
                  default:
                    return NormalGamePartWidget(controller: controller);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

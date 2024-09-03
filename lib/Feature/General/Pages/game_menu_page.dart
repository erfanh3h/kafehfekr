import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Feature/General/Widgets/game_menu_game_part_widget.dart';
import 'package:refreshed/refreshed.dart';

class GameMenuPage extends StatelessWidget {
  const GameMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalController controller = Get.find<GlobalController>();
    final gameTypesParts = GameTypes.values.toList();
    return Container(
      constraints: BoxConstraints(maxHeight: Get.width * 5 / 6),
      child: PageView.builder(
        itemBuilder: (ctx, index) => Obx(
          () => GameMenuGamePartWidget(
            game: gameTypesParts[index],
            onTap: controller.startQueue,
            showButtons: !controller.isQueueActive.value,
          ),
        ),
        itemCount: 16,
      ),
    );
    // Column(
    //   mainAxisSize: MainAxisSize.min,
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     ConstrainedBox(
    //       constraints: BoxConstraints(maxHeight: Get.width * 5 / 6),
    //       child: ListView.separated(
    //         scrollDirection: Axis.horizontal,
    //         itemBuilder: (ctx, index) => GameMenuGamePartWidget(
    //           items: gameTypesParts[index],
    //           onTap: controller.startQueue,
    //         ),
    //         separatorBuilder: (ctx, index) => const SizedBox(width: 5),
    //         itemCount: gameTypesParts.length,
    //       ),
    //     ),
    //   ],
    // );
  }
}

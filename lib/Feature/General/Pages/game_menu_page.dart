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
    final gameTypesParts = [
      GameTypes.values.getRange(0, 2).toList(),
      GameTypes.values.getRange(2, 4).toList(),
      GameTypes.values.getRange(4, 6).toList(),
      GameTypes.values.getRange(6, 8).toList(),
      GameTypes.values.getRange(8, 10).toList(),
      GameTypes.values.getRange(10, 12).toList(),
      GameTypes.values.getRange(12, 14).toList(),
      GameTypes.values.getRange(14, 16).toList(),
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.width * 5 / 6),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) => GameMenuGamePartWidget(
              items: gameTypesParts[index],
              onTap: controller.startQueue,
            ),
            separatorBuilder: (ctx, index) => const SizedBox(width: 5),
            itemCount: gameTypesParts.length,
          ),
        ),
      ],
    );
  }
}

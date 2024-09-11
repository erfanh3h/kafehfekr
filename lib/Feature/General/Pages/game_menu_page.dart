import 'package:flutter/cupertino.dart';
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
    final PageController pageController = PageController();
    return Container(
      constraints: BoxConstraints(maxHeight: Get.width * 5 / 6),
      child: PageView.builder(
        controller: pageController,
        itemBuilder: (ctx, index) => Row(
          children: [
            IconButton(
              onPressed: () {
                pageController.animateToPage(
                  index != 0 ? index - 1 : 15,
                  duration: Duration(milliseconds: index != 0 ? 300 : 1000),
                  curve: Curves.linear,
                );
              },
              icon: const Icon(
                CupertinoIcons.chevron_right_square,
                size: 30,
              ),
              color: Colors.white,
            ),
            Expanded(
              child: Obx(
                () => GameMenuGamePartWidget(
                  game: gameTypesParts[index],
                  onTap: controller.startQueue,
                  showButtons: !controller.isQueueActive.value,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                pageController.animateToPage(
                  index != 15 ? index + 1 : 0,
                  duration: Duration(milliseconds: index != 15 ? 300 : 1000),
                  curve: Curves.linear,
                );
              },
              icon: const Icon(
                CupertinoIcons.chevron_left_square,
                size: 30,
              ),
              color: Colors.white,
            ),
          ],
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

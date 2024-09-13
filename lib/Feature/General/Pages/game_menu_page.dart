import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/General/Controllers/game_menu_controller.dart';
import 'package:kafehfekr/Feature/General/Widgets/game_menu_game_part_widget.dart';
import 'package:refreshed/refreshed.dart';

class GameMenuPage extends StatelessWidget {
  const GameMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GameMenuController controller = Get.find<GameMenuController>();
    final gameTypesParts = GameTypes.values.toList();
    final PageController pageController = PageController();
    return Container(
      constraints: BoxConstraints(maxHeight: Get.width * 5 / 6),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: controller.changePage,
              itemBuilder: (ctx, index) => Row(
                children: [
                  IconButton(
                    onPressed: () {
                      pageController.animateToPage(
                        index != 0 ? index - 1 : 15,
                        duration:
                            Duration(milliseconds: index != 0 ? 300 : 1000),
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
                        onTap: Get.find<GlobalController>().startQueue,
                        showButtons:
                            !Get.find<GlobalController>().isQueueActive.value,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      pageController.animateToPage(
                        index != 15 ? index + 1 : 0,
                        duration:
                            Duration(milliseconds: index != 15 ? 300 : 1000),
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
          ),
          Padding(
            padding: AppSpacings.s20Horizental10Vertical,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 16; i++)
                  GameCircleDotWidget(
                    pageController: pageController,
                    i: i,
                    controller: controller,
                  )
              ],
            ),
          ),
          const SizedBox(height: 5),
        ],
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

class GameCircleDotWidget extends StatelessWidget {
  const GameCircleDotWidget({
    super.key,
    required this.pageController,
    required this.i,
    required this.controller,
  });

  final PageController pageController;
  final int i;
  final GameMenuController controller;

  @override
  Widget build(BuildContext context) {
    Color color = controller.getGameColor(i);
    return Obx(
      () => InkWell(
        onTap: () {
          pageController.animateToPage(
            i,
            duration: const Duration(milliseconds: 600),
            curve: Curves.linear,
          );
        },
        child: Container(
          padding: controller.currentPage.value == i.toDouble()
              ? AppSpacings.s8All
              : AppSpacings.s5All,
          margin: AppSpacings.s5All,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: controller.currentPage.value == i.toDouble()
                  ? color
                  : AppColors.lightColor,
              border: Border.all(
                color: controller.currentPage.value != i.toDouble()
                    ? color
                    : AppColors.lightColor,
              )),
        ),
      ),
    );
  }
}

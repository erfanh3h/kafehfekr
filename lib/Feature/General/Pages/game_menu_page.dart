import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/General/Controllers/game_menu_controller.dart';
import 'package:kafehfekr/Feature/General/Widgets/game_circle_dot_widget.dart';
import 'package:kafehfekr/Feature/General/Widgets/game_menu_game_part_widget.dart';
import 'package:refreshed/refreshed.dart';

class GameMenuPage extends StatefulWidget {
  const GameMenuPage({super.key});

  @override
  State<GameMenuPage> createState() => _GameMenuPageState();
}

class _GameMenuPageState extends State<GameMenuPage>
    with AutomaticKeepAliveClientMixin {
  final GameMenuController controller = Get.find<GameMenuController>();
  final gameTypesParts = GameTypes.values.toList();
  int gamesLength = 0;

  @override
  void initState() {
    gamesLength = marketType == MarketTypes.Bazaar
        ? gameTypesParts.length - 1
        : gameTypesParts.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // we use this because cafe bazaar wont let backgamoon :/
    return Container(
      constraints: BoxConstraints(maxHeight: Get.width * 5 / 6),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.changePage,
              itemBuilder: (ctx, index) => Row(
                children: [
                  IconButton(
                    onPressed: () {
                      controller.pageController.animateToPage(
                        index != 0 ? index - 1 : (gamesLength - 1),
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
                      controller.pageController.animateToPage(
                        index != (gamesLength - 1) ? index + 1 : 0,
                        duration: Duration(
                            milliseconds:
                                index != (gamesLength - 1) ? 300 : 1000),
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
              itemCount: gamesLength,
            ),
          ),
          Padding(
            padding: AppSpacings.s20Horizental5Vertical,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 10; i++)
                  GameCircleDotWidget(
                    pageController: controller.pageController,
                    i: i,
                    controller: controller,
                  )
              ],
            ),
          ),
          Padding(
            padding: AppSpacings.s20Horizental,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 10; i < gamesLength; i++)
                  GameCircleDotWidget(
                    pageController: controller.pageController,
                    i: i,
                    controller: controller,
                  )
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

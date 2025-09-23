import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_page_header.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/General/Controllers/offline_games_menu_controller.dart';
import 'package:kafehfekr/Features/General/Widgets/game_button.dart';
import 'package:refreshed/refreshed.dart';

class OfflineGamesMenuPage extends BaseView<OfflineGamesMenuController> {
  const OfflineGamesMenuPage({super.key});
  @override
  bool preventPop() {
    return false;
  }

  @override
  String? backgroundImage() {
    return AppImages.background2;
  }

  @override
  Widget body(BuildContext context) {
    List<OfflineGameTypes> gameTypesParts = OfflineGameTypes.values.toList();
    final int gamesLength = gameTypesParts.length;

    return Padding(
      padding: AppSpacings.s10Horizental,
      child: Column(
        children: [
          const SizedBox(height: 20),
          GlobalPageHeader(label: AppTexts.offlineGame.tr),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: 1,
              ),
              itemBuilder: (ctx, index) => GameButtonWidget(
                image:
                    OfflineGameTypeConvertor.toGameImage(gameTypesParts[index]),
                text: OfflineGameTypes.values[index].name,
                imageColor: null,
                fontSize: 18,
                onTap: () {
                  controller.onEachGameTap(OfflineGameTypes.values[index]);
                },
              ),
              itemCount: gamesLength,
              // padding: AppSpacings.s10All,
            ),
          ),
        ],
      ),
    );
  }
}

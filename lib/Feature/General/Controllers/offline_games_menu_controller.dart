import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_guide_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:refreshed/refreshed.dart';

class OfflineGamesMenuController extends BaseController {
  onEachGameTap(GameTypes game) {
    String route = "";
    switch (game) {
      case GameTypes.TicTacToe:
        route = AppRoutes.tictactoeOffline;
      case GameTypes.MSweeper:
        route = AppRoutes.msweeperOffline;
      default:
    }
    Get.toNamed(route);
  }

  openGameGuide(GameTypes gameType) {
    Get.bottomSheet(
      GlobalGameGuideWidget(gameType: gameType),
      backgroundColor: AppColors.darkColor,
    );
  }

  startNormalGame() {}

  @override
  void onInit() {
    super.onInit();
  }
}

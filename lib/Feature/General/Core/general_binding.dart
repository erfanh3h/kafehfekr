import 'package:kafehfekr/Feature/General/Controllers/game_menu_controller.dart';
import 'package:kafehfekr/Feature/General/Controllers/game_play_controller.dart';
import 'package:kafehfekr/Feature/General/Controllers/history_controller.dart';
import 'package:kafehfekr/Feature/General/Controllers/lobby_controller.dart';
import 'package:kafehfekr/Feature/General/Controllers/maintence_controlle.dart';
import 'package:kafehfekr/Feature/General/Controllers/ranking_controller.dart';
import 'package:kafehfekr/Feature/General/Controllers/store_controller.dart';
import 'package:kafehfekr/Feature/General/Controllers/update_controller.dart';
import 'package:kafehfekr/Feature/General/Core/general_repository.dart';
import 'package:refreshed/refreshed.dart';

class GeneralBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<UpdateController>(
          () => UpdateController(),
          fenix: true,
        ),
        Get.lazyPut<GameMenuController>(
          () => GameMenuController(),
          fenix: true,
        ),
        Get.lazyPut<MaintenceController>(
          () => MaintenceController(),
          fenix: true,
        ),
        Get.lazyPut<StoreController>(
          () => StoreController(),
          fenix: true,
        ),
        Get.lazyPut<RankingController>(
          () => RankingController(),
          fenix: true,
        ),
        Get.lazyPut<GamePlayController>(
          () => GamePlayController(),
          fenix: true,
        ),
        Get.lazyPut<LobbyController>(
          () => LobbyController(),
          fenix: true,
        ),
        Get.lazyPut<HistoryController>(
          () => HistoryController(),
          fenix: true,
        ),
      ];
}

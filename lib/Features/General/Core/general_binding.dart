import 'package:kafehfekr/Features/General/Controllers/chats_controller.dart';
import 'package:kafehfekr/Features/General/Controllers/multi_queue_controller.dart';
import 'package:kafehfekr/Features/General/Controllers/queue_controller.dart';
import 'package:kafehfekr/Features/General/Controllers/game_play_controller.dart';
import 'package:kafehfekr/Features/General/Controllers/history_controller.dart';
import 'package:kafehfekr/Features/General/Controllers/lobby_controller.dart';
import 'package:kafehfekr/Features/General/Controllers/maintence_controlle.dart';
import 'package:kafehfekr/Features/General/Controllers/offline_games_menu_controller.dart';
import 'package:kafehfekr/Features/General/Controllers/ranking_controller.dart';
import 'package:kafehfekr/Features/General/Controllers/store_controller.dart';
import 'package:kafehfekr/Features/General/Controllers/update_controller.dart';
import 'package:refreshed/refreshed.dart';

class GeneralBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<UpdateController>(
          () => UpdateController(),
          fenix: true,
        ),
        Get.lazyPut<QueueController>(
          () => QueueController(),
          fenix: true,
        ),
        Get.lazyPut<MultiQueueController>(
          () => MultiQueueController(),
          fenix: true,
        ),
        Get.lazyPut<OfflineGamesMenuController>(
          () => OfflineGamesMenuController(),
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
        Get.lazyPut<ChatsController>(
          () => ChatsController(),
          fenix: true,
        ),
      ];
}

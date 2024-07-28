import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Network/game_socket.dart';
import 'package:kafehfekr/Feature/Mill/Core/mill_binding.dart';
import 'package:kafehfekr/Feature/RPC/Core/rpc_binding.dart';
import 'package:kafehfekr/Feature/TicTacToe/Core/tictactoe_binding.dart';
import 'package:refreshed/refreshed.dart';

class GlobalBinding implements BindingsInterface {
  @override
  dependencies() => [
        // AuthBinding().dependencies(),
        // Get.lazyPut<GlobalRepository>(() => GlobalRepositoryImp(), fenix: true),
        Get.put(GlobalController()),
        TicTactoeBinding().dependencies(),
        RPCBinding().dependencies(),
        MillBinding().dependencies(),
        Get.lazyPut<TimerCompanent>(TimerCompanent.new, fenix: true),
        Get.lazyPut<SoundPlayerComponent>(
          SoundPlayerComponent.new,
          fenix: true,
        ),
        Get.lazyPut<GameSocketManager>(GameSocketManager.new, fenix: true),
      ];
}

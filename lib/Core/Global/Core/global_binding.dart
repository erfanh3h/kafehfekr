import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Feature/Checkers/Core/checkers_binding.dart';
import 'package:kafehfekr/Feature/Chess/Core/chess_binding.dart';
import 'package:kafehfekr/Feature/DotBox/Core/dotbox_binding.dart';
import 'package:kafehfekr/Feature/MNumbers/Core/mnumbers_binding.dart';
import 'package:kafehfekr/Feature/MSweeper/Core/msweeper_binding.dart';
import 'package:kafehfekr/Feature/Mill/Core/mill_binding.dart';
import 'package:kafehfekr/Feature/Othello/Core/othello_binding.dart';
import 'package:kafehfekr/Feature/RPC/Core/rpc_binding.dart';
import 'package:kafehfekr/Feature/Ten/Core/ten_binding.dart';
import 'package:kafehfekr/Feature/TicTacToe/Core/tictactoe_binding.dart';
import 'package:kafehfekr/Feature/Yatzy/Core/yatzy_binding.dart';
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
        MSweeperBinding().dependencies(),
        MNumbersBinding().dependencies(),
        CheckersBinding().dependencies(),
        TenBinding().dependencies(),
        OthelloBinding().dependencies(),
        DotBoxBinding().dependencies(),
        ChessBinding().dependencies(),
        YatzyBinding().dependencies(),
        Get.lazyPut<TimerCompanent>(TimerCompanent.new, fenix: true),
        Get.lazyPut<SoundPlayerComponent>(
          SoundPlayerComponent.new,
          fenix: true,
        ),
        // Get.lazyPut<BaseGameController>(BaseGameController.new, fenix: true),
      ];
}

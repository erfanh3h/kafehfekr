import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Core/global_repository.dart';
import 'package:kafehfekr/Feature/Auth/Core/auth_binding.dart';
import 'package:kafehfekr/Feature/BackGammon/Core/backgammon_binding.dart';
import 'package:kafehfekr/Feature/BattleShip/Core/battleship_binding.dart';
import 'package:kafehfekr/Feature/BoxFour/Core/boxfour_binding.dart';
import 'package:kafehfekr/Feature/Checkers/Core/checkers_binding.dart';
import 'package:kafehfekr/Feature/Chess/Core/chess_binding.dart';
import 'package:kafehfekr/Feature/DotBox/Core/dotbox_binding.dart';
import 'package:kafehfekr/Feature/FekrBekr/Core/fekrbekr_binding.dart';
import 'package:kafehfekr/Feature/FourInRow/Core/four_in_row_binding.dart';
import 'package:kafehfekr/Feature/General/Core/general_binding.dart';
import 'package:kafehfekr/Feature/MNumbers/Core/mnumbers_binding.dart';
import 'package:kafehfekr/Feature/MSweeper/Core/msweeper_binding.dart';
import 'package:kafehfekr/Feature/Mill/Core/mill_binding.dart';
import 'package:kafehfekr/Feature/Othello/Core/othello_binding.dart';
import 'package:kafehfekr/Feature/Pentago/Core/pentago_binding.dart';
import 'package:kafehfekr/Feature/RPC/Core/rpc_binding.dart';
import 'package:kafehfekr/Feature/Sudoku/Core/sudoku_binding.dart';
import 'package:kafehfekr/Feature/Ten/Core/ten_binding.dart';
import 'package:kafehfekr/Feature/TicTacToe/Core/tictactoe_binding.dart';
import 'package:kafehfekr/Feature/Yatzy/Core/yatzy_binding.dart';
import 'package:refreshed/refreshed.dart';

class GlobalBinding implements BindingsInterface {
  @override
  dependencies() => [
        // AuthBinding().dependencies(),
        Get.lazyPut<GlobalRepository>(() => GlobalRepositoryImp(), fenix: true),
        Get.put(
          GlobalController(globalRepo: Get.find<GlobalRepository>()),
          permanent: true,
        ),
        Get.put(SoundPlayerComponent(), permanent: true),
        AuthBinding().dependencies(),
        GeneralBinding().dependencies(),
        TicTactoeBinding().dependencies(),
        RPCBinding().dependencies(),
        MillBinding().dependencies(),
        MSweeperBinding().dependencies(),
        MNumbersBinding().dependencies(),
        CheckersBinding().dependencies(),
        TenBinding().dependencies(),
        PentagoBinding().dependencies(),
        OthelloBinding().dependencies(),
        DotBoxBinding().dependencies(),
        ChessBinding().dependencies(),
        YatzyBinding().dependencies(),
        FourInRowBinding().dependencies(),
        SudokuBinding().dependencies(),
        BattleShipBinding().dependencies(),
        BoxFourBinding().dependencies(),
        FekrBekrBinding().dependencies(),
        BackGammonBinding().dependencies(),
        Get.lazyPut<TimerCompanent>(TimerCompanent.new, fenix: true),
        // Get.lazyPut<SoundPlayerComponent>(
        //   SoundPlayerComponent.new,
        //   fenix: true,
        // ),
        // Get.lazyPut<BaseGameController>(BaseGameController.new, fenix: true),
      ];
}

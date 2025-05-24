import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Features/Auth/Core/auth_binding.dart';
import 'package:kafehfekr/Games/BackGammon/Core/backgammon_binding.dart';
import 'package:kafehfekr/Games/BattleShip/Core/battleship_binding.dart';
import 'package:kafehfekr/Games/BoxFour/Core/boxfour_binding.dart';
import 'package:kafehfekr/Games/Checkers/Core/checkers_binding.dart';
import 'package:kafehfekr/Games/Chess/Core/chess_binding.dart';
import 'package:kafehfekr/Games/DotBox/Core/dotbox_binding.dart';
import 'package:kafehfekr/Games/FekrBekr/Core/fekrbekr_binding.dart';
import 'package:kafehfekr/Games/FourInRow/Core/four_in_row_binding.dart';
import 'package:kafehfekr/Features/General/Core/general_binding.dart';
import 'package:kafehfekr/Games/Ludo/Core/ludo_binding.dart';
import 'package:kafehfekr/Games/MNumbers/Core/mnumbers_binding.dart';
import 'package:kafehfekr/Games/MSweeper/Core/msweeper_binding.dart';
import 'package:kafehfekr/Games/Mafia/Core/mafia_binding.dart';
import 'package:kafehfekr/Games/Mill/Core/mill_binding.dart';
import 'package:kafehfekr/Games/Othello/Core/othello_binding.dart';
import 'package:kafehfekr/Games/Pentago/Core/pentago_binding.dart';
import 'package:kafehfekr/Games/RPC/Core/rpc_binding.dart';
import 'package:kafehfekr/Games/Risk/Core/risk_binding.dart';
import 'package:kafehfekr/Games/Spy/Core/spy_binding.dart';
import 'package:kafehfekr/Games/Sudoku/Core/sudoku_binding.dart';
import 'package:kafehfekr/Games/Ten/Core/ten_binding.dart';
import 'package:kafehfekr/Games/TicTacToe/Core/tictactoe_binding.dart';
import 'package:kafehfekr/Games/Yatzy/Core/yatzy_binding.dart';
import 'package:kafehfekr/Games/Yinsh/Core/yinsh_binding.dart';
import 'package:refreshed/refreshed.dart';

class GlobalBinding implements BindingsInterface {
  @override
  dependencies() => [
        Get.put(GlobalController(), permanent: true),
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
        YinshBinding().dependencies(),
        BattleShipBinding().dependencies(),
        LudoBinding().dependencies(),
        RiskBinding().dependencies(),
        BoxFourBinding().dependencies(),
        FekrBekrBinding().dependencies(),
        BackGammonBinding().dependencies(),
        MafiaBinding().dependencies(),
        SpyBinding().dependencies(),
        Get.lazyPut<TimerCompanent>(TimerCompanent.new, fenix: true),
        // Get.lazyPut<SoundPlayerComponent>(
        //   SoundPlayerComponent.new,
        //   fenix: true,
        // ),
        // Get.lazyPut<BaseGameController>(BaseGameController.new, fenix: true),
      ];
}

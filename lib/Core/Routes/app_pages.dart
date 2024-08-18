import 'package:kafehfekr/Core/Global/Core/global_binding.dart';
import 'package:kafehfekr/Core/Global/Pages/main_menu_page.dart';
import 'package:kafehfekr/Core/Global/Pages/splash.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:kafehfekr/Feature/BattleShip/Pages/battleship_page.dart';
import 'package:kafehfekr/Feature/Checkers/Pages/checkers_page.dart';
import 'package:kafehfekr/Feature/Chess/Pages/chess_page.dart';
import 'package:kafehfekr/Feature/DotBox/Pages/dotbox_page.dart';
import 'package:kafehfekr/Feature/FourInRow/Pages/four_in_row_page.dart';
import 'package:kafehfekr/Feature/MNumbers/Pages/mnumbers_page.dart';
import 'package:kafehfekr/Feature/MSweeper/Pages/msweeper_page.dart';
import 'package:kafehfekr/Feature/Mill/Pages/mill_page.dart';
import 'package:kafehfekr/Feature/Othello/Pages/othello_page.dart';
import 'package:kafehfekr/Feature/RPC/Pages/rpc_page.dart';
import 'package:kafehfekr/Feature/Sudoku/Pages/sudoku_page.dart';
import 'package:kafehfekr/Feature/Ten/Pages/ten_page.dart';
import 'package:kafehfekr/Feature/TicTacToe/Pages/tictactoe_page.dart';
import 'package:kafehfekr/Feature/Yatzy/Pages/yatzy_page.dart';
import 'package:refreshed/refreshed.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: SplashPage.new,
    ),
    GetPage(
      name: AppRoutes.main,
      page: MainMenuPage.new,
      binding: GlobalBinding(),
    ),
    GetPage(
      name: AppRoutes.tictactoe,
      page: TicTacToePage.new,
    ),
    GetPage(
      name: AppRoutes.rpc,
      page: RPCPage.new,
    ),
    GetPage(
      name: AppRoutes.msweeper,
      page: MSweeperPage.new,
    ),
    GetPage(
      name: AppRoutes.mnumbers,
      page: MNumbersPage.new,
    ),
    GetPage(
      name: AppRoutes.mill,
      page: MillPage.new,
    ),
    GetPage(
      name: AppRoutes.checkers,
      page: CheckersPage.new,
    ),
    GetPage(
      name: AppRoutes.ten,
      page: TenPage.new,
    ),
    GetPage(
      name: AppRoutes.othello,
      page: OthelloPage.new,
    ),
    GetPage(
      name: AppRoutes.dotbox,
      page: DotBoxPage.new,
    ),
    GetPage(
      name: AppRoutes.chess,
      page: ChessPage.new,
    ),
    GetPage(
      name: AppRoutes.yatzy,
      page: YatzyPage.new,
    ),
    GetPage(
      name: AppRoutes.fourInRow,
      page: FourInRowPage.new,
    ),
    GetPage(
      name: AppRoutes.sudoku,
      page: SudokuPage.new,
    ),
    GetPage(
      name: AppRoutes.battleship,
      page: BattleShipPage.new,
    ),
    GetPage(
      name: AppRoutes.boxFour,
      page: BattleShipPage.new,
    ),
  ];
}

import 'package:kafehfekr/Core/Global/Core/global_binding.dart';
import 'package:kafehfekr/Core/Global/Pages/main_menu_page.dart';
import 'package:kafehfekr/Core/Global/Pages/splash.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:kafehfekr/Features/Auth/Pages/auth_page.dart';
import 'package:kafehfekr/Features/Auth/Pages/username_page.dart';
import 'package:kafehfekr/Features/General/Pages/chats_page.dart';
import 'package:kafehfekr/Features/General/Pages/multi_queue_page.dart';
import 'package:kafehfekr/Games/BackGammon/Pages/backgammon_page.dart';
import 'package:kafehfekr/Games/BattleShip/Pages/battleship_page.dart';
import 'package:kafehfekr/Games/BoxFour/Pages/boxfour_page.dart';
import 'package:kafehfekr/Games/Checkers/Pages/checkers_page.dart';
import 'package:kafehfekr/Games/Chess/Pages/chess_page.dart';
import 'package:kafehfekr/Games/DotBox/Pages/dotbox_page.dart';
import 'package:kafehfekr/Games/FekrBekr/Pages/fekrbekr_offline_page.dart';
import 'package:kafehfekr/Games/FekrBekr/Pages/fekrbekr_page.dart';
import 'package:kafehfekr/Games/FourInRow/Pages/four_in_row_page.dart';
import 'package:kafehfekr/Core/Global/Core/global_middlewares.dart';
import 'package:kafehfekr/Features/General/Pages/queue_page.dart';
import 'package:kafehfekr/Features/General/Pages/game_play_page.dart';
import 'package:kafehfekr/Features/General/Pages/history_page.dart';
import 'package:kafehfekr/Features/General/Pages/library_page.dart';
import 'package:kafehfekr/Features/General/Pages/lobby_page.dart';
import 'package:kafehfekr/Features/General/Pages/maintence_page.dart';
import 'package:kafehfekr/Features/General/Pages/offline_games_menu_page.dart';
import 'package:kafehfekr/Features/General/Pages/ranking_page.dart';
import 'package:kafehfekr/Features/General/Pages/store_page.dart';
import 'package:kafehfekr/Features/General/Pages/update_page.dart';
import 'package:kafehfekr/Games/Ludo/Pages/ludo_page.dart';
import 'package:kafehfekr/Games/MNumbers/Pages/mnumbers_offline_page.dart';
import 'package:kafehfekr/Games/MNumbers/Pages/mnumbers_page.dart';
import 'package:kafehfekr/Games/MSweeper/Pages/msweeper_offline_page.dart';
import 'package:kafehfekr/Games/MSweeper/Pages/msweeper_page.dart';
import 'package:kafehfekr/Games/Mafia/Pages/mafia_offline_page.dart';
import 'package:kafehfekr/Games/Mafia/Pages/mafia_offline_roles_page.dart';
import 'package:kafehfekr/Games/Mill/Pages/mill_page.dart';
import 'package:kafehfekr/Games/Othello/Pages/othello_offline_page.dart';
import 'package:kafehfekr/Games/Othello/Pages/othello_page.dart';
import 'package:kafehfekr/Games/Pentago/Pages/pentago_page.dart';
import 'package:kafehfekr/Games/RPC/Pages/rpc_page.dart';
import 'package:kafehfekr/Games/Spy/Pages/spy_offline_page.dart';
import 'package:kafehfekr/Games/Sudoku/Pages/sudoku_offline_page.dart';
import 'package:kafehfekr/Games/Sudoku/Pages/sudoku_page.dart';
import 'package:kafehfekr/Games/Ten/Pages/ten_offline_page.dart';
import 'package:kafehfekr/Games/Ten/Pages/ten_page.dart';
import 'package:kafehfekr/Games/TicTacToe/Pages/tictactoe_offline_page.dart';
import 'package:kafehfekr/Games/TicTacToe/Pages/tictactoe_page.dart';
import 'package:kafehfekr/Games/Yatzy/Pages/yatzy_page.dart';
import 'package:kafehfekr/Games/Yinsh/Pages/yinsh_page.dart';
import 'package:refreshed/refreshed.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: SplashPage.new,
      binding: GlobalBinding(),
    ),
    GetPage(
      name: AppRoutes.queue,
      page: QueuePage.new,
      transition: Transition.fade,
      middlewares: [EnsureAuthMiddleware(), EnsureNetworkIsOnMiddleware()],
    ),
    GetPage(
      name: AppRoutes.multiQueue,
      page: MultiQueuePage.new,
      transition: Transition.fade,
      middlewares: [EnsureAuthMiddleware(), EnsureNetworkIsOnMiddleware()],
    ),
    GetPage(
      name: AppRoutes.chat,
      page: ChatsPage.new,
      transition: Transition.fade,
      middlewares: [EnsureAuthMiddleware(), EnsureNetworkIsOnMiddleware()],
    ),
    GetPage(
      name: AppRoutes.store,
      page: StorePage.new,
      middlewares: [EnsureAuthMiddleware(), EnsureNetworkIsOnMiddleware()],
    ),
    GetPage(name: AppRoutes.offlineGamesMenu, page: OfflineGamesMenuPage.new),
    GetPage(name: AppRoutes.library, page: LibraryPage.new),
    GetPage(name: AppRoutes.ranking, page: RankingPage.new),
    GetPage(name: AppRoutes.history, page: HistoryPage.new),
    GetPage(name: AppRoutes.username, page: UsernamePage.new),
    GetPage(name: AppRoutes.auth, page: AuthPage.new),
    GetPage(name: AppRoutes.update, page: UpdatePage.new),
    GetPage(name: AppRoutes.maintence, page: MaintencePage.new),
    GetPage(name: AppRoutes.main, page: MainPage.new),
    GetPage(name: AppRoutes.gamePlay, page: GamePlayPage.new),
    GetPage(name: AppRoutes.lobby, page: LobbyPage.new),
    GetPage(name: AppRoutes.tictactoe, page: TicTacToePage.new),
    GetPage(name: AppRoutes.rpc, page: RPCPage.new),
    GetPage(name: AppRoutes.fekrBekr, page: FekrBekrPage.new),
    GetPage(name: AppRoutes.pentago, page: PentagoPage.new),
    GetPage(name: AppRoutes.msweeper, page: MSweeperPage.new),
    GetPage(name: AppRoutes.mnumbers, page: MNumbersPage.new),
    GetPage(name: AppRoutes.mill, page: MillPage.new),
    GetPage(name: AppRoutes.checkers, page: CheckersPage.new),
    GetPage(name: AppRoutes.ten, page: TenPage.new),
    GetPage(name: AppRoutes.othello, page: OthelloPage.new),
    GetPage(name: AppRoutes.dotbox, page: DotBoxPage.new),
    GetPage(name: AppRoutes.chess, page: ChessPage.new),
    GetPage(name: AppRoutes.yatzy, page: YatzyPage.new),
    GetPage(name: AppRoutes.fourInRow, page: FourInRowPage.new),
    GetPage(name: AppRoutes.sudoku, page: SudokuPage.new),
    GetPage(name: AppRoutes.yinsh, page: YinshPage.new),
    GetPage(name: AppRoutes.battleship, page: BattleShipPage.new),
    GetPage(name: AppRoutes.boxFour, page: BoxFourPage.new),
    GetPage(name: AppRoutes.ludo, page: LudoPage.new),
    GetPage(name: AppRoutes.backGammon, page: BackGammonPage.new),
    GetPage(name: AppRoutes.tictactoeOffline, page: TicTacToeOfflinePage.new),
    GetPage(name: AppRoutes.msweeperOffline, page: MSweeperOfflinePage.new),
    GetPage(name: AppRoutes.mnumbersOffline, page: MNumbersOfflinePage.new),
    GetPage(name: AppRoutes.tenOffline, page: TenOfflinePage.new),
    GetPage(name: AppRoutes.fekrBekrOffline, page: FekrBekrOfflinePage.new),
    GetPage(name: AppRoutes.sudokuOffline, page: SudokuOfflinePage.new),
    GetPage(name: AppRoutes.othelloOffline, page: OthelloOfflinePage.new),
    GetPage(name: AppRoutes.mafiaOffline, page: MafiaOfflinePage.new),
    GetPage(name: AppRoutes.mafiaRolesOffline, page: MafiaOfflineRolesPage.new),
    GetPage(name: AppRoutes.spyOffline, page: SpyOfflinePage.new),
  ];
}

class UserHistoryModel {
  final int winRank, loseRank, drawRank;

  final (int?, int?, int?) rankTicTacToe;
  final (int?, int?, int?) rankRPC;
  final (int?, int?, int?) rankDotBox;
  final (int?, int?, int?) rankTen;
  final (int?, int?, int?) rankMSweeper;
  final (int?, int?, int?) rankMNumbers;
  final (int?, int?, int?) rankYatzy;
  final (int?, int?, int?) rankFourInRow;
  final (int?, int?, int?) rankSudoku;
  final (int?, int?, int?) rankBattleShip;
  final (int?, int?, int?) rankBoxFour;
  final (int?, int?, int?) rankChess;
  final (int?, int?, int?) rankCheckers;
  final (int?, int?, int?) rankOthello;
  final (int?, int?, int?) rankMill;
  final (int?, int?, int?) rankBackGammon;
  final (int?, int?, int?) rankFekrBekr;
  final (int?, int?, int?) rankPentago;
  final (int?, int?, int?) rankYinsh;

  UserHistoryModel({
    required this.winRank,
    required this.loseRank,
    required this.drawRank,
    this.rankTicTacToe = (null, null, null),
    this.rankRPC = (null, null, null),
    this.rankDotBox = (null, null, null),
    this.rankTen = (null, null, null),
    this.rankMSweeper = (null, null, null),
    this.rankMNumbers = (null, null, null),
    this.rankYatzy = (null, null, null),
    this.rankFourInRow = (null, null, null),
    this.rankSudoku = (null, null, null),
    this.rankBattleShip = (null, null, null),
    this.rankBoxFour = (null, null, null),
    this.rankChess = (null, null, null),
    this.rankCheckers = (null, null, null),
    this.rankOthello = (null, null, null),
    this.rankMill = (null, null, null),
    this.rankBackGammon = (null, null, null),
    this.rankFekrBekr = (null, null, null),
    this.rankPentago = (null, null, null),
    this.rankYinsh = (null, null, null),
  });

  factory UserHistoryModel.fromJson(Map data) {
    final (int?, int?, int?) rankTicTacToe =
        (data['tictactoe_win'], data['tictactoe_draw'], data['tictactoe_lose']);
    final (int?, int?, int?) rankRPC =
        (data['rpc_win'], data['rpc_draw'], data['rpc_lose']);
    final (int?, int?, int?) rankDotBox =
        (data['dotbox_win'], data['dotbox_draw'], data['dotbox_lose']);
    final (int?, int?, int?) rankTen =
        (data['ten_win'], data['ten_draw'], data['ten_lose']);
    final (int?, int?, int?) rankMSweeper =
        (data['msweeper_win'], data['msweeper_draw'], data['msweeper_lose']);
    final (int?, int?, int?) rankMNumbers =
        (data['mnumbers_win'], data['mnumbers_draw'], data['mnumbers_lose']);
    final (int?, int?, int?) rankYatzy =
        (data['yatzy_win'], data['yatzy_draw'], data['yatzy_lose']);
    final (int?, int?, int?) rankFourInRow =
        (data['fourinrow_win'], data['fourinrow_draw'], data['fourinrow_lose']);
    final (int?, int?, int?) rankSudoku =
        (data['sudoku_win'], data['sudoku_draw'], data['sudoku_lose']);
    final (int?, int?, int?) rankBattleShip = (
      data['battleship_win'],
      data['battleship_draw'],
      data['battleship_lose']
    );
    final (int?, int?, int?) rankBoxFour =
        (data['boxfour_win'], data['boxfour_draw'], data['boxfour_lose']);
    final (int?, int?, int?) rankChess =
        (data['chess_win'], data['chess_draw'], data['chess_lose']);
    final (int?, int?, int?) rankCheckers =
        (data['checkers_win'], data['checkers_draw'], data['checkers_lose']);
    final (int?, int?, int?) rankOthello =
        (data['othello_win'], data['othello_draw'], data['othello_lose']);
    final (int?, int?, int?) rankMill =
        (data['mill_win'], data['mill_draw'], data['mill_lose']);
    final (int?, int?, int?) rankBackGammon = (
      data['backgammon_win'],
      data['backgammon_draw'],
      data['backgammon_lose']
    );
    final (int?, int?, int?) rankFekrBekr =
        (data['fekrbekr_win'], data['fekrbekr_draw'], data['fekrbekr_lose']);
    final (int?, int?, int?) rankPentago =
        (data['pentago_win'], data['pentago_draw'], data['pentago_lose']);
    final (int?, int?, int?) rankYinsh =
        (data['yinsh_win'], data['yinsh_draw'], data['yinsh_lose']);
    return UserHistoryModel(
      winRank: data['win_rank'] ?? 0,
      loseRank: data['lose_rank'] ?? 0,
      drawRank: data['draw_rank'] ?? 0,
      rankTicTacToe: rankTicTacToe,
      rankRPC: rankRPC,
      rankDotBox: rankDotBox,
      rankTen: rankTen,
      rankMSweeper: rankMSweeper,
      rankMNumbers: rankMNumbers,
      rankYatzy: rankYatzy,
      rankFourInRow: rankFourInRow,
      rankSudoku: rankSudoku,
      rankBattleShip: rankBattleShip,
      rankBoxFour: rankBoxFour,
      rankChess: rankChess,
      rankCheckers: rankCheckers,
      rankOthello: rankOthello,
      rankMill: rankMill,
      rankBackGammon: rankBackGammon,
      rankFekrBekr: rankFekrBekr,
      rankPentago: rankPentago,
      rankYinsh: rankYinsh,
    );
  }
  UserHistoryModel copyWith({
    int? loseRank,
    int? winRank,
    int? drawRank,
  }) =>
      UserHistoryModel(
        loseRank: loseRank ?? this.loseRank,
        winRank: winRank ?? this.winRank,
        drawRank: drawRank ?? this.drawRank,
      );
}

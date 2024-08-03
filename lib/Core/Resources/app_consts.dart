class GameWaitTimes {
  static const int tictactoeRoundTime = 10;
  static const int rpcRoundTime = 5;
  static const int rpcSleepRoundTime = 3;
  static const int millSelectTime = 15;
  static const int millRemoveTime = 15;
  static const int msweeperGameTime = 600;
  static const int mnumbersTurnTime = 5;
  static const int checkersTurnTime = 20;
}

class FontFamilies {
  static const vazir = "Vazir";
  static const dastnevis = "Dastnevis";
  static const typo = "Typo";
}

abstract class GameCommands {
  static const gameData = "GameData";
  static const reconnectData = "ReconnectData";
  static const reaction = "Reaction";
  static const currentTurn = "CurrentTurn";
  static const selectPeace = "SelectPeace";
  static const selectPeaceResult = "SelectPeaceResult";
  static const swapPeace = "SwapPeace";
  static const selectRemovePeace = "SelectRemovePeace";
  static const peaceSelected = "PeaceSelected";
  static const peaceSwaped = "PeaceSwaped";
  static const peaceRemoved = "PeaceRemoved";
  static const newTurnRound = "NewTurnRound";
  static const newRound = "NewRound";
  static const finishTurnRound = "FinishTurnRound";
  static const finishRound = "FinishRound";
  static const startGame = "StartGame";
  static const finishGame = "FinishGame";
  static const selectMine = "SelectMine";
  static const selectMineCorrect = "SelectMineCorrect";
  static const selectMineWrong = "SelectMineWrong";
  static const mineSelected = "MineSelected";
  static const playerScore = "PlayerScore";
  static const surrender = "Surrender";
  static const userDisconnected = "UserDisconnected";
  static const userReconnected = "UserReconnected";
  static const finishReconnectTime = "FinishReconnectTime";
}

class CupsCount {
  static const tictactoeWin = 1;
  static const tictactoeLose = -1;
  static const rpcWin = 1;
  static const rpcLose = -1;
  static const millWin = 1;
  static const millLose = -1;
  static const msweeperWin = 1;
  static const msweeperLose = -1;
  static const mnumbersWin = 1;
  static const mnumbersLose = -1;
  static const checkersWin = 1;
  static const checkersLose = -1;
}

class CoinsCount {
  static const tictactoeWin = 2;
  static const tictactoeLose = -2;
  static const rpcWin = 1;
  static const rpcLose = -1;
  static const millWin = 1;
  static const millLose = -1;
  static const msweeperWin = 1;
  static const msweeperLose = -1;
  static const mnumbersWin = 1;
  static const mnumbersLose = -1;
  static const checkersWin = 1;
  static const checkersLose = -1;
}

class GeneralGameConsts {
  static const double maxGameWidth = 500;
  static const int maxDisconnectTime = 120;
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';

class GameWaitTimes {
  static const int startGameTime = 5;
  static const int tictactoeRoundTime = 10;
  static const int tictactoeSleepRoundTime = 5;
  static const int rpcRoundTime = 5;
  static const int rpcSleepRoundTime = 3;
  static const int millSelectTime = 15;
  static const int millRemoveTime = 15;
  static const int msweeperGameTime = 600;
  static const int mnumbersTurnTime = 5;
  static const int mnumbersShowResultTime = 2;
  static const int checkersTurnTime = 20;
  static const int chessTurnTime = 20;
  static const int tenSleepRoundTime = 5;
  static const int tenRoundTime = 300;
  static const int othelloTurnTime = 20;
  static const int dotBoxTurnTime = 15;
  static const int yatzyTurnTime = 60;
  static const int fourInRowTurnTime = 15;
  static const int sudokuGameTime = 600;
  static const int battleshipBoardTime = 60;
  static const int battleshipTurnTime = 12;
  static const int battleshipWaitTime = 4;
  static const int boxFourTurnTime = 15;
  static const int backGammonTurnTime = 30;
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
  static const rollDice = "RollDice";
  static const rollResult = "RollResult";
  static const selectPeace = "SelectPeace";
  static const selectPeaceResult = "SelectPeaceResult";
  static const swapPeace = "SwapPeace";
  static const removePeace = "RemovePeace";
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
  static const solve = "Solve";
  static const saveBoard = "SaveBoard";
  static const waitTime = "WaitTime";
  static const wrongSolve = "WrongSolve";
  static const selectMineCorrect = "SelectMineCorrect";
  static const selectMineWrong = "SelectMineWrong";
  static const mineSelected = "MineSelected";
  static const playerScore = "PlayerScore";
  static const surrender = "Surrender";
  static const userDisconnected = "UserDisconnected";
  static const userReconnected = "UserReconnected";
  static const finishReconnectTime = "FinishReconnectTime";
  static const gameFinished = "GameFinished";
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

class GameRoundCounts {
  static const int tictactoeRoundCount = 5;
  static const int rpcRoundCount = 3;
  static const int rpcTurnRoundCount = 5;
  static const int tenRoundCount = 3;
}

class StorageKeys {
  static const String userId = "userId";
  static const String token = "token";
  static const String gameId = "gameId";
  static const String gameType = "gameType";
}

List<String> bottomNavigationTexts = [
  AppTexts.profile,
  AppTexts.ranking,
  AppTexts.gameMenu,
  AppTexts.clan,
  AppTexts.settings,
];

List<IconData> bottomNavigationIcons = [
  Icons.person_4_rounded,
  CupertinoIcons.star_circle_fill,
  CupertinoIcons.game_controller_solid,
  CupertinoIcons.person_3_fill,
  Icons.settings,
];

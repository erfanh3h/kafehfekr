import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class GameTypeConvertor {
  final GameTypes gameType;

  GameTypeConvertor({required this.gameType});

  String toGameImage() {
    String result = '';
    switch (gameType) {
      case GameTypes.TicTacToe:
        result = AppImages.tictactoeGame;
        break;
      case GameTypes.FekrBekr:
        result = AppImages.tictactoeGame;
        break;
      case GameTypes.Pentago:
        result = AppImages.tictactoeGame;
        break;
      case GameTypes.RPC:
        result = AppImages.rpcGame;
        break;
      case GameTypes.BackGammon:
        result = AppImages.backgammonGame;
        break;
      case GameTypes.Checkers:
        result = AppImages.checkersGame;
        break;
      case GameTypes.Chess:
        result = AppImages.chessGame;
        break;
      case GameTypes.Ten:
        result = AppImages.tenGame;
        break;
      case GameTypes.BattleShip:
        result = AppImages.battleshipGame;
        break;
      case GameTypes.DotBox:
        result = AppImages.dotboxGame;
        break;
      case GameTypes.BoxFour:
        result = AppImages.boxfourGame;
        break;
      case GameTypes.Yatzy:
        result = AppImages.yatzyGame;
        break;
      case GameTypes.Mill:
        result = AppImages.millGame;
        break;
      case GameTypes.Othello:
        result = AppImages.othelloGame;
        break;
      case GameTypes.Sudoku:
        result = AppImages.sudokuGame;
        break;
      case GameTypes.MNumbers:
        result = AppImages.mnumbersGame;
        break;
      case GameTypes.MSweeper:
        result = AppImages.msweeperGame;
        break;
      case GameTypes.FourInRow:
        result = AppImages.fourinrowGame;
        break;
      default:
    }
    return result;
  }

  String toGameNarrative() {
    String result = '';
    switch (gameType) {
      case GameTypes.TicTacToe:
        result = AppTexts.tictactoeNarrative.tr;
        break;
      case GameTypes.FekrBekr:
        result = AppTexts.fekrBekrNarrative.tr;
        break;
      case GameTypes.Pentago:
        result = AppTexts.pentagoNarrative.tr;
        break;
      case GameTypes.RPC:
        result = AppTexts.rpcNarrative.tr;
        break;
      case GameTypes.BackGammon:
        result = AppTexts.backGammonNarrative.tr;
        break;
      case GameTypes.Checkers:
        result = AppTexts.checkersNarrative.tr;
        break;
      case GameTypes.Chess:
        result = AppTexts.chessNarrative.tr;
        break;
      case GameTypes.Ten:
        result = AppTexts.tenNarrative.tr;
        break;
      case GameTypes.BattleShip:
        result = AppTexts.battleshipNarrative.tr;
        break;
      case GameTypes.DotBox:
        result = AppTexts.dotboxNarrative.tr;
        break;
      case GameTypes.BoxFour:
        result = AppTexts.boxFourNarrative.tr;
        break;
      case GameTypes.Yatzy:
        result = AppTexts.yatzyNarrative.tr;
        break;
      case GameTypes.Mill:
        result = AppTexts.millNarrative.tr;
        break;
      case GameTypes.Othello:
        result = AppTexts.othelloNarrative.tr;
        break;
      case GameTypes.Sudoku:
        result = AppTexts.sudokuNarrative.tr;
        break;
      case GameTypes.MNumbers:
        result = AppTexts.mnumbersNarrative.tr;
        break;
      case GameTypes.MSweeper:
        result = AppTexts.msweeperNarrative.tr;
        break;
      case GameTypes.FourInRow:
        result = AppTexts.fourInRowNarrative.tr;
        break;
      default:
    }
    return result;
  }

  GameDifficulties toGameDifficallty() {
    GameDifficulties result;
    switch (gameType) {
      case GameTypes.TicTacToe:
        result = GameDifficulties.Easy;
        break;
      case GameTypes.FekrBekr:
        result = GameDifficulties.Normal;
        break;
      case GameTypes.Pentago:
        result = GameDifficulties.Normal;
        break;
      case GameTypes.RPC:
        result = GameDifficulties.Easy;
        break;
      case GameTypes.BackGammon:
        result = GameDifficulties.Hard;
        break;
      case GameTypes.Checkers:
        result = GameDifficulties.Hard;
        break;
      case GameTypes.Chess:
        result = GameDifficulties.Hard;
        break;
      case GameTypes.Ten:
        result = GameDifficulties.Easy;
        break;
      case GameTypes.BattleShip:
        result = GameDifficulties.Normal;
        break;
      case GameTypes.DotBox:
        result = GameDifficulties.Easy;
        break;
      case GameTypes.BoxFour:
        result = GameDifficulties.Normal;
        break;
      case GameTypes.Yatzy:
        result = GameDifficulties.Normal;
        break;
      case GameTypes.Mill:
        result = GameDifficulties.Hard;
        break;
      case GameTypes.Othello:
        result = GameDifficulties.Hard;
        break;
      case GameTypes.Sudoku:
        result = GameDifficulties.Normal;
        break;
      case GameTypes.MNumbers:
        result = GameDifficulties.Normal;
        break;
      case GameTypes.MSweeper:
        result = GameDifficulties.Normal;
        break;
      case GameTypes.FourInRow:
        result = GameDifficulties.Normal;
        break;
      default:
        result = GameDifficulties.Easy;
    }
    return result;
  }

  List<int> toGameRewards() {
    List<int> result = [];
    GameDifficulties difficulty = toGameDifficallty();
    switch (difficulty) {
      case GameDifficulties.Easy:
        result = [10, 8, 4, 2, 1];
        break;
      case GameDifficulties.Normal:
        result = [15, 16, 8, 3, 2];
        break;
      case GameDifficulties.Hard:
        result = [20, 24, 12, 4, 3];
        break;
      default:
    }
    return result;
  }
}

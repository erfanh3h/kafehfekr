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
      case GameTypes.RPC:
        result = AppImages.tictactoeGame;
        break;
      case GameTypes.BackGammon:
        result = AppImages.tictactoeGame;
        break;
      case GameTypes.Checkers:
        result = AppImages.tictactoeGame;
        break;
      case GameTypes.Chess:
        result = AppImages.tictactoeGame;
        break;
      case GameTypes.Ten:
        result = AppImages.tictactoeGame;
        break;
      case GameTypes.BattleShip:
        result = AppImages.tictactoeGame;
        break;
      case GameTypes.DotBox:
        result = AppImages.tictactoeGame;
        break;
      case GameTypes.BoxFour:
        result = AppImages.tictactoeGame;
        break;
      case GameTypes.Yatzy:
        result = AppImages.tictactoeGame;
        break;
      case GameTypes.Mill:
        result = AppImages.tictactoeGame;
        break;
      case GameTypes.Othello:
        result = AppImages.tictactoeGame;
        break;
      case GameTypes.Sudoku:
        result = AppImages.tictactoeGame;
        break;
      case GameTypes.MNumbers:
        result = AppImages.tictactoeGame;
        break;
      case GameTypes.MSweeper:
        result = AppImages.tictactoeGame;
        break;
      case GameTypes.FourInRow:
        result = AppImages.tictactoeGame;
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
}

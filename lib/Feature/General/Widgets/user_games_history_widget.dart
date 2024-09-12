import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/General/Models/user_history_model.dart';
import 'package:kafehfekr/Feature/General/Widgets/game_history_row_widget.dart';
import 'package:refreshed/refreshed.dart';

class UserGamesHistoryWidget extends StatelessWidget {
  const UserGamesHistoryWidget({
    super.key,
    required this.data,
  });

  final UserHistoryModel data;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: .9,
      child: ListView(
        children: [
          GameHistoryRowWidget(
            data: data.rankTicTacToe,
            name: AppTexts.tictactoe.tr,
          ),
          GameHistoryRowWidget(
            data: data.rankRPC,
            name: AppTexts.rpc.tr,
          ),
          GameHistoryRowWidget(
            data: data.rankDotBox,
            name: AppTexts.dotbox.tr,
          ),
          GameHistoryRowWidget(
            data: data.rankTen,
            name: AppTexts.ten.tr,
          ),
          GameHistoryRowWidget(
            data: data.rankMSweeper,
            name: AppTexts.msweeper.tr,
          ),
          GameHistoryRowWidget(
            data: data.rankMNumbers,
            name: AppTexts.mnumbers.tr,
          ),
          GameHistoryRowWidget(
            data: data.rankYatzy,
            name: AppTexts.yatzy.tr,
          ),
          GameHistoryRowWidget(
            data: data.rankFourInRow,
            name: AppTexts.fourInRow.tr,
          ),
          GameHistoryRowWidget(
            data: data.rankSudoku,
            name: AppTexts.sudoku.tr,
          ),
          GameHistoryRowWidget(
            data: data.rankBattleShip,
            name: AppTexts.battleship.tr,
          ),
          GameHistoryRowWidget(
            data: data.rankBoxFour,
            name: AppTexts.boxFour.tr,
          ),
          GameHistoryRowWidget(
            data: data.rankChess,
            name: AppTexts.chess.tr,
          ),
          GameHistoryRowWidget(
            data: data.rankCheckers,
            name: AppTexts.checkers.tr,
          ),
          GameHistoryRowWidget(
            data: data.rankOthello,
            name: AppTexts.othello.tr,
          ),
          GameHistoryRowWidget(
            data: data.rankMill,
            name: AppTexts.mill.tr,
          ),
          GameHistoryRowWidget(
            data: data.rankBackGammon,
            name: AppTexts.backGammon.tr,
          ),
        ],
      ),
    );
  }
}

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
            data: data.rankMSweeper,
            name: AppTexts.msweeper.tr,
          ),
          GameHistoryRowWidget(
            data: data.rankMNumbers,
            name: AppTexts.mnumbers.tr,
          ),
          GameHistoryRowWidget(
            data: data.rankCheckers,
            name: AppTexts.checkers.tr,
          ),
        ],
      ),
    );
  }
}

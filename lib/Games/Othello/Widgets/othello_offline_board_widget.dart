import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/Othello/Controllers/othello_offline_controller.dart';
import 'package:kafehfekr/Games/Othello/Widgets/othello_offline_button.dart';

class OthelloOfflineBoardWidget extends StatelessWidget {
  const OthelloOfflineBoardWidget({super.key, required this.controller});

  final OthelloOfflineController controller;

  @override
  Widget build(BuildContext context) {
    const int boardSize = 8;
    return Padding(
      padding: AppSpacings.s10All,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: boardSize,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemCount: boardSize * boardSize,
        itemBuilder: (context, index) => OthelloOfflineButtonWidget(
          controller: controller,
          index: index,
        ),
      ),
    );
  }
}

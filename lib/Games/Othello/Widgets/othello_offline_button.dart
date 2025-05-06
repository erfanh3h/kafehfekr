import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Games/Othello/Controllers/othello_offline_controller.dart';

class OthelloOfflineButtonWidget extends StatelessWidget {
  const OthelloOfflineButtonWidget({
    super.key,
    required this.controller,
    required this.index,
  });

  final OthelloOfflineController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    const int boardSize = 8;
    int x = index ~/ boardSize;
    int y = index % boardSize;
    final disk = controller.board[x][y];
    final isHint =
        controller.possibleMoves.value.any((pos) => pos[0] == x && pos[1] == y);

    final baseColor = isHint ? AppColors.white : AppColors.lightColor3;
    Color? color;
    if (disk == Disk.black) color = Colors.black;
    if (disk == Disk.white) color = Colors.white;
    return GestureDetector(
      onTap: () => controller.placeDisk(x, y),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [baseColor, AppColors.lightColor],
          ),
          border: Border.all(color: AppColors.black, width: 1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: color != null
              ? Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

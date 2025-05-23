import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
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

    final baseColor = isHint
        ? controller.currentPlayer.value == Disk.black
            ? AppColors.darkColor
            : AppColors.lightColor
        : AppColors.transparent;
    Color? color;
    if (disk == Disk.black) color = Colors.black;
    if (disk == Disk.white) color = Colors.white;
    return GlobalFrameWrapper(
      frame: AppImages.button4,
      padding: AppSpacings.s2All,
      child: GestureDetector(
        onTap: () => controller.placeDisk(x, y),
        child: Container(
          decoration: BoxDecoration(
            color: baseColor,
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/Yatzy/Models/yatzy_peace_model.dart';
import 'package:kafehfekr/Feature/Yatzy/Widgets/yatzy_button.dart';

class YatzyRowWidget extends StatelessWidget {
  const YatzyRowWidget({
    super.key,
    required this.headerImage,
    required this.player1Piece,
    required this.player2Piece,
    required this.index,
    required this.myGameId,
    required this.onEachButtonTap,
    required this.onRowTap,
  });

  final String headerImage;
  final YatzyPeaceModel player1Piece;
  final YatzyPeaceModel player2Piece;
  final int index;
  final int myGameId;
  final Function(YatzyPeaceModel) onEachButtonTap;
  final Function(int) onRowTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onRowTap(index);
      },
      child: Container(
        margin: AppSpacings.s3Vertical,
        padding: AppSpacings.s5All,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: index % 2 == 0 ? Colors.white12 : Colors.transparent,
        ),
        child: Row(
          children: [
            Expanded(
              child: YatzyButton(
                pieceData: player2Piece,
                onTap: onEachButtonTap,
                myGameId: myGameId,
              ),
            ),
            const SizedBox(width: 3),
            Expanded(
              child: YatzyButton(
                pieceData: player1Piece,
                onTap: onEachButtonTap,
                myGameId: myGameId,
              ),
            ),
            const SizedBox(width: 3),
            Expanded(
              child: Container(
                padding: AppSpacings.s5All,
                decoration: BoxDecoration(
                  color: AppColors.lightColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  headerImage,
                  color: AppColors.darkGreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

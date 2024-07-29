import 'package:flutter/cupertino.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class MillNotPlayedPeacesBox extends StatelessWidget {
  const MillNotPlayedPeacesBox({
    super.key,
    required this.player1Count,
    required this.player2Count,
    required this.player1Color,
    required this.player2Color,
  });

  final int player1Count;
  final int player2Count;
  final Color player1Color;
  final Color player2Color;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          const BoxConstraints(maxWidth: GeneralGameConsts.maxGameWidth),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: AppSpacings.s5All,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                shrinkWrap: true,
                itemBuilder: (ctx, index) => SingleBox(
                  color: index < player1Count
                      ? player1Color
                      : player1Color.withOpacity(.3),
                ),
                itemCount: 10,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: AppSpacings.s5All,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                shrinkWrap: true,
                itemBuilder: (ctx, index) => SingleBox(
                  color: index < player2Count
                      ? player2Color
                      : player2Color.withOpacity(.3),
                ),
                itemCount: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SingleBox extends StatelessWidget {
  const SingleBox({
    super.key,
    required this.color,
  });

  final Color color;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      GeneralIcons.circle3,
      color: color,
    );
  }
}

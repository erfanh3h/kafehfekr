import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:refreshed/refreshed.dart';

class GameMenuGamePartWidget extends StatelessWidget {
  const GameMenuGamePartWidget({
    super.key,
    required this.items,
    required this.onTap,
  });

  final List<GameTypes> items;
  final Function(String) onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.size.width * 4 / 6,
      child: Column(
        children: [
          Expanded(child: ItemRowBox(onTap: onTap, game: items[0])),
          Expanded(child: ItemRowBox(onTap: onTap, game: items[1])),
        ],
      ),
    );
  }
}

class ItemRowBox extends StatelessWidget {
  const ItemRowBox({
    super.key,
    required this.onTap,
    required this.game,
  });

  final Function(String) onTap;
  final GameTypes game;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(game.name),
      child: Container(
        margin: AppSpacings.s10All,
        // color: Color.fromRGBO(200, index * 10, index * 10, 1),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromARGB(1, 212, 133, 126),
              Color.fromARGB(255, 214, 172, 168),
            ],
          ),
          border: Border.all(
            color: AppColors.lightColor,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            game.name.tr,
            style: TextStyle(
              fontSize: 25,
              foreground: Paint()
                ..strokeWidth = 1.5
                ..color = AppColors.lightColor
                ..style = PaintingStyle.stroke,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

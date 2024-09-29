import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/General/Controllers/game_menu_controller.dart';

class RankGamePartWidget extends StatelessWidget {
  const RankGamePartWidget({super.key, required this.controller});

  final GameMenuController controller;

  @override
  Widget build(BuildContext context) {
    final gameTypesParts = GameTypes.values.toList();
    final int gamesLength = gameTypesParts.length - 1;

    return Padding(
      padding: AppSpacings.s10Horizental,
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Row(
            children: [
              Text("0/5"),
              Text("data"),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemBuilder: (ctx, index) => Container(),
              separatorBuilder: (ctx, index) => const SizedBox(height: 5),
              itemCount: gamesLength,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

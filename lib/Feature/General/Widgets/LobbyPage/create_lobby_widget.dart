import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_input_box.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class CreateLobbyWidget extends StatelessWidget {
  const CreateLobbyWidget({
    super.key,
    required this.lobbyNameController,
    required this.onCreate,
    required this.onChangeGameType,
    required this.selectedGameType,
  });

  final TextEditingController lobbyNameController;
  final VoidCallback onCreate;
  final Function(GameTypes?) onChangeGameType;
  final GameTypes? selectedGameType;

  @override
  Widget build(BuildContext context) {
    final gameTypesParts = GameTypes.values.toList();
    final int gamesLength = marketType == MarketTypes.Bazaar
        ? gameTypesParts.length - 1
        : gameTypesParts.length;
    List<DropdownMenuItem<GameTypes>>? items = [];
    for (var i = 0; i < gamesLength; i++) {
      final value = gameTypesParts[i];
      final gameConvertor = GameTypeConvertor(gameType: value);
      items.add(DropdownMenuItem<GameTypes>(
        value: value,
        child: Row(
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image: DecorationImage(
                  image: AssetImage(
                    gameConvertor.toGameImage(),
                  ),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: AppColors.lightColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 5),
            Text(
              value.name.tr,
              style: const TextStyle(
                color: AppColors.lightColor,
              ),
            ),
          ],
        ),
      ));
    }
    return Container(
      padding: AppSpacings.s20All,
      child: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  AppTexts.lobbyName.tr,
                  style: const TextStyle(
                    color: AppColors.lightColor,
                    fontSize: 22,
                  ),
                ),
              ),
              Expanded(
                child: GlobalInputBox(
                  label: AppTexts.lobbyName.tr,
                  controller: lobbyNameController,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: Text(
                  AppTexts.selectGameType.tr,
                  style: const TextStyle(
                    color: AppColors.lightColor,
                    fontSize: 22,
                  ),
                ),
              ),
              Expanded(
                child: DropdownButton<GameTypes>(
                  items: items,
                  onChanged: onChangeGameType,
                  value: selectedGameType,
                  dropdownColor: AppColors.darkRed,
                  underline: null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          GlobalButtonWidget(
            onTap: onCreate,
            text: AppTexts.createLobby.tr,
          )
        ],
      ),
    );
  }
}

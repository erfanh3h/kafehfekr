import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_input_box.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
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
    // final int gamesLength = gameTypesParts.length - 1;
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
              )),
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
                  items: gameTypesParts.map((GameTypes value) {
                    return DropdownMenuItem<GameTypes>(
                      value: value,
                      child: Text(
                        value.name.tr,
                        style: const TextStyle(
                          color: AppColors.lightColor,
                        ),
                      ),
                    );
                  }).toList(),
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

import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_input_box.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/General/Widgets/game_button.dart';
import 'package:refreshed/refreshed.dart';

class CreateLobbyWidget extends StatefulWidget {
  const CreateLobbyWidget({
    super.key,
    required this.lobbyNameController,
    required this.onCreate,
  });

  final TextEditingController lobbyNameController;
  final Function(int) onCreate;

  @override
  State<CreateLobbyWidget> createState() => _CreateLobbyWidgetState();
}

class _CreateLobbyWidgetState extends State<CreateLobbyWidget> {
  int selectedLobbyIndex = -1;
  @override
  Widget build(BuildContext context) {
    final gameTypesParts = GameTypes.values.toList();
    final int gamesLength = marketType == MarketTypes.Bazaar
        ? gameTypesParts.length - 1
        : gameTypesParts.length;
    List<DropdownMenuEntry<GameTypes>>? items = [];
    for (var i = 0; i < gamesLength; i++) {
      final value = gameTypesParts[i];
      final gameConvertor = GameTypeConvertor(gameType: value);
      items.add(
        DropdownMenuEntry<GameTypes>(
          value: value,
          label: value.name.tr,
          leadingIcon: Container(
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
                color: AppColors.darkColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          labelWidget: Text(
            value.name.tr,
            style: const TextStyle(
              color: AppColors.darkColor,
            ),
          ),
        ),
      );
    }
    return Container(
      padding: AppSpacings.s10All,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GlobalInputBox(
                  label: AppTexts.lobbyName.tr,
                  controller: widget.lobbyNameController,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () => widget.onCreate(selectedLobbyIndex),
                child: const GlobalFrameWrapper(
                  padding: AppSpacings.s10All,
                  frame: AppImages.check,
                  child: SizedBox(
                    height: 25,
                    width: 25,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemBuilder: (ctx, index) => Container(
                decoration: BoxDecoration(
                  border: selectedLobbyIndex == index
                      ? Border.all(
                          color: AppColors.lightColor,
                          width: 3,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GameButtonWidget(
                  onTap: () {
                    setState(() {
                      selectedLobbyIndex = index;
                    });
                    // Get.bottomSheet(
                    //   GlobalGameGuideWidget(gameType: GameTypes.values[index]),
                    //   backgroundColor: AppColors.darkColor,
                    // );
                  },
                  image: GameTypeConvertor(gameType: GameTypes.values[index])
                      .toGameImage(),
                  text: GameTypes.values[index].name,
                  imageColor: null,
                  fontSize: 18,
                ),
              ),
              itemCount: gamesLength,
            ),
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       flex: 2,
          //       child: Text(
          //         AppTexts.selectGameType.tr,
          //         style: const TextStyle(
          //           color: AppColors.lightColor,
          //           fontSize: 22,
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       flex: 3,
          //       child: DropdownMenu<GameTypes>(
          //         onSelected: onChangeGameType,
          //         dropdownMenuEntries: items,
          //         textStyle: const TextStyle(color: AppColors.lightColor),
          //         trailingIcon: const Icon(
          //           CupertinoIcons.chevron_down,
          //           color: AppColors.lightColor,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

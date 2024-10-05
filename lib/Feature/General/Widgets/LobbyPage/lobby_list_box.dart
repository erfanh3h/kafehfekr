import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/General/Controllers/lobby_controller.dart';
import 'package:kafehfekr/Feature/General/Widgets/LobbyPage/create_lobby_widget.dart';
import 'package:kafehfekr/Feature/General/Widgets/LobbyPage/lobby_room_row_widget.dart';
import 'package:refreshed/refreshed.dart';

class LobbyListBox extends StatelessWidget {
  const LobbyListBox({
    super.key,
    required this.controller,
  });

  final LobbyController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: AppSpacings.s20Top,
          child: Center(
            child: Text(
              AppTexts.lobbyList.tr,
              style: const TextStyle(
                color: AppColors.lightColor,
                fontSize: 28,
                fontFamily: FontFamilies.dastnevis,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Padding(
            padding: AppSpacings.s20Horizental,
            child: Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) => LobbyRoomRowWidget(
                  lobby: controller.lobbies[index],
                ),
                itemCount: controller.lobbies.length,
              ),
            ),
          ),
        ),
        // const Spacer(
        //   flex: 2,
        // ),
        Container(
          margin: AppSpacings.s20Bottom,
          padding: AppSpacings.s10All,
          child: Row(
            children: [
              Expanded(
                child: GlobalButtonWidget(
                  onTap: () {
                    Get.bottomSheet(
                      Obx(
                        () => CreateLobbyWidget(
                          lobbyNameController: controller.lobbyNameController,
                          onCreate: controller.onCreateLobby,
                          onChangeGameType: controller.onChangeGameType,
                          selectedGameType:
                              controller.selectedCreateGameType.value,
                        ),
                      ),
                      backgroundColor: AppColors.darkColor,
                    );
                  },
                  text: AppTexts.createLobby.tr,
                  color: AppColors.blueWarmColor,
                ),
              ),
              Expanded(
                child: GlobalButtonWidget(
                  onTap: () {
                    Get.back();
                  },
                  text: AppTexts.back.tr,
                  color: AppColors.buttonRed,
                ),
              ),
            ],
          ),
        )
        // GlobalActivityBox<FourInRowController>(),
        // const Spacer(flex: 1),
      ],
    );
  }
}

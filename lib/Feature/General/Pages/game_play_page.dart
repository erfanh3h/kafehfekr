import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/General/Controllers/game_play_controller.dart';
import 'package:kafehfekr/Feature/General/Widgets/GameMenu/game_play_users_data_widget.dart';
import 'package:refreshed/refreshed.dart';

class GamePlayPage extends BaseView<GamePlayController> {
  const GamePlayPage({super.key});

  @override
  Widget loadingWidget() {
    return const GlobalLoadingWidget(
      color: AppColors.lightColor,
    );
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      height: Get.size.height,
      width: Get.size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background2),
          fit: BoxFit.fill,
        ),
      ),
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (controller.queuers.length > 1)
              GamePlayUsersDataWidget(
                player1Data: controller.queuers[0],
                player2Data: controller.queuers[1],
                player1Number1: controller.player1Score.value,
                player2Number1: controller.player2Score.value,
                timerValue: controller.timerValue.value,
              ),
            const Spacer(),
            if (controller.gameTypes.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    AppTexts.games.tr,
                    style: const TextStyle(
                      color: AppColors.lightColor,
                      fontSize: 35,
                      fontFamily: FontFamilies.dastnevis,
                      letterSpacing: 2.5,
                    ),
                  ),
                  Image.asset(
                    controller.gameScoreType == "Rank"
                        ? GeneralIcons.rank
                        : GeneralIcons.normal,
                    width: 50,
                    height: 50,
                    color: AppColors.lightColor,
                  ),
                ],
              ),
            const SizedBox(height: 40),
            Padding(
              padding: AppSpacings.s20Horizental,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) => GamePlayGameRowBox(
                  gameType: controller.gameTypes[index],
                  isActiveGame: controller.currentGameIndex.value == index,
                  isFinished: index < controller.currentGameIndex.value,
                ),
                itemCount: controller.gameTypes.length,
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            if (controller.isGameFinished.value)
              Container(
                width: double.maxFinite,
                padding: AppSpacings.s10Horizental,
                margin: AppSpacings.s10Bottom,
                child: GlobalButtonWidget(
                  onTap: () {
                    Get.back();
                  },
                  text: AppTexts.exit.tr,
                  color: AppColors.buttonRed,
                ),
              )
            // GlobalActivityBox<FourInRowController>(),
            // const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}

class GamePlayGameRowBox extends StatelessWidget {
  const GamePlayGameRowBox({
    super.key,
    required this.gameType,
    required this.isActiveGame,
    required this.isFinished,
  });

  final String gameType;
  final bool isActiveGame;
  final bool isFinished;
  @override
  Widget build(BuildContext context) {
    Color? color;
    if (isFinished) {
      color = AppColors.darkRed;
    } else if (isActiveGame) {
      color = AppColors.darkGreen;
    }
    return Container(
      padding: AppSpacings.s10All,
      margin: AppSpacings.s10All,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.lightColor,
          width: 2,
        ),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            (color ?? AppColors.transparent).withOpacity(.35),
            color ?? AppColors.transparent
          ],
        ),
      ),
      child: Center(
        child: Text(
          gameType.tr,
          style: const TextStyle(
            color: AppColors.lightColor,
            fontSize: 25,
            fontFamily: FontFamilies.dastnevis,
          ),
        ),
      ),
    );
  }
}

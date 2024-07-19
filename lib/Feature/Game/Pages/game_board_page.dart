import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Feature/Game/Controllers/game_board_controller.dart';
import 'package:kafehfekr/Feature/Game/Widgets/countdown_timer.dart';
import 'package:flutter/material.dart';

class GameBoardPage extends BaseView<GameBoardController> {
  const GameBoardPage({super.key});

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: AppColors.cardLight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CountdownTimerWidget(),
                Center(child: Text(controller.logText.value)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // @override
  // Widget? floatingActionButton() {
  //   return Visibility(
  //     visible: controller.isButtonVisible.value,
  //     child: FloatingActionButton(
  //       onPressed: controller.onGeneralButtonFunction.value,
  //       child: Opacity(
  //         opacity: controller.buttonOpacity.value,
  //         child: Image.asset(
  //           controller.buttonIcon.value,
  //           color: AppColors.white,
  //           width: 30.r,
  //           height: 30.r,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

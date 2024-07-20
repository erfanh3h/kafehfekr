import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Feature/TicTacToe/Controllers/tictactoe_controller.dart';

class TicTacToePage extends BaseView<TicTacToeController> {
  const TicTacToePage({super.key});

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        // GridView.builder(
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 4,
        //     crossAxisSpacing: 25,
        //     mainAxisSpacing: 10,
        //   ),
        //   itemBuilder: (ctx, index) => InkWell(
        //     onTap: () {
        //       onEachTap(index + 1);
        //     },
        //     child: Image.asset(
        //       ReactionIcons().reactionIconsPath(index + 1),
        //       color: Colors.amber,
        //     ),
        //   ),
        //   itemCount: ReactionIcons.reactionsCount,
        // ),
        // Expanded(
        //   child: Container(
        //     color: AppColors.cardLight,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         const CountdownTimerWidget(),
        //         Center(child: Text(controller.logText.value)),
        //       ],
        //     ),
        //   ),
        // ),
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

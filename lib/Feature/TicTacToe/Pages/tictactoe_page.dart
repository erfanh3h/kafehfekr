import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/TicTacToe/Controllers/tictactoe_controller.dart';
import 'package:kafehfekr/Feature/TicTacToe/Widgets/tictactoe_button.dart';
import 'package:kafehfekr/Feature/TicTacToe/Widgets/tictactoe_player_data_widget.dart';
import 'package:refreshed/refreshed.dart';

class TicTacToePage extends BaseView<TicTacToeController> {
  const TicTacToePage({super.key});

  @override
  Widget body(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background1),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(flex: 1),
          SizedBox(
            height: 85.h,
            child: controller.players.length > 1
                ? TicTacToePlayerDataWidget(controller: controller)
                : Container(),
          ),
          Expanded(
            flex: 20,
            child: Center(
              child: Container(
                padding: AppSpacings.s20All,
                height: (Get.size.width)
                        .clamp(100, GeneralGameConsts.maxGameWidth) *
                    .95,
                width: (Get.size.width)
                        .clamp(100, GeneralGameConsts.maxGameWidth) *
                    .95,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (ctx, index) => Obx(
                    () => TicTacToeButton(
                      peaceData: controller.peaces[index].value,
                      onTap: controller.onEachButtonTap,
                    ),
                  ),
                  itemCount: controller.peaces.length,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GlobalActivityBox(
              surrenderFunction: FunctionsLibraryClass.surrenderFunction,
              reactionFunction: controller.showReactionBox,
              changeShowReactionFunction: controller.changeShowReactionStatus,
              showReaction: controller.showReactions.value,
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
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

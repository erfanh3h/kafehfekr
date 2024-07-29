import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/MSweeper/Controllers/msweeper_controller.dart';
import 'package:kafehfekr/Feature/MSweeper/Widgets/msweeper_button.dart';
import 'package:kafehfekr/Feature/MSweeper/Widgets/msweeper_player_data_widget.dart';
import 'package:refreshed/refreshed.dart';

class MSweeperPage extends BaseView<MSweeperController> {
  const MSweeperPage({super.key});

  @override
  Widget body(BuildContext context) {
    return Container(
      // constraints: const BoxConstraints(
      //   maxWidth: 500,
      // ),
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
                ? MSweeperPlayerDataWidget(controller: controller)
                : Container(),
          ),
          Expanded(
            flex: 20,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: GeneralGameConsts.maxGameWidth,
                ),
                padding: AppSpacings.s5All,
                height: (Get.size.width)
                        .clamp(100, GeneralGameConsts.maxGameWidth) *
                    .95,
                width: (Get.size.width)
                        .clamp(100, GeneralGameConsts.maxGameWidth) *
                    .95,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemBuilder: (ctx, index) => Obx(
                    () => MSweeperButton(
                      peaceData: controller.peaces[index].value,
                      onTap: controller.onEachButtonTap,
                      onHold: controller.onEachButtonHold,
                    ),
                  ),
                  itemCount: controller.peaces.length,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: GlobalActivityBox(
                surrenderFunction: controller.surrenderFnction,
                reactionFunction: controller.showReactionBox,
                changeShowReactionFunction: controller.changeShowReactionStatus,
                showReaction: controller.showReactions.value,
              ),
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

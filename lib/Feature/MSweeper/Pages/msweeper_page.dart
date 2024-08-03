import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Feature/MSweeper/Controllers/msweeper_controller.dart';
import 'package:kafehfekr/Feature/MSweeper/Widgets/msweeper_board_widget.dart';
import 'package:kafehfekr/Feature/MSweeper/Widgets/msweeper_player_data_widget.dart';

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
            child: MSweeperBoardWidget(controller: controller),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: GlobalActivityBox(
                surrenderFunction: FunctionsLibraryClass.surrenderFunction,
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
}


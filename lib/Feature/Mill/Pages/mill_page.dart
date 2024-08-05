import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Feature/Mill/Controllers/mill_controller.dart';
import 'package:kafehfekr/Feature/Mill/Widgets/mill_board_widget.dart';
import 'package:kafehfekr/Feature/Mill/Widgets/mill_not_played_peaces_box.dart';
import 'package:kafehfekr/Feature/Mill/Widgets/mill_player_data_widget.dart';
import 'package:kafehfekr/Feature/Mill/Widgets/mill_removed_peaces_box.dart';

class MillPage extends BaseView<MillController> {
  const MillPage({super.key});

  @override
  Widget body(BuildContext context) {
    return Container(
      width: double.maxFinite,
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
                ? MillPlayerDataWidget(controller: controller)
                : Container(),
          ),
          const Spacer(flex: 4),
          Center(
            child: MillBoardWidget(controller: controller),
          ),
          const Spacer(flex: 4),
          GlobalActivityBox(
            surrenderFunction: FunctionsLibraryClass.surrenderFunction,
            reactionFunction: controller.showReactionBox,
            changeShowReactionFunction: controller.changeShowReactionStatus,
            showReaction: controller.showReactions.value,
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}

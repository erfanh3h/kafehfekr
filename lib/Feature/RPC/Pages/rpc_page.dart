import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Feature/RPC/Controllers/rpc_controller.dart';
import 'package:kafehfekr/Feature/RPC/Widgets/rpc_main_widget.dart';
import 'package:kafehfekr/Feature/RPC/Widgets/rpc_player_data_widget.dart';

class RPCPage extends BaseView<RPCController> {
  const RPCPage({super.key});

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
                ? RPCPlayerDataWidget(controller: controller)
                : Container(),
          ),
          const Spacer(flex: 4),
          RPCMainWidget(controller: controller),
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

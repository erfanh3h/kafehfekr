import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/RPC/Controllers/rpc_controller.dart';
import 'package:kafehfekr/Feature/RPC/Widgets/rpc_button.dart';
import 'package:kafehfekr/Feature/RPC/Widgets/rpc_player_data_widget.dart';
import 'package:refreshed/refreshed.dart';

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
          Center(
            child: Container(
              padding: AppSpacings.s20All,
              width: Get.size.width * .95,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppTexts.selectOneOption.tr,
                    style: TextStyle(
                      color: AppColors.peaceBorderColor,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemBuilder: (ctx, index) => Obx(
                      () => RPCButton(
                        peaceData: controller.peaces[index].value,
                        onTap: controller.onEachButtonTap,
                      ),
                    ),
                    itemCount: controller.peaces.length,
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 40.h,
                    child: GlobalButtonWidget(
                      onTap: controller.acceptSelection,
                      text: AppTexts.accept.tr,
                      color: AppColors.peaceBorderColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          const Spacer(flex: 4),
          GlobalActivityBox(
            surrenderFunction: controller.surrenderFnction,
            reactionFunction: controller.showReactionBox,
            changeShowReactionFunction: controller.changeShowReactionStatus,
            showReaction: controller.showReactions.value,
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

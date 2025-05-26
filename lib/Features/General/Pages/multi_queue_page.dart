import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_input_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_page_header.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/General/Controllers/multi_queue_controller.dart';
import 'package:kafehfekr/Features/General/Widgets/GameMenu/queue_widgets/message_widget.dart';
import 'package:refreshed/refreshed.dart';

class MultiQueuePage extends BaseView<MultiQueueController> {
  const MultiQueuePage({super.key});

  @override
  bool setWillPopScope() {
    return false;
  }

  @override
  String? backgroundImage() {
    return AppImages.background2;
  }

  @override
  bool resizeToAvoidBottomInset() {
    return true;
  }

  @override
  Widget body(BuildContext context) {
    super.build(context);
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                GlobalFrameWrapper(
                  frame: AppImages.bilboard2,
                  height: 125,
                  width: Get.size.width / 2,
                  child: Padding(
                    padding: AppSpacings.s30Top,
                    child: Center(
                      child: Text(
                        AppTexts.multiPlayersGame.tr,
                        style: const TextStyle(
                          color: AppColors.lightColor,
                          fontSize: 50,
                          fontFamily: FontFamilies.hekayat,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: GlobalFrameWrapper(
                    padding: AppSpacings.s30All,
                    frame: AppImages.board,
                    child: ListView.separated(
                      itemBuilder: (ctx, index) =>
                          MessageWidget(data: controller.messages[index]),
                      separatorBuilder: (ctx, index) =>
                          const SizedBox(height: 20),
                      itemCount: controller.messages.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: AppSpacings.s2All,
            child: Row(
              children: [
                Expanded(
                  child: GlobalInputBox(
                    label: AppTexts.enterText.tr,
                    controller: controller.messageCtrl,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    fontFamily: FontFamilies.hekayat,
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: controller.sendMessage,
                  icon: const Icon(
                    Icons.send_rounded,
                    size: 40,
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 75,
                height: 75,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    MultiGameTypeConvertor.toGameImage(controller.gameType),
                  ),
                ),
              ),
              Expanded(child: GlobalPageHeader(label: AppTexts.findRivel.tr)),
            ],
          ),
        ],
      ),
    );
  }
}

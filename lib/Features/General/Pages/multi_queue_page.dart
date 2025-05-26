import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_fade_in_out_widget.dart.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_input_box.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
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
                Expanded(
                  child: Padding(
                    padding: AppSpacings.s10All,
                    child: ListView.separated(
                      itemBuilder: (ctx, index) =>
                          MessageWidget(data: controller.messages[index]),
                      separatorBuilder: (ctx, index) =>
                          const SizedBox(height: 20),
                      itemCount: controller.messages.length,
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset(MultiGameTypeConvertor.toGameImage(
                          controller.gameType)),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: GlobalFadeInOutWidget(
                        child: Text(
                          AppTexts.findRivel.tr,
                          style: const TextStyle(
                              color: AppColors.lightColor, fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    // const Spacer(),
                    GlobalButtonWidget(
                      onTap: Get.back,
                      text: AppTexts.back.tr,
                    ),
                    const SizedBox(height: 20),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: AppSpacings.s2All,
            child: Row(
              children: [
                Expanded(
                  child: GlobalInputBox(
                    label: AppTexts.enterText.tr,
                    controller: controller.messageCtrl,
                    textDirection: TextDirection.ltr,
                    maxLength: 30,
                    textAlign: TextAlign.right,
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
        ],
      ),
    );
  }
}

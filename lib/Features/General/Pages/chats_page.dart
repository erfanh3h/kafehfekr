import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_input_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_page_header.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/General/Controllers/chats_controller.dart';
import 'package:kafehfekr/Features/General/Widgets/GameMenu/queue_widgets/message_widget.dart';
import 'package:refreshed/refreshed.dart';

class ChatsPage extends BaseView<ChatsController> {
  const ChatsPage({super.key});

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
          GlobalPageHeader(
            label:
                '${AppTexts.chats.tr} (${controller.usersCount.value} آنلاین)',
          ),
          const SizedBox(height: 20),
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

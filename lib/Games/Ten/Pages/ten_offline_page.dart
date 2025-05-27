import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_offline_games_activity_buttons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/Ten/Controllers/ten_offline_controller.dart';
import 'package:kafehfekr/Games/Ten/Widgets/ten_offline_board_widget.dart';

class TenOfflinePage extends BaseView<TenOfflineController> {
  const TenOfflinePage({super.key});
  @override
  String? backgroundImage() {
    return AppImages.background1;
  }

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          Expanded(
            flex: 10,
            child: TenOfflineBoardWidget(controller: controller),
          ),
          Padding(
            padding: AppSpacings.s10Bottom,
            child: OfflineActivityButtons(controller: controller),
          ),
        ],
      ),
    );
  }
}

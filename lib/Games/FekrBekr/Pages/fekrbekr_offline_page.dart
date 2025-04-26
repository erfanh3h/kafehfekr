import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_offline_games_activity_buttons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/FekrBekr/Controllers/fekrbekr_offline_controller.dart';
import 'package:kafehfekr/Games/FekrBekr/Widgets/fekrbekr_offline_board_widget.dart';

class FekrBekrOfflinePage extends BaseView<FekrBekrOfflineController> {
  const FekrBekrOfflinePage({super.key});

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
        children: [
          Expanded(child: FekrBekrOfflineBoardWidget(controller: controller)),
          const SizedBox(height: 10),
          OfflineActivityButtons(controller: controller),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

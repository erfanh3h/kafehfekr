import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_offline_games_activity_buttons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/Mafia/Controllers/mafia_offline_controller.dart';

class MafiaOfflinePage extends BaseView<MafiaOfflineController> {
  const MafiaOfflinePage({super.key});
  @override
  String? backgroundImage() {
    return AppImages.background1;
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Expanded(flex: 2, child: OfflineActivityButtons(controller: controller))
      ],
    );
  }
}

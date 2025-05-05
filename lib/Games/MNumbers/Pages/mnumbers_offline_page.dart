import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_offline_games_activity_buttons.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/MNumbers/Controllers/mnumbers_offline_controller.dart';
import 'package:kafehfekr/Games/MNumbers/Widgets/mnumbers_offline_board_widget.dart';

class MNumbersOfflinePage extends BaseView<MNumbersOfflineController> {
  const MNumbersOfflinePage({super.key});

  @override
  String? backgroundImage() {
    return AppImages.background1;
  }

  @override
  Widget body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Text(
                'حرکت انجام شده :  ${controller.tappedTimes.value}',
                style: const TextStyle(
                    fontFamily: FontFamilies.hekayat,
                    fontSize: 30,
                    color: AppColors.lightColor),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: MNumbersOfflineBoardWidget(controller: controller),
          ),
          Expanded(child: OfflineActivityButtons(controller: controller))
        ],
      ),
    );
  }
}

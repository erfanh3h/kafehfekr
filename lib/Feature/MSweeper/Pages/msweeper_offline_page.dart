import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Feature/MSweeper/Controllers/msweeper_offline_controller.dart';
import 'package:kafehfekr/Feature/MSweeper/Widgets/msweeper_offline_board_widget.dart';

class MSweeperOfflinePage extends BaseView<MSweeperOfflineController> {
  const MSweeperOfflinePage({super.key});

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
          // Text(
          //   'انتخاب باقیمانده : ',
          //   style: TextStyle(
          //     fontFamily: FontFamilies.dastnevis,
          //     fontSize: 20,
          //     foreground: Paint()
          //       ..strokeWidth = 1.5
          //       ..color = AppColors.lightColor
          //       ..style = PaintingStyle.stroke,
          //   ),
          // ),
          const SizedBox(height: 30),
          MSweeperOfflineBoardWidget(controller: controller),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

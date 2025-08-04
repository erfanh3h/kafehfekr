import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/Mill/Controllers/mill_controller.dart';
import 'package:kafehfekr/Games/Mill/Widgets/mill_button.dart';
import 'package:refreshed/refreshed.dart';

class MillBoardWidget extends StatelessWidget {
  const MillBoardWidget({
    super.key,
    required this.controller,
  });

  final MillController controller;

  final Widget verticalDivider = const VerticalDivider(
    color: AppColors.lightColor,
    thickness: 3,
    width: 10,
  );

  final Widget horizentalDivider = const Divider(
    color: AppColors.lightColor,
    thickness: 3,
    height: 10,
  );
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GlobalFrameWrapper(
        frame: AppImages.board,
        padding: AppSpacings.s20All,
        height: 330,
        width: 330,
        child: Stack(
          children: [
            Positioned(
              top: 40,
              left: 13,
              child: SizedBox(
                height: 90,
                child: verticalDivider,
              ),
            ),
            Positioned(
              bottom: 40,
              left: 13,
              child: SizedBox(
                height: 90,
                child: verticalDivider,
              ),
            ),
            Positioned(
              top: 40,
              right: 13,
              child: SizedBox(
                height: 90,
                child: verticalDivider,
              ),
            ),
            Positioned(
              bottom: 40,
              right: 13,
              child: SizedBox(
                height: 90,
                child: verticalDivider,
              ),
            ),
            Positioned(
              top: 80,
              left: 57,
              child: SizedBox(
                height: 50,
                child: verticalDivider,
              ),
            ),
            Positioned(
              bottom: 80,
              left: 57,
              child: SizedBox(
                height: 50,
                child: verticalDivider,
              ),
            ),
            Positioned(
              top: 80,
              right: 57,
              child: SizedBox(
                height: 50,
                child: verticalDivider,
              ),
            ),
            Positioned(
              bottom: 80,
              right: 57,
              child: SizedBox(
                height: 50,
                child: verticalDivider,
              ),
            ),
            Positioned(
              top: 40,
              left: 140,
              child: SizedBox(
                height: 8,
                child: verticalDivider,
              ),
            ),
            Positioned(
              top: 80,
              left: 140,
              child: SizedBox(
                height: 8,
                child: verticalDivider,
              ),
            ),
            Positioned(
              bottom: 40,
              left: 140,
              child: SizedBox(
                height: 8,
                child: verticalDivider,
              ),
            ),
            Positioned(
              bottom: 80,
              left: 140,
              child: SizedBox(
                height: 8,
                child: verticalDivider,
              ),
            ),
            Positioned(
              top: 120,
              left: 98,
              child: SizedBox(
                height: 8,
                child: verticalDivider,
              ),
            ),
            Positioned(
              top: 162,
              left: 98,
              child: SizedBox(
                height: 8,
                child: verticalDivider,
              ),
            ),
            Positioned(
              top: 120,
              right: 98,
              child: SizedBox(
                height: 8,
                child: verticalDivider,
              ),
            ),
            Positioned(
              top: 162,
              right: 98,
              child: SizedBox(
                height: 8,
                child: verticalDivider,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MillButton(
                      peaceData: controller.peaces[0].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    Expanded(child: horizentalDivider),
                    MillButton(
                      peaceData: controller.peaces[1].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    Expanded(child: horizentalDivider),
                    MillButton(
                      peaceData: controller.peaces[2].value,
                      onTap: controller.onEachButtonTap,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    MillButton(
                      peaceData: controller.peaces[3].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    Expanded(child: horizentalDivider),
                    MillButton(
                      peaceData: controller.peaces[4].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    Expanded(child: horizentalDivider),
                    MillButton(
                      peaceData: controller.peaces[5].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    const Spacer(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MillButton(
                      peaceData: controller.peaces[6].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    SizedBox(
                      width: 5,
                      child: horizentalDivider,
                    ),
                    MillButton(
                      peaceData: controller.peaces[7].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    SizedBox(
                      width: 5,
                      child: horizentalDivider,
                    ),
                    MillButton(
                      peaceData: controller.peaces[8].value,
                      onTap: controller.onEachButtonTap,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MillButton(
                      peaceData: controller.peaces[9].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    Expanded(flex: 2, child: horizentalDivider),
                    MillButton(
                      peaceData: controller.peaces[10].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    Expanded(flex: 2, child: horizentalDivider),
                    MillButton(
                      peaceData: controller.peaces[11].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    const SizedBox(width: 50),
                    MillButton(
                      peaceData: controller.peaces[12].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    Expanded(flex: 2, child: horizentalDivider),
                    MillButton(
                      peaceData: controller.peaces[13].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    Expanded(flex: 2, child: horizentalDivider),
                    MillButton(
                      peaceData: controller.peaces[14].value,
                      onTap: controller.onEachButtonTap,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MillButton(
                      peaceData: controller.peaces[15].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    SizedBox(width: 5, child: horizentalDivider),
                    MillButton(
                      peaceData: controller.peaces[16].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    SizedBox(width: 5, child: horizentalDivider),
                    MillButton(
                      peaceData: controller.peaces[17].value,
                      onTap: controller.onEachButtonTap,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    MillButton(
                      peaceData: controller.peaces[18].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    Expanded(child: horizentalDivider),
                    MillButton(
                      peaceData: controller.peaces[19].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    Expanded(child: horizentalDivider),
                    MillButton(
                      peaceData: controller.peaces[20].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    const Spacer(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MillButton(
                      peaceData: controller.peaces[21].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    Expanded(child: horizentalDivider),
                    MillButton(
                      peaceData: controller.peaces[22].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    Expanded(child: horizentalDivider),
                    MillButton(
                      peaceData: controller.peaces[23].value,
                      onTap: controller.onEachButtonTap,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

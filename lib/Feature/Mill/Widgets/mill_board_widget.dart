import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/Mill/Controllers/mill_controller.dart';
import 'package:kafehfekr/Feature/Mill/Widgets/mill_button.dart';
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
    return Container(
      padding: AppSpacings.s5All,
      height: Get.size.width * .95,
      width: Get.size.width * .95,
      child: Stack(
        children: [
          Positioned(
            top: 45.w,
            left: 13.w,
            child: SizedBox(
              height: 110.w,
              child: verticalDivider,
            ),
          ),
          Positioned(
            top: 180.w,
            left: 13.w,
            child: SizedBox(
              height: 110.w,
              child: verticalDivider,
            ),
          ),
          Positioned(
            top: 45.w,
            right: 13.w,
            child: SizedBox(
              height: 110.w,
              child: verticalDivider,
            ),
          ),
          Positioned(
            top: 180.w,
            right: 13.w,
            child: SizedBox(
              height: 110.w,
              child: verticalDivider,
            ),
          ),
          Positioned(
            top: 90.w,
            left: 70.w,
            child: SizedBox(
              height: 60.w,
              child: verticalDivider,
            ),
          ),
          Positioned(
            top: 180.w,
            left: 70.w,
            child: SizedBox(
              height: 65.w,
              child: verticalDivider,
            ),
          ),
          Positioned(
            top: 90.w,
            right: 70.w,
            child: SizedBox(
              height: 60.w,
              child: verticalDivider,
            ),
          ),
          Positioned(
            top: 180.w,
            right: 70.w,
            child: SizedBox(
              height: 65.w,
              child: verticalDivider,
            ),
          ),
          Positioned(
            top: 138.w,
            right: 120.w,
            child: SizedBox(
              height: 15.w,
              child: verticalDivider,
            ),
          ),
          Positioned(
            top: 181.w,
            right: 120.w,
            child: SizedBox(
              height: 15.w,
              child: verticalDivider,
            ),
          ),
          Positioned(
            top: 138.w,
            left: 120.w,
            child: SizedBox(
              height: 15.w,
              child: verticalDivider,
            ),
          ),
          Positioned(
            top: 181.w,
            left: 120.w,
            child: SizedBox(
              height: 15.w,
              child: verticalDivider,
            ),
          ),
          Positioned(
            top: 45.w,
            left: 162.w,
            child: SizedBox(
              height: 15.w,
              child: verticalDivider,
            ),
          ),
          Positioned(
            top: 90.w,
            left: 162.w,
            child: SizedBox(
              height: 15.w,
              child: verticalDivider,
            ),
          ),
          Positioned(
            bottom: 45.w,
            left: 162.w,
            child: SizedBox(
              height: 15.w,
              child: verticalDivider,
            ),
          ),
          Positioned(
            bottom: 90.w,
            left: 162.w,
            child: SizedBox(
              height: 15.w,
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
                    width: 5.w,
                    child: horizentalDivider,
                  ),
                  MillButton(
                    peaceData: controller.peaces[7].value,
                    onTap: controller.onEachButtonTap,
                  ),
                  SizedBox(
                    width: 5.w,
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
                  const Spacer(flex: 5),
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
                  SizedBox(width: 5.w, child: horizentalDivider),
                  MillButton(
                    peaceData: controller.peaces[16].value,
                    onTap: controller.onEachButtonTap,
                  ),
                  SizedBox(width: 5.w, child: horizentalDivider),
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
  }
}

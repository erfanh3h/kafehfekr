import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class RiskCardWidget extends StatelessWidget {
  const RiskCardWidget({
    super.key,
    required this.iconData,
    required this.text,
    this.count,
  });

  final String iconData;
  final String text;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return GlobalFrameWrapper(
      padding: AppSpacings.s5All,
      frame: AppImages.dialog2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(iconData),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(150),
              ),
              child: Center(
                child: Text(
                  count != null ? count.toString() : " ",
                  style: const TextStyle(
                    fontSize: 60,
                    fontFamily: FontFamilies.playPen,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(color: AppColors.lightColor, fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

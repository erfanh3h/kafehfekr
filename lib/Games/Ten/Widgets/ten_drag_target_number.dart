import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class TenDragTargetNumberWidget extends StatelessWidget {
  const TenDragTargetNumberWidget({
    super.key,
    required this.value,
    required this.index,
    required this.onAccept,
    required this.onRemove,
  });
  final int value;
  final int index;
  final Function(int, int) onAccept;
  final Function(int) onRemove;
  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      onAcceptWithDetails: (details) => onAccept(details.data, index),
      builder: (context, candidateData, rejectedData) {
        return InkWell(
          onTap: () => onRemove(index),
          child: GlobalFrameWrapper(
            padding: AppSpacings.s15Vertical5Horizental,
            frame: AppImages.button4,
            child: Center(
              child: Text(
                value >= 0 ? value.toString() : "",
                style: const TextStyle(
                  fontSize: 17,
                  color: AppColors.lightColor,
                  fontFamily: FontFamilies.playPen,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

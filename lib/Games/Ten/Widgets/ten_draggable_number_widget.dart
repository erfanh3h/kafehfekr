import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class TenDraggableNumberWidget extends StatelessWidget {
  const TenDraggableNumberWidget({
    super.key,
    required this.value,
  });

  final int value;

  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      data: value,
      feedback: GlobalFrameWrapper(
        padding: AppSpacings.s10Vertical20Horizental,
        height: 50,
        frame: AppImages.button4,
        child: Center(
          child: Text(
            value.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: FontFamilies.playPen,
              decoration: TextDecoration.none,
            ),
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
      childWhenDragging: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white.withValues(alpha: 0.4),
        ),
        width: 50,
        height: 50,
      ),
      onDraggableCanceled: (_, _) {},
      child: GlobalFrameWrapper(
        padding: AppSpacings.s10Vertical20Horizental,
        height: 50,
        frame: AppImages.button4,
        child: Center(
          child: Text(
            value.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: FontFamilies.playPen,
            ),
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class BattleShipDragTargetWidget extends StatelessWidget {
  const BattleShipDragTargetWidget({
    super.key,
    required this.shipId,
    required this.index,
    required this.onAccept,
  });
  final int shipId;
  final int index;
  final Function(int) onAccept;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      margin: AppSpacings.s1All,
      child: InkWell(
        onTap: () => onAccept(index),
        child: GlobalFrameWrapper(
          frame: AppImages.button4,
          padding: AppSpacings.s2All,
          child: Container(
            // padding: AppSpacings.s15Vertical5Horizental,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              // color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
        ),
      ),
    );
  }
}

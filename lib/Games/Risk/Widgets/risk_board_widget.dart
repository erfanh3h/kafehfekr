import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/Risk/Controllers/risk_controller.dart';

class RiskBoardWidget extends StatelessWidget {
  const RiskBoardWidget({
    super.key,
    required this.controller,
  });

  final RiskController controller;

  @override
  Widget build(BuildContext context) {
    return GlobalFrameWrapper(
      frame: AppImages.board,
      child: SizedBox(
        width: 350,
        height: 350,
        child: Container(),
      ),
    );
  }
}

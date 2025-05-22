import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class GlobalFrameWrapper extends StatelessWidget {
  const GlobalFrameWrapper(
      {super.key, required this.child, this.height, this.frame});

  final Widget child;
  final double? height;
  final String? frame;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: AppSpacings.s20All,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(frame ?? AppImages.frame4),
          fit: BoxFit.fill,
        ),
      ),
      child: child,
    );
  }
}

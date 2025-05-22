import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class GlobalDialogWrapper extends StatelessWidget {
  const GlobalDialogWrapper({super.key, required this.child, this.height});

  final Widget child;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: AppSpacings.s10All,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.dialog),
          fit: BoxFit.fill,
        ),
      ),
      child: child,
    );
  }
}

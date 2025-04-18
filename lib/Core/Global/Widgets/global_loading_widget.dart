import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_fade_in_out_widget.dart.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';

class GlobalLoadingWidget extends StatelessWidget {
  const GlobalLoadingWidget({
    this.color,
    this.size,
    super.key,
  });
  final int? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: (size ?? 100).r, maxHeight: (size ?? 100).r),
        child: GlobalFadeInOutWidget(
          animationTime: 500,
          child: Image.asset(
            GeneralIcons.logoTransparent,
            // width: (size ?? 35).r,
            // height: (size ?? 35).r,
            color: color ?? Colors.black,
          ),
        ),
      ),
    );
  }
}

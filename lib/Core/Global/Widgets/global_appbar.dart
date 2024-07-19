import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:refreshed/refreshed.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';

class GlobalAppbar extends StatelessWidget {
  final String title;
  final bool letBack;
  final int? fontsize;
  final Widget? flexibleSpace;
  final VoidCallback? backFunction;
  final TextStyle? textStyle;
  const GlobalAppbar({
    super.key,
    required this.title,
    this.letBack = true,
    this.fontsize,
    this.flexibleSpace,
    this.backFunction,
    this.textStyle,
  });

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      // systemOverlayStyle: const SystemUiOverlayStyle(
      //   // Status bar color
      //   statusBarColor: Colors.transparent,
      //   // Status bar brightness (optional)
      //   statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      //   statusBarBrightness: Brightness.light, // For iOS (dark icons)
      // ),
      leading: letBack
          ? InkWell(
              onTap: backFunction ?? Get.back,
              child: Icon(
                CupertinoIcons.chevron_forward,
                size: 22.r,
                color: Colors.white,
              ),
            )
          : Container(),
      flexibleSpace: flexibleSpace,
      centerTitle: true,
      title: flexibleSpace == null
          ? Text(
              title,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: textStyle ?? context.textTheme.titleMedium,
            )
          : null,
    );
  }
}

class UserAppbarIcon extends StatelessWidget {
  const UserAppbarIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var globalController = Get.find<GlobalController>();
    return Obx(
      () => globalController.isLoadingProfile.value
          ? Padding(
              padding: AppSpacings.s10r,
              child: const GlobalLoadingWidget(color: Colors.white, size: 17),
            )
          : const InkWell(
              child: Padding(
                padding: AppSpacings.s10All,
                child: Icon(
                  CupertinoIcons.person_alt,
                  size: 23,
                ),
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:refreshed/refreshed.dart';

import '../../Routes/app_routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final globalController = Get.find<GlobalController>();
    Future.delayed(const Duration(seconds: 1)).then((_) {
      Get.offAllNamed(AppRoutes.main);
    });
    // globalController.fetchUserData().then(
    //   (value) {
    //     if (value) {
    //       Get.offAllNamed(AppRoutes.main);
    //     } else {
    //       Get.offAllNamed(AppRoutes.profile);
    //     }
    //   },
    // );

    return const Scaffold(body: GlobalLoadingWidget());
  }
}

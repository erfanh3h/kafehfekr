import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:refreshed/refreshed.dart';

class GlobalBottomNavigationBar extends StatelessWidget {
  const GlobalBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalController controller = Get.find<GlobalController>();
    return Obx(() => Text(controller.selectedPage.value.toString()));
  }
}

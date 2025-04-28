import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Features/General/Controllers/queue_controller.dart';
import 'package:kafehfekr/Features/General/Widgets/GameMenu/queue_finding_part.dart';
import 'package:kafehfekr/Features/General/Widgets/GameMenu/queue_game_selection_part.dart';

class QueuePage extends BaseView<QueueController> {
  const QueuePage({super.key});

  @override
  bool setWillPopScope() {
    return false;
  }

  @override
  Widget body(BuildContext context) {
    super.build(context);
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background3),
          fit: BoxFit.fill,
        ),
      ),
      child: controller.isPreGameMode.value
          ? QueueGameSelectionPart(controller: controller)
          : const QueueFindingPart(),
    );
  }
}

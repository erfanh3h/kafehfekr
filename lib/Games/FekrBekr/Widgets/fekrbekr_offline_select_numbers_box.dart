import 'package:flutter/material.dart';
import 'package:kafehfekr/Games/FekrBekr/Controllers/fekrbekr_controller.dart';
import 'package:kafehfekr/Games/FekrBekr/Controllers/fekrbekr_offline_controller.dart';
import 'package:kafehfekr/Games/FekrBekr/Widgets/fekrbekr_select_number_button.dart';
import 'package:refreshed/refreshed.dart';

class FekrBekrOfflineSelectNumbersBox extends StatelessWidget {
  const FekrBekrOfflineSelectNumbersBox({
    super.key,
    required this.controller,
  });

  final FekrBekrOfflineController controller;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) => GetBuilder<FekrBekrController>(
          builder: (context) => Obx(
            () => FekrBekrSelectNumberButton(
              number: i + 1,
              onTap: controller.changeSelectedNumber,
              isTapped: controller.selectedNumber.value == i + 1,
            ),
          ),
        ),
        itemCount: 8,
      ),
    );
  }
}

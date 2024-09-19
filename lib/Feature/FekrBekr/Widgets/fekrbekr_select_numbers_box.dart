import 'package:flutter/material.dart';
import 'package:kafehfekr/Feature/FekrBekr/Controllers/fekrbekr_controller.dart';
import 'package:kafehfekr/Feature/FekrBekr/Widgets/fekrbekr_select_number_button.dart';
import 'package:refreshed/refreshed.dart';

class FekrBekrSelectNumbersBox extends StatelessWidget {
  const FekrBekrSelectNumbersBox({
    super.key,
    required this.controller,
  });

  final FekrBekrController controller;
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

import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:refreshed/refreshed.dart';

class GlobalBottomNavigationBar extends StatelessWidget {
  const GlobalBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalController controller = Get.find<GlobalController>();
    return Obx(
      () => Container(
        margin: AppSpacings.s10All,
        height: controller.isQueueActive.value ? 150 : 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.darkColor,
        ),
        child: Row(
          children: [
            for (int index = 0; index < 5; index++)
              Expanded(
                child: EachButton(
                  text: bottomNavigationTexts[index].tr,
                  icon: bottomNavigationIcons[index],
                  onTap: controller.changePage,
                  isSelected: controller.selectedPage.value == index,
                  index: index,
                ),
              )
          ],
        ),
      ),
    );
  }
}

class EachButton extends StatelessWidget {
  const EachButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    required this.isSelected,
    required this.index,
  });

  final String text;
  final String icon;
  final Function(int) onTap;
  final bool isSelected;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(index),
      onLongPress: () => DialogComponent().showToast(label: text),
      child: Container(
        padding: isSelected ? AppSpacings.s10All : AppSpacings.s20All,
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color.fromARGB(1, 212, 133, 126),
                    Color.fromARGB(255, 214, 172, 168),
                  ],
                )
              : null,
          borderRadius: BorderRadius.circular(20),
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.amber : Colors.white70,
              width: isSelected ? 4 : 2,
            ),
          ),
        ),
        child: Image.asset(
          icon,
          color: isSelected ? Colors.amber : Colors.white,
          // width: isSelected ? 35 : 25,
          // height: isSelected ? 35 : 25,
        ),
      ),
    );
  }
}

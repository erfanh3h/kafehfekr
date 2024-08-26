import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:refreshed/refreshed.dart';

class GlobalBottomNavigationBar extends StatelessWidget {
  const GlobalBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalController controller = Get.find<GlobalController>();
    return Obx(
      () => Container(
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
      child: Container(
        decoration: BoxDecoration(
          // color: isSelected ? Colors.amber : Colors.black,
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
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                icon,
                color: Colors.white,
                width: isSelected ? 35 : 25,
                height: isSelected ? 35 : 25,
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontFamilies.dastnevis,
                  fontSize: isSelected ? 15 : 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

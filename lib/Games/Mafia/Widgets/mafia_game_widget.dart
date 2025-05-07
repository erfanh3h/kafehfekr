import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/Mafia/Controllers/mafia_offline_controller.dart';
import 'package:refreshed/refreshed.dart';

class MafiaGameWidget extends StatelessWidget {
  const MafiaGameWidget({
    super.key,
    required this.controller,
  });

  final MafiaOfflineController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemBuilder: (ctx, index) => Obx(
          () => Card(
            color: controller.users[index].isDead.value
                ? null
                : AppColors.lightColor3,
            child: Padding(
              padding: AppSpacings.s10Horizental5Vertical,
              child: Row(
                children: [
                  Text(
                    controller.users[index].name.value,
                    style: const TextStyle(
                      color: AppColors.lightColor,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Obx(
                    () => controller.users[index].showRole.value
                        ? Text(
                            controller.users[index].role.value,
                            style: const TextStyle(
                              color: AppColors.lightColor,
                              fontSize: 17,
                            ),
                          )
                        : Container(),
                  ),
                  Obx(
                    () => IconButton(
                      onPressed: controller.users[index].changeShowRole,
                      icon: Icon(
                        controller.users[index].showRole.value
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye_fill,
                        color: AppColors.lightColor,
                      ),
                    ),
                  ),
                  Obx(
                    () => IconButton(
                      onPressed: controller.users[index].changeIsDead,
                      icon: Icon(
                        controller.users[index].isDead.value
                            ? CupertinoIcons.add
                            : Icons.close,
                        color: AppColors.lightColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        itemCount: controller.users.length,
      ),
    );
  }
}

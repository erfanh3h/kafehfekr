import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
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
          () => Opacity(
            opacity: controller.users[index].isDead.value ? .5 : 1,
            child: GlobalFrameWrapper(
              padding: AppSpacings.s15All,
              child: Row(
                children: [
                  const SizedBox(width: 5),
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
                        ? Expanded(
                            flex: 1,
                            child: GlobalFrameWrapper(
                              padding: AppSpacings.s5All,
                              child: Center(
                                child: Text(
                                  '${controller.getUserSideLabel(index)} - ${controller.users[index].role.value}',
                                  style: const TextStyle(
                                    color: AppColors.lightColor,
                                    fontSize: 17,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
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
                    () => InkWell(
                      onTap: controller.users[index].changeIsDead,
                      child: GlobalFrameWrapper(
                        padding: AppSpacings.s2All,
                        frame: controller.users[index].isDead.value
                            ? AppImages.add
                            : AppImages.close,
                        child: const SizedBox(
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
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

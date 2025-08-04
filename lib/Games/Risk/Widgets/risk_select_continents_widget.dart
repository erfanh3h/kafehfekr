import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/player_model.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Risk/Models/enums.dart';
import 'package:refreshed/refreshed.dart';

import '../Controllers/risk_controller.dart';

class RiskSelectContinentsWidget extends StatefulWidget {
  const RiskSelectContinentsWidget({
    super.key,
  });

  @override
  State<RiskSelectContinentsWidget> createState() =>
      _RiskSelectContinentsWidgetState();
}

class _RiskSelectContinentsWidgetState
    extends State<RiskSelectContinentsWidget> {
  final RiskController controller = Get.find<RiskController>();
  int state = 0;

  ContinentTypes? sourceContinent;
  ContinentTypes? targetContinent;
  int? targetIndex;

  selectSourceContinent(ContinentTypes continent) {
    if (sourceContinent != null && sourceContinent!.name == continent.name) {
      setState(() {
        sourceContinent = null;
      });
    } else {
      setState(() {
        sourceContinent = continent;
      });
    }
  }

  selectTargetContinent(ContinentTypes continent) {
    if (targetContinent != null && targetContinent!.name == continent.name) {
      setState(() {
        targetContinent = null;
      });
    } else {
      setState(() {
        targetContinent = continent;
      });
    }
  }

  selectTargetIndex(int index) {
    if (targetIndex != null && targetIndex == index) {
      setState(() {
        targetIndex = null;
      });
    } else {
      setState(() {
        targetIndex = index;
      });
    }
  }

  back() {
    if (state == 0) {
      return;
    }
    setState(() {
      state--;
    });
  }

  submit() {
    if (state == 0) {
      controller.attackHandler.submitSourceContinent(sourceContinent!);
      setState(() {
        state++;
      });
    } else if (state == 1) {
      controller.attackHandler.submitTargetUserIndex(targetIndex!);
      setState(() {
        state++;
      });
    } else if (state == 2) {
      controller.attackHandler.submitTargetContinent(targetContinent!);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        state == 0
            ? Column(
                children: [
                  GlobalFrameWrapper(
                    frame: AppImages.dialog3,
                    child: Text(
                      AppTexts.selectSourceContinent.tr,
                      style: const TextStyle(
                        color: AppColors.lightColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3 / 4,
                      ),
                      itemBuilder: (ctx, index) {
                        final continent = controller
                            .myData.value!.continents.keys
                            .toList()[index];
                        final iconData = continentToImage(continent);
                        final text = continent.name.tr;
                        final count =
                            controller.myData.value!.continents[continent];
                        final isContinentSelected =
                            sourceContinent?.name == continent.name;
                        return InkWell(
                          onTap: () {
                            //prevnet select empty
                            if (count != 0) {
                              selectSourceContinent(continent);
                            }
                          },
                          child: Container(
                            padding: isContinentSelected
                                ? AppSpacings.s5All
                                : EdgeInsets.zero,
                            decoration: BoxDecoration(
                                border: isContinentSelected
                                    ? Border.all(
                                        color: AppColors.lightColor, width: 3)
                                    : null,
                                borderRadius: BorderRadius.circular(8)),
                            child: GlobalFrameWrapper(
                              padding: AppSpacings.s5All,
                              // height: 120,
                              // width: 150,
                              frame: AppImages.dialog2,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(iconData),
                                          fit: BoxFit.fill,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(150),
                                      ),
                                      child: Center(
                                        child: Text(
                                          count.toString(),
                                          style: const TextStyle(
                                            color: AppColors.darkColor,
                                            fontSize: 60,
                                            fontFamily: FontFamilies.playPen,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    text,
                                    style: const TextStyle(
                                        color: AppColors.lightColor,
                                        fontSize: 12),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount:
                          controller.myData.value!.continents.keys.length,
                    ),
                  ),
                ],
              )
            : state == 1
                ? Column(
                    children: [
                      GlobalFrameWrapper(
                        frame: AppImages.dialog3,
                        child: Text(
                          AppTexts.selectTargetUser.tr,
                          style: const TextStyle(
                            color: AppColors.lightColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Center(
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 4,
                            childAspectRatio: 7 / 8,
                          ),
                          itemBuilder: (ctx, index) {
                            final item = controller.players[index];
                            final isUserSelected = (targetIndex ?? -1) == index;
                            return InkWell(
                              onTap: () {
                                //prevent select himeself
                                if (controller.myData.value!.index !=
                                    index + 1) {
                                  selectTargetIndex(index);
                                }
                              },
                              child: Container(
                                padding: isUserSelected
                                    ? AppSpacings.s5All
                                    : EdgeInsets.zero,
                                decoration: BoxDecoration(
                                    border: isUserSelected
                                        ? Border.all(
                                            color: AppColors.lightColor,
                                            width: 3)
                                        : null,
                                    borderRadius: BorderRadius.circular(8)),
                                child: GlobalFrameWrapper(
                                  padding: AppSpacings.s5All,
                                  // height: 120,
                                  // width: 150,
                                  frame: AppImages.dialog2,
                                  child: UserWidget(data: item.value),
                                ),
                              ),
                            );
                          },
                          itemCount: controller.players.value.length,
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      GlobalFrameWrapper(
                        frame: AppImages.dialog3,
                        child: Text(
                          AppTexts.selectTargetContinent.tr,
                          style: const TextStyle(
                            color: AppColors.lightColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Center(
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 4,
                          ),
                          itemBuilder: (ctx, index) {
                            final continent = controller
                                .riskUsersData[targetIndex!]
                                .value
                                .continents
                                .keys
                                .toList()[index];
                            final iconData = continentToImage(continent);
                            final text = continent.name.tr;
                            final count = controller.riskUsersData[targetIndex!]
                                .value.continents[continent];
                            final isContinentSelected =
                                targetContinent?.name == continent.name;
                            return InkWell(
                              onTap: () {
                                if (count != 0) {
                                  selectTargetContinent(continent);
                                }
                              },
                              child: Container(
                                padding: isContinentSelected
                                    ? AppSpacings.s5All
                                    : EdgeInsets.zero,
                                decoration: BoxDecoration(
                                    border: isContinentSelected
                                        ? Border.all(
                                            color: AppColors.lightColor,
                                            width: 3)
                                        : null,
                                    borderRadius: BorderRadius.circular(8)),
                                child: GlobalFrameWrapper(
                                  padding: AppSpacings.s5All,
                                  // height: 120,
                                  // width: 150,
                                  frame: AppImages.dialog2,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(iconData),
                                              fit: BoxFit.fill,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(150),
                                          ),
                                          child: Center(
                                            child: Text(
                                              count.toString(),
                                              style: const TextStyle(
                                                color: AppColors.darkColor,
                                                fontSize: 60,
                                                fontFamily:
                                                    FontFamilies.playPen,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        text,
                                        style: const TextStyle(
                                            color: AppColors.lightColor,
                                            fontSize: 12),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: controller.riskUsersData[targetIndex!]
                              .value.continents.keys.length,
                        ),
                      ),
                    ],
                  ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: GlobalButtonWidget(
                onTap: back,
                text: AppTexts.back.tr,
                height: 60,
              ),
            ),
            Expanded(
              child: GlobalButtonWidget(
                onTap: submit,
                text: AppTexts.accept.tr,
                height: 60,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class UserWidget extends StatelessWidget {
  const UserWidget({super.key, required this.data});
  final PlayerModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 150,
      constraints: const BoxConstraints(maxWidth: 65),
      padding: AppSpacings.s5All,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              AvatarIcons().generalAvatarPath(
                data.userImage,
              ),
              width: 60,
              height: 60,
            ),
          ),
          const SizedBox(height: 3),
          SizedBox(
            width: 65,
            child: Text(
              data.name,
              style: const TextStyle(
                fontFamily: FontFamilies.playPen,
                fontSize: 12,
                color: AppColors.lightColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

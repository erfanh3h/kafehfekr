import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_guide_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacings.s10All,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            AppTexts.library.tr,
            style: const TextStyle(
              fontSize: 25,
              color: AppColors.lightColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppTexts.gameType.tr,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.lightColor,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: GlobalButtonWidget(
                  onTap: () {
                    Get.bottomSheet(
                      ListView(
                        children: [
                          Padding(
                            padding: AppSpacings.s20All,
                            child: Text(
                              AppTexts.normalGuide.tr,
                              style: const TextStyle(
                                color: AppColors.lightColor,
                                fontSize: 20,
                                height: 1.75,
                              ),
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: AppColors.darkColor,
                    );
                  },
                  text: AppTexts.normalGame.tr,
                  color: Colors.transparent.withOpacity(.5),
                  fontColor: AppColors.lightColor,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: GlobalButtonWidget(
                  onTap: () {
                    Get.bottomSheet(
                      ListView(
                        children: [
                          Padding(
                            padding: AppSpacings.s20All,
                            child: Text(
                              AppTexts.rankGuide.tr,
                              style: const TextStyle(
                                color: AppColors.lightColor,
                                fontSize: 20,
                                height: 1.75,
                              ),
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: AppColors.darkColor,
                    );
                  },
                  text: AppTexts.rankGame.tr,
                  color: Colors.transparent.withOpacity(.5),
                  fontColor: AppColors.lightColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            AppTexts.games.tr,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.lightColor,
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 2,
              ),
              itemBuilder: (ctx, index) => GlobalButtonWidget(
                onTap: () {
                  Get.bottomSheet(
                    GlobalGameGuideWidget(gameType: GameTypes.values[index]),
                    backgroundColor: AppColors.darkColor,
                  );
                },
                text: GameTypes.values[index].name.tr,
                color: Colors.transparent.withOpacity(.5),
                fontColor: AppColors.lightColor,
              ),
              itemCount: GameTypes.values.length,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

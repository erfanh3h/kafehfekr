import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/Auth/Models/user_model.dart';
import 'package:kafehfekr/Feature/General/Models/user_history_model.dart';
import 'package:kafehfekr/Feature/General/Widgets/game_history_row_widget.dart';
import 'package:refreshed/refreshed.dart';

class UserDataWidget extends StatelessWidget {
  const UserDataWidget({
    super.key,
    required this.userData,
    required this.userHistoryData,
  });

  final UserModel userData;
  final UserHistoryModel userHistoryData;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: AppSpacings.s20Horizental,
          child: FadeIn(
            delay: const Duration(milliseconds: 150),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          userData.score.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: AppColors.lightColor,
                            fontFamily: FontFamilies.dastnevis,
                            letterSpacing: 2.5,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Image.asset(GeneralIcons.cup, width: 30, height: 30),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          FunctionsLibraryClass.expToLevel(userData.xp)
                              .toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: AppColors.lightColor,
                            fontFamily: FontFamilies.dastnevis,
                            letterSpacing: 2.5,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Image.asset(GeneralIcons.exp, width: 30, height: 30),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        userData.name,
                        style: const TextStyle(
                          fontSize: 20,
                          color: AppColors.lightColor,
                          fontFamily: FontFamilies.playPen,
                          letterSpacing: 2.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        userData.id,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: FontFamilies.playPen,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 65.w,
                  height: 65.w,
                  padding: AppSpacings.s5All,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: Image.asset(
                      AvatarIcons().generalAvatarPath(userData.image),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        FadeIn(
          delay: const Duration(milliseconds: 300),
          child: Column(
            children: [
              GameHistoryRowWidget(
                data: (
                  userHistoryData.winNormal,
                  userHistoryData.drawNormal,
                  userHistoryData.loseNormal,
                ),
                name: AppTexts.normalGame.tr,
              ),
              GameHistoryRowWidget(
                data: (
                  userHistoryData.winRank,
                  userHistoryData.drawRank,
                  userHistoryData.loseRank,
                ),
                name: AppTexts.rankGame.tr,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

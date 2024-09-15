import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/General/Models/ranking_model.dart';

class RankingRowBox extends StatelessWidget {
  const RankingRowBox({
    super.key,
    required this.data,
    required this.index,
  });

  final RankingModel data;
  final int index;
  @override
  Widget build(BuildContext context) {
    Widget indexWidget = SizedBox(
      width: 35,
      height: 35,
      child: Center(
        child: Text(
          index.toString(),
          style: const TextStyle(
            fontFamily: FontFamilies.typo,
            fontSize: 30,
            color: AppColors.lightColor,
          ),
        ),
      ),
    );
    if (index == 1) {
      indexWidget = Image.asset(
        GeneralIcons.first,
        width: 35,
        height: 35,
        color: AppColors.goldenColor,
      );
    } else if (index == 2) {
      indexWidget = Image.asset(
        GeneralIcons.second,
        width: 35,
        height: 35,
        color: const Color.fromARGB(255, 156, 174, 175),
      );
    } else if (index == 3) {
      indexWidget = Image.asset(
        GeneralIcons.third,
        width: 35,
        height: 35,
        color: AppColors.goldenColor2,
      );
    }
    return Container(
      margin: AppSpacings.s15Horizental,
      child: Row(
        children: [
          indexWidget,
          const SizedBox(width: 15),
          Expanded(
            child: InkWell(
              onTap: () => FunctionsLibraryClass.showUserData(data.userId),
              child: Card(
                color: AppColors.lightColor.withOpacity(.5),
                child: Padding(
                  padding: AppSpacings.s15All,
                  child: Row(
                    children: [
                      const SizedBox(width: 5),
                      Container(
                        padding: AppSpacings.s2All,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.lightColor,
                          ),
                          shape: BoxShape.circle,
                        ),
                        width: 50,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset(
                            AvatarIcons().generalAvatarPath(data.userImage),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          data.username,
                          style: const TextStyle(
                            fontFamily: FontFamilies.dastnevis,
                            fontSize: 25,
                            color: AppColors.lightColor,
                          ),
                        ),
                      ),
                      Text(
                        data.number.toString(),
                        style: const TextStyle(
                          fontFamily: FontFamilies.dastnevis,
                          fontSize: 25,
                          color: AppColors.lightColor,
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

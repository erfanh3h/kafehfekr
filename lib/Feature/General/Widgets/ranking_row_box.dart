import 'package:flutter/material.dart';
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
    return Container(
      margin: AppSpacings.s15Horizental,
      child: InkWell(
        child: Card(
          color: AppColors.lightColor.withOpacity(.5),
          child: Padding(
            padding: AppSpacings.s15All,
            child: Row(
              children: [
                // Text(
                //   index.toString(),
                //   style: const TextStyle(
                //     fontFamily: FontFamilies.dastnevis,
                //     fontSize: 25,
                //   ),
                // ),
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
    );
  }
}

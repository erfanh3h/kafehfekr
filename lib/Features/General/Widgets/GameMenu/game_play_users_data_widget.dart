import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_show_timer_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Features/General/Models/queuer_model.dart';
import 'package:refreshed/refreshed.dart';

class GamePlayUsersDataWidget extends StatelessWidget {
  const GamePlayUsersDataWidget({
    super.key,
    required this.playersData,
    required this.playerScores,
  });

  final List<QueuerModel> playersData;
  final RxList<int> playerScores;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetData = List.generate(
      playersData.length,
      (index) {
        final item = playersData[index];
        return UserRowWidget(
          data: item,
          color: playerColors[index],
          score: playerScores[index],
        );
      },
    );
    widgetData.insert(
      0,
      const GlobalShowTimerWidget(),
    );
    return Container(
      constraints: const BoxConstraints(
        maxWidth: GeneralGameConsts.maxGameWidth,
      ),
      padding: AppSpacings.s10Horizental,
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widgetData,
            ),
          ],
        ),
      ),
    );
  }
}

class UserRowWidget extends StatelessWidget {
  const UserRowWidget({
    super.key,
    required this.data,
    required this.color,
    required this.score,
  });

  final QueuerModel data;
  final Color color;
  final int score;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => FunctionsLibraryClass.showUserData(data.userId),
      child: Container(
        // height: 150,
        constraints: const BoxConstraints(maxWidth: 75),
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
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
              ),
              width: 65,
              child: Text(
                data.name,
                style: const TextStyle(
                  fontFamily: FontFamilies.playPen,
                  fontSize: 13,
                  color: AppColors.lightColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: Text(
                'امتیاز : ${score.toString()}',
                style: const TextStyle(
                  color: AppColors.lightColor,
                  fontSize: 13,
                  fontFamily: FontFamilies.hekayat,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

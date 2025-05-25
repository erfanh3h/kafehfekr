import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Risk/Models/enums.dart';
import 'package:kafehfekr/Games/Risk/Models/risk_user_model.dart';
import 'package:refreshed/get_utils/get_utils.dart';
import 'package:refreshed/route_manager.dart';
import 'package:refreshed/utils.dart';

const TextStyle cardTextStyle =
    TextStyle(color: AppColors.lightColor, fontSize: 12);

class RiskUserCardsDetailsWidget extends StatelessWidget {
  const RiskUserCardsDetailsWidget(
      {super.key, required this.userData, required this.username});

  final RiskUserModel userData;
  final String username;
  @override
  Widget build(BuildContext context) {
    List<Widget> wrapChildren = List.generate(
      userData.continents.keys.length,
      (index) {
        final continent = userData.continents.keys.toList()[index];
        final iconData = continentToImage(continent);
        final text = continent.name.tr;
        final count = userData.continents[continent];
        return GlobalFrameWrapper(
          // padding: AppSpacings.s2All,
          height: 120,
          width: 150,
          frame: AppImages.dialog,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 50,
                width: 40,
                child: Stack(
                  children: [
                    Image.asset(
                      iconData,
                      width: 40,
                      height: 50,
                    ),
                    Container(
                      width: 40,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.transparent.withValues(alpha: .5),
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: Center(
                        child: Text(
                          count.toString(),
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 30,
                            fontFamily: FontFamilies.playPen,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GlobalFrameWrapper(
                frame: AppImages.frame4,
                padding: AppSpacings.s2Vertical5Horizental,
                child: Text(
                  text,
                  style: cardTextStyle,
                ),
              ),
            ],
          ),
        );
      },
    );
    // wrapChildren.add(
    //   GlobalFrameWrapper(
    //     padding: AppSpacings.s2All,
    //     frame: AppImages.dialog,
    //     height: 120,
    //     width: 80,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //         const Icon(
    //           Icons.circle,
    //           size: 50,
    //         ),
    //         Text(
    //           "${userData.tokens.length} ${AppTexts.token.tr}",
    //           style: cardTextStyle,
    //         )
    //       ],
    //     ),
    //   ),
    // );
    return GlobalFrameWrapper(
      frame: AppImages.board,
      // padding: AppSpacings.s10All,
      height: Get.size.height / 2,
      width: Get.size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GlobalFrameWrapper(
            frame: AppImages.frame4,
            padding: AppSpacings.s5All,
            child: Text(
              'دارایی $username',
              style: const TextStyle(color: AppColors.lightColor, fontSize: 25),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 3,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (ctx, index) {
                final continent = userData.continents.keys.toList()[index];
                final iconData = continentToImage(continent);
                final text = continent.name.tr;
                final count = userData.continents[continent];
                return GlobalFrameWrapper(
                  // padding: AppSpacings.s2All,
                  // height: 120,
                  // width: 150,
                  frame: AppImages.dialog,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(iconData),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(150),
                          ),
                          child: Container(
                            color: Colors.transparent.withValues(alpha: .5),
                            alignment: Alignment.center,
                            child: Text(
                              count.toString(),
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 30,
                                fontFamily: FontFamilies.playPen,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      GlobalFrameWrapper(
                        frame: AppImages.frame4,
                        padding: AppSpacings.s2Vertical5Horizental,
                        child: Text(
                          text,
                          style: cardTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: userData.continents.keys.length,
            ),
          ),
          // Wrap(
          //   spacing: 1.0,
          //   runSpacing: 1.0,
          //   children: wrapChildren,
          // ),
          const SizedBox(height: 15),
          GlobalFrameWrapper(
            padding: AppSpacings.s2All,
            frame: AppImages.frame4,
            height: 40,
            width: 150,
            child: Center(
              child: Text(
                "${userData.strategiesCount ?? 0} ${AppTexts.strategy.tr}",
                style:
                    const TextStyle(color: AppColors.lightColor, fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Network/game_socket.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class GlobalReactionsBox extends StatefulWidget {
  const GlobalReactionsBox({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  State<GlobalReactionsBox> createState() => _GlobalReactionsBoxState();
}

class _GlobalReactionsBoxState extends State<GlobalReactionsBox> {
  int index = 0;
  changeIndex(int value) {
    setState(() {
      index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacings.s15All,
      child: Column(
        children: [
          // const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GlobalButtonWidget(
                  onTap: () => changeIndex(0),
                  text: AppTexts.sticker.tr,
                  color:
                      index == 0 ? AppColors.darkGreen : AppColors.goldenColor2,
                ),
              ),
              Expanded(
                child: GlobalButtonWidget(
                  onTap: () => changeIndex(1),
                  text: AppTexts.kori.tr,
                  color:
                      index == 1 ? AppColors.darkGreen : AppColors.goldenColor2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Expanded(
            child: index == 0
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (ctx, index) => InkWell(
                      onTap: () {
                        Get.find<GameSocketManager>().sendReaction(index + 1);
                        Get.closeAllBottomSheets();
                        if (widget.onTap != null) {
                          widget.onTap!();
                        }
                      },
                      child: Image.asset(
                        ReactionIcons().generalIconsPath(index + 1),
                        color: AppColors.lightColor,
                      ),
                    ),
                    itemCount: ReactionIcons.reactionsCount,
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 2,
                    ),
                    itemBuilder: (ctx, index) => InkWell(
                      onTap: () {
                        Get.find<GameSocketManager>().sendReaction(index + 101);
                        Get.closeAllBottomSheets();
                        if (widget.onTap != null) {
                          widget.onTap!();
                        }
                      },
                      child: Container(
                        padding: AppSpacings.s5All,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.lightColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            koris[index],
                            style: const TextStyle(
                              fontFamily: FontFamilies.hekayat,
                              fontSize: 16,
                              color: AppColors.lightColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    itemCount: koris.length,
                  ),
          ),
        ],
      ),
    );
  }
}

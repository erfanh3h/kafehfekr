import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/RPC/Controllers/rpc_controller.dart';
import 'package:kafehfekr/Feature/RPC/Widgets/rpc_button.dart';
import 'package:kafehfekr/Feature/RPC/Widgets/rpc_log_peace.dart';
import 'package:refreshed/refreshed.dart';

class RPCMainWidget extends StatelessWidget {
  const RPCMainWidget({
    super.key,
    required this.controller,
  });

  final RPCController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: AppSpacings.s10All,
        height:
            (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        width:
            (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        child: Obx(
          () => controller.peaceSelected.value
              ? (controller.player1SelectedPeace.value != null &&
                      controller.player2SelectedPeace.value != null)
                  ? Row(
                      children: [
                        Expanded(
                          child: RpcLogPeace(
                            peaceType: controller.player1SelectedPeace.value!,
                            imageColor: AppColors.imageRedColor,
                            isThisWinner:
                                controller.isThisGamerIdThisTurnRoundWinner(1),
                          ),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          child: RpcLogPeace(
                            peaceType: controller.player2SelectedPeace.value!,
                            imageColor: AppColors.imageBlueColor,
                            isThisWinner:
                                controller.isThisGamerIdThisTurnRoundWinner(2),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        AppTexts.wait.tr,
                        style: const TextStyle(
                          color: AppColors.peaceBorderColor,
                          fontSize: 22,
                        ),
                      ),
                    )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppTexts.selectOneOption.tr,
                        style: const TextStyle(
                          color: AppColors.peaceBorderColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 15),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        itemBuilder: (ctx, index) => Obx(
                          () => RPCButton(
                            peaceData: controller.peaces[index].value,
                            onTap: controller.onEachButtonTap,
                          ),
                        ),
                        itemCount: controller.peaces.length,
                      ),
                      const SizedBox(height: 25),
                      Center(
                        child: SizedBox(
                          height: 40,
                          width: 150,
                          child: GlobalButtonWidget(
                            onTap: controller.acceptSelection,
                            text: AppTexts.accept.tr,
                            color: AppColors.peaceBorderColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/RPC/Controllers/rpc_controller.dart';
import 'package:kafehfekr/Feature/RPC/Widgets/rpc_button.dart';
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
        padding: AppSpacings.s20All,
        width: Get.size.width * .95,
        height: Get.size.width * .95,
        child: Obx(
          () => controller.peaceSelected.value
              ? Center(
                  child: Text(
                    AppTexts.wait.tr,
                    style: TextStyle(
                      color: AppColors.peaceBorderColor,
                      fontSize: 22.sp,
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
                        style: TextStyle(
                          color: AppColors.peaceBorderColor,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 15.h),
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
                      SizedBox(height: 20.h),
                      SizedBox(
                        height: 40.h,
                        child: GlobalButtonWidget(
                          onTap: controller.acceptSelection,
                          text: AppTexts.accept.tr,
                          color: AppColors.peaceBorderColor,
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

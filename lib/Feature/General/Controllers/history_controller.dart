import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_guide_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:kafehfekr/Feature/General/Models/user_history_model.dart';
import 'package:refreshed/refreshed.dart';

class HistoryController extends BaseController {
  Rx<UserHistoryModel?> myHistoryData = Rx(null);

  Future<void> fetchMyHistoryData() async {
    isPageLoading.value = true;
    // final dataResult = await globalRepo.getMyHistoryData();
    // if (dataResult.resultData != null) {
    //   myHistoryData.value = dataResult.resultData!;
    // }
    isPageLoading.value = false;
  }

  @override
  void onInit() async {
    await fetchMyHistoryData();
    super.onInit();
  }
}

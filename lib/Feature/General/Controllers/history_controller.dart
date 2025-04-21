import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Core/global_repository.dart';
import 'package:kafehfekr/Feature/General/Models/user_history_model.dart';
import 'package:refreshed/refreshed.dart';

class HistoryController extends BaseController {
  final GlobalRepository globalRepo = GlobalRepository();
  Rx<UserHistoryModel?> myHistoryData = Rx(null);

  Future<void> fetchMyHistoryData() async {
    isPageLoading.value = true;
    final dataResult = await globalRepo.getMyHistoryData();
    if (dataResult.resultData != null) {
      myHistoryData.value = dataResult.resultData!;
    }
    isPageLoading.value = false;
  }

  @override
  void onInit() async {
    await fetchMyHistoryData();
    super.onInit();
  }
}

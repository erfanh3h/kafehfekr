import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Features/General/Core/general_repository.dart';
import 'package:kafehfekr/Features/General/Models/ranking_model.dart';
import 'package:refreshed/refreshed.dart';

class RankingController extends BaseController {
  final GeneralRepository repo = GeneralRepository();

  RxInt selectedTab = RxInt(0);
  RxBool isGettingData = RxBool(false);

  RxList<RankingModel> byWinData = RxList([]);
  RxList<RankingModel> byScoreData = RxList([]);

  void changeTab(int value) {
    selectedTab.value = value;
    if (value == 1) {
      getByWinData();
    } else {
      getByScoreData();
    }
  }

  Future<void> getByScoreData() async {
    isGettingData.value = true;
    // await Future.delayed(const Duration(seconds: 10));
    final result = await repo.getRankingByScore();
    if (result.resultData != null) {
      byScoreData.value = result.resultData!;
    }
    isGettingData.value = false;
  }

  Future<void> getByWinData() async {
    isGettingData.value = true;
    final result = await repo.getRankingByWin();
    if (result.resultData != null) {
      byWinData.value = result.resultData!;
    }
    isGettingData.value = false;
  }

  @override
  void onInit() {
    getByScoreData();
    super.onInit();
  }
}

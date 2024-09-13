import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Feature/General/Core/general_repository.dart';
import 'package:kafehfekr/Feature/General/Models/ranking_model.dart';
import 'package:refreshed/refreshed.dart';

class RankingController extends BaseController {
  final GeneralRepository repo;

  RxInt selectedTab = RxInt(0);

  RxList<RankingModel> byWinData = RxList([]);
  RxList<RankingModel> byScoreData = RxList([]);

  changeTab(int value) {
    selectedTab.value = value;
    if (value == 1 && byWinData.isEmpty) {
      getByWinData();
    }
  }

  getByScoreData() async {
    isPageLoading.value = true;
    final result = await repo.getRankingByScore();
    if (result.resultData != null) {
      byScoreData.value = result.resultData!;
    }
    isPageLoading.value = false;
  }

  getByWinData() async {
    isPageLoading.value = true;
    final result = await repo.getRankingByWin();
    if (result.resultData != null) {
      byWinData.value = result.resultData!;
    }
    isPageLoading.value = false;
  }

  RankingController({required this.repo});
  @override
  void onInit() {
    getByScoreData();
    super.onInit();
  }
}

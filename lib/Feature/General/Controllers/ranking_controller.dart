import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Feature/General/Core/general_repository.dart';
import 'package:kafehfekr/Feature/General/Models/ranking_model.dart';
import 'package:refreshed/refreshed.dart';

class RankingController extends BaseController {
  final GeneralRepository repo;

  RxInt selectedTab = RxInt(0);
  RxBool isGettingData = RxBool(false);

  RxList<RankingModel> byWinData = RxList([]);
  RxList<RankingModel> byScoreData = RxList([]);

  changeTab(int value) {
    selectedTab.value = value;
    if (value == 1) {
      getByWinData();
    } else {
      getByScoreData();
    }
  }

  getByScoreData() async {
    isGettingData.value = true;
    // await Future.delayed(const Duration(seconds: 10));
    final result = await repo.getRankingByScore();
    if (result.resultData != null) {
      byScoreData.value = result.resultData!;
    }
    isGettingData.value = false;
  }

  getByWinData() async {
    isGettingData.value = true;
    final result = await repo.getRankingByWin();
    if (result.resultData != null) {
      byWinData.value = result.resultData!;
    }
    isGettingData.value = false;
  }

  RankingController({required this.repo});
  @override
  void onInit() {
    getByScoreData();
    super.onInit();
  }
}

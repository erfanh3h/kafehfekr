import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Feature/General/Core/general_repository.dart';

class RankingController extends BaseController {
  final GeneralRepository repo;

  RankingController({required this.repo});
  @override
  void onInit() {
    repo.getRankingByScore();
    repo.getRankingByWin();
    super.onInit();
  }
}

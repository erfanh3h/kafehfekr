import 'package:kafehfekr/Feature/General/Controllers/maintence_controlle.dart';
import 'package:kafehfekr/Feature/General/Controllers/ranking_controller.dart';
import 'package:kafehfekr/Feature/General/Controllers/update_controller.dart';
import 'package:kafehfekr/Feature/General/Core/general_repository.dart';
import 'package:refreshed/refreshed.dart';

class GeneralBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<GeneralRepository>(() => GeneralRepositoryImp(),
            fenix: true),
        Get.lazyPut<UpdateController>(
          () => UpdateController(),
          fenix: true,
        ),
        Get.lazyPut<MaintenceController>(
          () => MaintenceController(),
          fenix: true,
        ),
        Get.lazyPut<RankingController>(
          () => RankingController(repo: Get.find<GeneralRepository>()),
          fenix: true,
        ),
      ];
}

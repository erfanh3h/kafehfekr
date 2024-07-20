import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:refreshed/refreshed.dart';

class GlobalBinding implements BindingsInterface {
  @override
  dependencies() => [
        // AuthBinding().dependencies(),
        // Get.lazyPut<GlobalRepository>(() => GlobalRepositoryImp(), fenix: true),
        Get.put(GlobalController()),
        Get.lazyPut<TimerCompanent>(TimerCompanent.new, fenix: true),
      ];
}

import 'package:kafehfekr/Games/RPC/Controllers/rpc_controller.dart';
import 'package:refreshed/refreshed.dart';

class RPCBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<RPCController>(
          () => RPCController(),
          fenix: true,
        ),
      ];
}

import 'package:kafehfekr/Feature/BattleShip/Controllers/battleship_controller.dart';
import 'package:refreshed/refreshed.dart';

class BattleShipBinding implements BindingsInterface {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut<BattleShipController>(
          () => BattleShipController(),
          fenix: true,
        ),
      ];
}

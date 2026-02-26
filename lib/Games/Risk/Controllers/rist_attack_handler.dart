import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Games/Risk/Controllers/risk_controller.dart';
import 'package:kafehfekr/Games/Risk/Models/enums.dart';
import 'package:refreshed/refreshed.dart';

class RiskAttackHandler {
  ContinentTypes? sourceContinent, targetContinent;
  int? targetIndex;
  void startAttack() {
    final riskController = Get.find<RiskController>();
    riskController.gameState(RiskGameStates.SelectContinents);
  }

  void submitSourceContinent(ContinentTypes continent) {
    sourceContinent = continent;
  }

  void submitTargetUserIndex(int index) {
    targetIndex = index + 1;
  }

  void submitTargetContinent(ContinentTypes continent) {
    targetContinent = continent;
    declareAttack();
  }

  void declareAttack() {
    final riskController = Get.find<RiskController>();

    riskController.sendCommand({
      'id': GameCommands.declareAttack,
      'source_continent': sourceContinent!.name,
      'target_continent': targetContinent!.name,
      'target_index': targetIndex!,
    });
  }
}

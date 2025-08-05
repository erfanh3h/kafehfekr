import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_wait_widget.dart';
import 'package:kafehfekr/Games/Risk/Models/enums.dart';
import 'package:kafehfekr/Games/Risk/Widgets/risk_action_result_widget.dart';
import 'package:kafehfekr/Games/Risk/Widgets/risk_draw_part_widget.dart';
import 'package:kafehfekr/Games/Risk/Widgets/risk_draw_result_part_widget.dart';
import 'package:kafehfekr/Games/Risk/Widgets/risk_log_widget.dart';
import 'package:kafehfekr/Games/Risk/Widgets/risk_select_continents_widget.dart';

class RiskBoardWidget extends StatelessWidget {
  const RiskBoardWidget({
    super.key,
    required this.gameState,
  });

  final RiskGameStates gameState;

  @override
  Widget build(BuildContext context) {
    Widget currentWidget;
    switch (gameState) {
      case RiskGameStates.StartGame:
        currentWidget = const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        );
      case RiskGameStates.Draw:
        currentWidget = const RiskDrawPartWidget();
        break;
      case RiskGameStates.DrawResult:
        currentWidget = const RiskDrawResultPartWidget();
      case RiskGameStates.Loading:
        currentWidget = const GlobalWaitWidget();
      case RiskGameStates.ActionResult:
        currentWidget = const RiskActionResultWidget();
      case RiskGameStates.SelectContinents:
        currentWidget = const RiskSelectContinentsWidget();
      case RiskGameStates.DeclareAttack:
        currentWidget = const RiskLogWidget();
      default:
        currentWidget = Container();
    }
    return currentWidget;
  }
}

// ignore_for_file: constant_identifier_names

import 'package:kafehfekr/Core/Resources/app_icons.dart';

enum StrategyTypes { Army, Backup, Bomb, Destroy, Cancel, Canon, Expand, Spy }

enum ContinentTypes {
  Asia,
  Africa,
  Europe,
  NorthAmerica,
  SouthAmerica,
  Australia
}

enum RiskGameStates {
  StartGame,
  Loading,
  WaitOpponent,
  Draw,
  DrawResult,
  SelectAction,
  DeclareAttack,
  SelectContinents,
  ActionResult
}

String continentToImage(ContinentTypes continent) {
  switch (continent) {
    case ContinentTypes.Asia:
      return GeneralIcons.asia;
    case ContinentTypes.Africa:
      return GeneralIcons.africa;
    case ContinentTypes.Europe:
      return GeneralIcons.europe;
    case ContinentTypes.Australia:
      return GeneralIcons.australia;
    case ContinentTypes.SouthAmerica:
      return GeneralIcons.southAmerica;
    case ContinentTypes.NorthAmerica:
      return GeneralIcons.northAmerica;
  }
}

String strategyToImage(StrategyTypes strategy) {
  switch (strategy) {
    case StrategyTypes.Army:
      return GeneralIcons.army;
    case StrategyTypes.Backup:
      return GeneralIcons.backup;
    case StrategyTypes.Bomb:
      return GeneralIcons.riskBomb;
    case StrategyTypes.Destroy:
      return GeneralIcons.destroy;
    case StrategyTypes.Cancel:
      return GeneralIcons.cancel;
    case StrategyTypes.Canon:
      return GeneralIcons.canon;
    case StrategyTypes.Expand:
      return GeneralIcons.expand;
    case StrategyTypes.Spy:
      return GeneralIcons.spy;
  }
}

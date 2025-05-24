import 'package:kafehfekr/Games/Risk/Models/card_models.dart';

class RiskUserModel {
  RiskUserModel({
    required this.index,
    this.strategies,
    this.strategiesCount,
    required this.continents,
    required this.tokens,
  });

  int index;
  List<StrategyTypes>? strategies;
  int? strategiesCount;
  Map<ContinentTypes, int> continents;
  List<ContinentTypes> tokens;

  factory RiskUserModel.fromGlobalJson(Map data) {
    Map<ContinentTypes, int> finalContinents = {};
    List<ContinentTypes> finalTokens = [];
    for (var continent in data['continents'].keys) {
      final ContinentTypes continentName = ContinentTypes.values.firstWhere(
        (e) {
          return e.name == continent;
        },
        orElse: () => ContinentTypes.Asia,
      );
      finalContinents[continentName] = data['continents'][continent];
    }
    for (var continent in data['tokens']) {
      final ContinentTypes continentName = ContinentTypes.values.firstWhere(
        (e) => e.toString() == continent,
        orElse: () => ContinentTypes.Asia,
      );
      finalTokens.add(continentName);
    }

    return RiskUserModel(
      index: data['index'],
      continents: finalContinents,
      strategiesCount: data['strategies_count'],
      tokens: finalTokens,
    );
  }

  factory RiskUserModel.fromPrivateJson(Map data) {
    return RiskUserModel(
      index: data['index'],
      continents: data['continents'],
      strategies: data['strategies'],
      tokens: data['tokens'],
    );
  }
}

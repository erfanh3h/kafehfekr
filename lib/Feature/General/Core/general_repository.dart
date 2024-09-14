import 'package:kafehfekr/Core/Global/Models/api_result.dart';
import 'package:kafehfekr/Core/Network/network_exceptions.dart';
import 'package:kafehfekr/Core/Network/rest_client.dart';
import 'package:kafehfekr/Core/Routes/server_routes.dart';
import 'package:kafehfekr/Feature/General/Models/ranking_model.dart';

abstract class GeneralRepository {
  Future<ApiResult<List<RankingModel>>> getRankingByScore();
  Future<ApiResult<List<RankingModel>>> getRankingByWin();
  Future<ApiResult<int>> getFreeCoin();
}

class GeneralRepositoryImp extends GeneralRepository {
  final RestClient _restClient = RestClient();

  @override
  Future<ApiResult<List<RankingModel>>> getRankingByScore() async {
    List<RankingModel> data = [];
    var response = await _restClient.getData(ServerRoutes.rankingByScore);
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      for (var rawData in response.resultData['result']) {
        data.add(RankingModel.fromScoreJson(rawData));
      }
    } else {
      errorData = response.errorData;
    }
    var result =
        ApiResult<List<RankingModel>>(resultData: data, errorData: errorData);
    return result;
  }

  @override
  Future<ApiResult<List<RankingModel>>> getRankingByWin() async {
    List<RankingModel> data = [];
    var response = await _restClient.getData(ServerRoutes.rankingByWin);
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      for (var rawData in response.resultData['result']) {
        data.add(RankingModel.fromWinJson(rawData));
      }
    } else {
      errorData = response.errorData;
    }
    var result =
        ApiResult<List<RankingModel>>(resultData: data, errorData: errorData);
    return result;
  }

  @override
  Future<ApiResult<int>> getFreeCoin() async {
    int data = 0;
    var response = await _restClient.getData(ServerRoutes.getFreeCoin);
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      data = response.resultData['result'];
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<int>(resultData: data, errorData: errorData);
    return result;
  }
}

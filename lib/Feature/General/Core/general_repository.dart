import 'package:kafehfekr/Core/Global/Models/api_result.dart';
import 'package:kafehfekr/Core/Network/network_exceptions.dart';
import 'package:kafehfekr/Core/Network/rest_client.dart';
import 'package:kafehfekr/Core/Routes/server_routes.dart';
import 'package:kafehfekr/Feature/General/Models/ranking_model.dart';

class GeneralRepository with RestClient {
  Future<ApiResult<List<RankingModel>>> getRankingByScore() async {
    List<RankingModel> data = [];
    var response = await getData(ServerRoutes.rankingByScore);
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

  Future<ApiResult<List<RankingModel>>> getRankingByWin() async {
    List<RankingModel> data = [];
    var response = await getData(ServerRoutes.rankingByWin);
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

  Future<ApiResult<int>> getFreeCoin() async {
    int data = 0;
    var response = await getData(
      ServerRoutes.getFreeCoin,
      showMessageOnError: false,
    );
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      data = response.resultData['result'];
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<int>(resultData: data, errorData: errorData);
    return result;
  }

  Future<ApiResult<bool>> purchase({
    required String productId,
    required String marketType,
    required String token,
  }) async {
    bool data = true;
    var response =
        await sendData(ServerRoutes.purchase, showMessageOnError: false, data: {
      'product_id': productId,
      'market_type': marketType,
      'token': token,
    });
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      data = response.resultData['result'];
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<bool>(resultData: data, errorData: errorData);
    return result;
  }
}

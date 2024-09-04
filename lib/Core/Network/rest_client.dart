import 'dart:developer';

import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

import '../Global/Controllers/global_controller.dart';
import '../Global/Models/api_result.dart';

import 'network_exceptions.dart';
import 'package:dio/dio.dart' as http;

class RestClient {
  Future<ApiResult<T>> getData<T>(
    final String url, {
    final bool needToken = true,
    final bool showMessageOnError = true,
  }) async {
    try {
      Map<String, String>? requestHeader = {
        'X-Requested-With': 'XMLHttpRequest',
      };
      if (needToken) {
        requestHeader['Authorization'] =
            Get.find<GlobalController>().token ?? '';
      }
      var dio = http.Dio(http.BaseOptions(
        headers: requestHeader,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ));
      var response = await dio.get(url);
      final results = response.data;
      log(
        'results restRequest: $results // statusCode: ${response.statusCode}',
      );
      return ApiResult.success(data: results);
    } on http.DioException catch (e) {
      if (e.type == http.DioExceptionType.connectionTimeout) {
        log('hasError: connection timeout');
      }
      if (e.type == http.DioExceptionType.receiveTimeout) {
        log('hasError: receive timeout');
      } else {
        log('hasError: ${e.response}');
      }
      final error = handleErrorStatus(e.response);
      if (showMessageOnError) {
        DialogComponent().showToast(label: error.result!);
      }
      return ApiResult.failure(error: error);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions(
            result: "Please check your internet connection and try again"),
      );
    }
  }

  // Post request
  Future<ApiResult> sendData(
    final String url, {
    final Map<String, dynamic>? data,
    final bool needToken = true,
    final bool showMessageOnError = true,
    final bool isFormData = true,
  }) async {
    try {
      Map<String, String>? requestHeader = {
        'X-Requested-With': 'XMLHttpRequest',
      };
      if (needToken) {
        requestHeader['Authorization'] =
            Get.find<GlobalController>().token ?? '';
      }
      var body = isFormData ? http.FormData.fromMap(data ?? {}) : data;
      var dio = http.Dio(
        http.BaseOptions(
          headers: requestHeader,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );
      var response = await dio.post(url, data: body);
      var results = response.data;
      log(
        'results restRequest: $results // statusCode: ${response.statusCode}',
      );
      return ApiResult.success(data: results);
    } on http.DioException catch (e) {
      if (e.type == http.DioExceptionType.connectionTimeout) {
        log('hasError: connection timeout');
      }
      if (e.type == http.DioExceptionType.receiveTimeout) {
        log('hasError: receive timeout');
      } else {
        log('hasError: ${e.response}');
      }
      final error = handleErrorStatus(e.response);
      if (showMessageOnError) {
        DialogComponent().showToast(label: error.result!);
      }
      return ApiResult.failure(error: error);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions(result: AppTexts.timeoutError.tr),
      );
    }
  }

  Future<ApiResult> deleteData(
    final String url, {
    final bool needToken = true,
    final bool showMessageOnError = true,
  }) async {
    try {
      Map<String, String>? requestHeader = {
        'X-Requested-With': 'XMLHttpRequest',
      };
      if (needToken) {
        requestHeader['Authorization'] =
            Get.find<GlobalController>().token ?? '';
      }
      var dio = http.Dio(http.BaseOptions(
        headers: requestHeader,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ));
      var response = await dio.delete(url);
      var results = response.data;
      log(
        'results restRequest: $results // statusCode: ${response.statusCode}',
      );
      return ApiResult.success(data: results);
    } on http.DioException catch (e) {
      if (e.type == http.DioExceptionType.connectionTimeout) {
        log('hasError: connection timeout');
      }
      if (e.type == http.DioExceptionType.receiveTimeout) {
        log('hasError: receive timeout');
      } else {
        log('hasError: ${e.response}');
      }
      final error = handleErrorStatus(e.response);
      if (showMessageOnError) {
        DialogComponent().showToast(label: error.result!);
      }
      return ApiResult.failure(error: error);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions(result: AppTexts.timeoutError.tr),
      );
    }
  }

  NetworkExceptions handleErrorStatus(
    http.Response? response, {
    final String? defaultErrorText,
  }) {
    String errorText = '';
    if (defaultErrorText != null) {
      errorText = defaultErrorText;
    } else {
      errorText = AppTexts.timeoutError.tr;
    }
    if (response == null) {
      final error = NetworkExceptions.fromResult(422, errorText);
      return error;
    } else {
      try {
        errorText = response.data['detail'].toString();
      } catch (_) {}
      final error =
          NetworkExceptions.fromResult(response.statusCode ?? 422, errorText);

      return error;
    }
  }
}

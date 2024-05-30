
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Dio Interceptors Log class
class CustomLogInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('');
      print('>>>> Dio Request[ ${options.method} ] => PATH : ${options.path}');
    }
    // TODO: implement onRequest
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('>>>> Dio Response[ ${response.statusCode} ] => PATH : ${response.requestOptions.path}\n',);
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print(' >>>> Dio Error[${err.response?.statusCode}] => PATH : ${err.requestOptions.path}\n',);
      print('');

    }
    return super.onError(err, handler);
  }
}
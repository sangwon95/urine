

import 'package:dio/dio.dart';
import 'package:urine/common/cli_common.dart';
import 'package:urine/layers/model/authorization.dart';

import 'custom_log_interceptor.dart';

class DioManager {
  late final Dio _publicDio;
  late final Dio _privateDio;
  static const double timeout = 7;

  DioManager() {
    _publicDio = createPublicDio();
    _privateDio = createPrivateDio();
  }

  Dio get publicDio => _publicDio;
  Dio get privateDio => _privateDio;

 static Dio createPublicDio() {
    Dio dio = Dio();
    dio.interceptors.add(CustomLogInterceptor());
    dio.options.connectTimeout = timeout.seconds;
    dio.options.receiveTimeout = timeout.seconds;
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    return dio;
  }

  static Dio createPrivateDio() {
    Dio dio = Dio();
    dio.interceptors.add(CustomLogInterceptor());
    dio.options.connectTimeout = timeout.seconds;
    dio.options.receiveTimeout = timeout.seconds;
    dio.options.headers = {
      'Authorization': 'URINE ${Authorization().token}',
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    return dio;
  }
}

import 'package:dio/dio.dart';

/// Dio Interceptors Log class
class CustomLogInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(' >>>> Request[ ${options.method} ] => PATH : ${options.path}');
    // TODO: implement onRequest
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    print(' >>>> Response[ ${response.statusCode} ] => PATH : ${response.requestOptions.path}\n',);
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
      print(' >>>> Error[${err.response?.statusCode}] => PATH : ${err.requestOptions.path}\n',);
    return super.onError(err, handler);
  }
}
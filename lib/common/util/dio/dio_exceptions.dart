

import 'package:dio/dio.dart';

import '../../common.dart';

class DioExceptions implements Exception {
  String? message;

  DioExceptions.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.cancel:
      case DioExceptionType.connectionError:
        message = Texts.connectionError;
        break;
      case DioExceptionType.badResponse:    // 200이외의 코드 발생 잘못된 요청 화면
      case DioExceptionType.unknown:        // 서버 상태가 불안정합니다. 다시 시도바랍니다.
      case DioExceptionType.badCertificate: // 서버 상태가 불안정합니다. 다시 시도바랍니다.
        message = Texts.badCertificate;
      default:
        message = Texts.unknownError;
        break;
    }
  }

  @override
  String toString() => message ?? '';
}
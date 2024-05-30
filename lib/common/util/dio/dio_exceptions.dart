

import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  String? message;

  DioExceptions.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.cancel:
      case DioExceptionType.connectionError:
        message = "네트워크 연결 상태를\n확인 해주세요.";
        break;
      case DioExceptionType.badResponse: // 200이외의 코드 발생 잘못된 요청 화면
      case DioExceptionType.unknown:        // 서바 상태가 불안정합니다. 다시 시도바랍니다.
      case DioExceptionType.badCertificate: // 서바 상태가 불안정합니다. 다시 시도바랍니다.
        message = '서버 상태가 불안정합니다.\n다시 시도바랍니다.';
      default:
        message = "서버 점검중입니다.\n잠시후 시도해주세요.";
        break;
    }
  }

  @override
  String toString() => message ?? '';
}
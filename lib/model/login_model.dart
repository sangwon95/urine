
import 'package:urine/model/rest_response.dart';

class LoginModel{
  String code;
  String message;

  LoginModel({
      required this.code,
      required this.message,
  });

  factory LoginModel.fromJson(RestResponseOnlyStatus responseBody) {
    return LoginModel(
        code     : responseBody.status['code'] ?? '-',
        message  : responseBody.status['message'] ?? '-'
    );
  }

  @override
  String toString() {
    return 'LoginModel{code: $code, message: $message}';
  }
}
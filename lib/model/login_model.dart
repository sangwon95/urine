
import 'package:urine/model/rest_response.dart';

class LoginModel{
  String code;
  String message;
  String token;

  LoginModel({
      required this.code,
      required this.message,
      required this.token,
  });

  factory LoginModel.fromJson(RestResponseDataString responseBody) {
    return LoginModel(
        code     : responseBody.status['code'] ?? '-',
        message  : responseBody.status['message'] ?? '-',
        token    : responseBody.data
    );
  }

  @override
  String toString() {
    return 'LoginModel{code: $code, message: $message, token: $token}';
  }
}
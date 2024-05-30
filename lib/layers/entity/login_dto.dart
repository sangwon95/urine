import 'package:urine/layers/entity/status_dto.dart';

class LoginDTO {
  final StatusDTO status;
  final String? data;

  LoginDTO({
    required this.status,
    this.data,
  });

  factory LoginDTO.fromJson(Map<String, dynamic> json) {
    return LoginDTO(
        status: StatusDTO.fromJson(json['status']),
        data: json['data'],
    );
  }
}

/// LoginDTO의 data object
class DataLoginDTO {
  final String email;
  final String leaveCnt;
  final String token;

  DataLoginDTO({
    required this.email,
    required this.leaveCnt,
    required this.token,
  });

  factory DataLoginDTO.fromJson(Map<String, dynamic>? json) {
    return DataLoginDTO(
      email: json?['email'] ?? '',
      leaveCnt: json?['leaveCnt'] ?? '',
      token: json?['token'] ?? '',
    );
  }
}

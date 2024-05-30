import 'package:urine/layers/entity/status_dto.dart';

class LogoutDTO {
  final StatusDTO status;
  final dynamic data; // null 반환됨

  LogoutDTO({required this.status, this.data});

  factory LogoutDTO.fromJson(Map<String, dynamic> json) {
    return LogoutDTO(
      status: StatusDTO.fromJson(json['status']),
      data: json['data'],
    );
  }
}
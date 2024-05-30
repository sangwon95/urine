import 'package:urine/layers/entity/status_dto.dart';

class UserNameDTO {
  StatusDTO status;
  String name;

  UserNameDTO({
    required this.status,
    required this.name,
  });

  factory UserNameDTO.fromJson(Map<String, dynamic> json) {
    return UserNameDTO(
      status: StatusDTO.fromJson(json['status']),
      name: json['data']['name'],
    );
  }
}

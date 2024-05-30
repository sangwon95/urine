import 'package:urine/layers/entity/status_dto.dart';

class ChangePassDTO {
  StatusDTO status;

  ChangePassDTO({required this.status});

  /// Json to Object
  factory ChangePassDTO.fromJson(Map<String, dynamic> json) {
    return ChangePassDTO(
        status: StatusDTO.fromJson(json['status']
        )
    );
  }
}

import 'package:urine/layers/entity/status_dto.dart';

class UrineSaveDTO {
  StatusDTO status;

  UrineSaveDTO({required this.status});

  /// Json to Object
  factory UrineSaveDTO.fromJson(Map<String, dynamic> json) {
    return UrineSaveDTO(
      status : StatusDTO.fromJson(json['status']),
    );
  }
}
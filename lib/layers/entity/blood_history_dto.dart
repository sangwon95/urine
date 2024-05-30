

import 'package:urine/layers/entity/status_dto.dart';

import 'summary_dto.dart';

class BloodHistoryDTO {
  final StatusDTO status;
  final List<HealthScreeningHistoryDTO> data;

  BloodHistoryDTO({
    required this.status,
    required this.data,
  });

  factory BloodHistoryDTO.fromJson(Map<String, dynamic> json) {
    return BloodHistoryDTO(
      status: StatusDTO.fromJson(json['status']),
      data: HealthScreeningHistoryDTO.jsonList(json['data']),
    );
  }
}
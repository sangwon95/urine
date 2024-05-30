import 'package:urine/layers/entity/status_dto.dart';
import 'package:urine/layers/entity/summary_dto.dart';

class PhysicalHistoryDTO {
  final StatusDTO status;
  final List<HealthScreeningDTO> data;

  PhysicalHistoryDTO({
    required this.status,
    required this.data,
  });

  factory PhysicalHistoryDTO.fromJson(Map<String, dynamic> json) {
    return PhysicalHistoryDTO(
      status: StatusDTO.fromJson(json['status']),
      data: HealthScreeningDTO.jsonList(json['data']),
    );
  }
}
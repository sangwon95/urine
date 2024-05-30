
import 'package:urine/layers/entity/status_dto.dart';
import 'package:urine/layers/entity/summary_dto.dart';

class MedicationDTO {
  final StatusDTO status;
  final List<MedicationInfoDTO> data;

  MedicationDTO({required this.status, required this.data});

  factory MedicationDTO.fromJson(Map<String, dynamic> json) {
    return MedicationDTO(
      status: StatusDTO.fromJson(json['status']),
      data: MedicationInfoDTO.jsonList(json['data']),
    );
  }
}

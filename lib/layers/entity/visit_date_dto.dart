
import 'package:urine/layers/entity/status_dto.dart';

class VisitDateDTO {
  final StatusDTO status;
  final List<dynamic> data;

  VisitDateDTO({required this.status, required this.data});

  factory VisitDateDTO.fromJson(Map<String, dynamic> json) {
    return VisitDateDTO(
      status: StatusDTO.fromJson(json['status']),
      data: json['data'].toList(),
    );
  }
}
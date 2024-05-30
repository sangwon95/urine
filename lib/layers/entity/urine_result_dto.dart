import 'package:urine/layers/entity/status_dto.dart';

class UrineResultDTO {
  StatusDTO status;
  List<UrineResultDataDTO>? data;

  UrineResultDTO({
    required this.status,
    required this.data,
  });

  factory UrineResultDTO.fromJson(Map<String, dynamic> json) {
    return UrineResultDTO(
      status: StatusDTO.fromJson(json['status']),
      data: UrineResultDataDTO.jsonList(json['data']),
    );
  }
}

class UrineResultDataDTO {
  String datetime;
  String dataType;
  String result;
  String status;

  UrineResultDataDTO({
    required this.datetime,
    required this.dataType,
    required this.result,
    required this.status,
  });

  factory UrineResultDataDTO.fromJson(Map<String, dynamic> json) {
    return UrineResultDataDTO(
      datetime: json['datetime'] ?? '-',
      dataType: json['dataType'] ?? '-',
      result: json['result'] ?? '-',
      status: json['status'] ?? '-',
    );
  }

  static List<UrineResultDataDTO> jsonList(dynamic? json) {
    if(json == null) return [];
    var tagObjsJson = json as List;
    return tagObjsJson
        .map((json) => UrineResultDataDTO.fromJson(json))
        .toList();
  }
}

import 'package:urine/layers/entity/status_dto.dart';

class UrineChartDTO {
  StatusDTO status;
  List<UrineChartDataDTO> data;

  UrineChartDTO({
    required this.status,
    required this.data,
  });

  factory UrineChartDTO.fromJson(Map<String, dynamic> json) {
    return UrineChartDTO(
      status: StatusDTO.fromJson(json['status']),
      data: UrineChartDataDTO.jsonList(json['data'] ?? []),
    );
  }
}

class UrineChartDataDTO {
  String datetime;
  String dataType;
  String result;
  String status;

  UrineChartDataDTO({
    required this.datetime,
    required this.dataType,
    required this.result,
    required this.status,
  });

  factory UrineChartDataDTO.fromJson(Map<String, dynamic> json) {
    return UrineChartDataDTO(
      datetime: json['datetime'] ?? '-',
      dataType: json['dataType'] ?? '-',
      result: json['result'] ?? '-',
      status: json['status'] ?? '-',
    );
  }

  static List<UrineChartDataDTO> jsonList(dynamic json) {
    var tagObjsJson = json as List;
    return tagObjsJson
        .map((json) => UrineChartDataDTO.fromJson(json))
        .toList();
  }
}


import 'status_dto.dart';

class LifeLogResultDTO {
  final StatusDTO status;
  final List<LifeLogData> data;

  LifeLogResultDTO({required this.status, required this.data});

  factory LifeLogResultDTO.fromJson(Map<String, dynamic> json) {
    return LifeLogResultDTO(
      status: StatusDTO.fromJson(json['status']),
      data: LifeLogData.jsonList(json['data']),
    );
  }
}


class LifeLogData {
  final String dataDesc;
  final String value;

  LifeLogData({required this.dataDesc, required this.value});

  factory LifeLogData.fromJson(Map<String, dynamic> json) {
    return LifeLogData(
        dataDesc: json['dataDesc'],
        value: json['value']
    );
  }

  static List<LifeLogData> jsonList(dynamic json) {
    var tagObjsJson = json as List;

    return tagObjsJson
        .map((json) => LifeLogData.fromJson(json))
        .toList();
  }
}
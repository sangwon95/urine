
import 'package:urine/layers/entity/status_dto.dart';

class HistoryDTO {
  final StatusDTO status;
  final List<HistoryDataDTO>? data;

  HistoryDTO({
    required this.status,
    required this.data,
  });

  factory HistoryDTO.fromJson(Map<String, dynamic> json) {
    return HistoryDTO(
      status: StatusDTO.fromJson(json['status']),
      data: HistoryDataDTO.jsonList(json['data']),
    );
  }
}

class HistoryDataDTO {
  String datetime;
  String positiveCnt;
  String negativeCnt;

  HistoryDataDTO({
    required this.datetime,
    required this.positiveCnt,
    required this.negativeCnt,
  });

  factory HistoryDataDTO.fromJson(Map<String, dynamic> json) {
    return HistoryDataDTO(
      datetime    : json['datetime'] ?? '-' ,
      positiveCnt : json['positiveCnt'] ?? '-',
      negativeCnt : json['negativeCnt'] ?? '-' ,
    );
  }

  static List<HistoryDataDTO> jsonList(dynamic json) {
    if(json == null) return [];
    var tagObjsJson = json as List;
    return tagObjsJson
        .map((json) => HistoryDataDTO.fromJson(json))
        .toList();
  }
}

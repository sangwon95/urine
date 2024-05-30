import 'package:urine/layers/entity/status_dto.dart';

class SummaryDTO {
  StatusDTO status;
  SummaryDataDTO? data;

  SummaryDTO({
    required this.status,
    required this.data,
  });

  factory SummaryDTO.fromJson(Map<String, dynamic> json) {
    return SummaryDTO(
      status: StatusDTO.fromJson(json['status']),
      data: SummaryDataDTO.fromJson(json['data']),
    );
  }
}

class SummaryDataDTO {
  final List<dynamic> issuedDateList;
  final MyDataPredictDTO? mydataPredict;
  final List<HealthScreeningDTO>? healthScreeningList;
  final List<MedicationInfoDTO>? medicationInfoList;
  final Map<String, List<HealthScreeningHistoryDTO>>? healthScreeningHistoryList;

  SummaryDataDTO({
    required this.issuedDateList,
    required this.mydataPredict,
    required this.healthScreeningList,
    required this.medicationInfoList,
    required this.healthScreeningHistoryList,
  });

  factory SummaryDataDTO.fromJson(Map<String, dynamic> json) {
    return SummaryDataDTO(
      issuedDateList: json['issuedDateList'].toList(),
      mydataPredict: MyDataPredictDTO.fromJson(json['mydataPredict']),
      healthScreeningList: HealthScreeningDTO.jsonList(json['healthScreeningList']),
      medicationInfoList: MedicationInfoDTO.jsonList(json['medicationInfoList']),
      healthScreeningHistoryList: HealthScreeningHistoryDTO.groupDataByDate(json['healthScreeningHistoryList']),
    );
  }
}


/// 나의 건강검진 기록
class MyDataPredictDTO {
  /// 관절건강 예측값(0:정상, 1:비정상)
  final String? bone;

  /// 당뇨병  예측값(0:정상, 1:비정상)
  final String? diabetes;

  /// 눈건강  예측값(0:정상, 1:비정상)
  final String? eye;

  /// 고혈압  예측값(0:정상, 1:비정상)
  final String? highpress;

  /// 면역  예측값(0:정상, 1:비정상)
  final String? immune;

  MyDataPredictDTO({
    this.bone,
    this.diabetes,
    this.eye,
    this.highpress,
    this.immune,
  });

  factory MyDataPredictDTO.fromJson(Map<String, dynamic>? json) {
    if(json == null){
      return MyDataPredictDTO(
        bone:  '-',
        diabetes:  '-',
        eye:  '-',
        highpress:  '-',
        immune:  '-',
      );
    } else {
      return MyDataPredictDTO(
        bone: json['bone'] ?? '-',
        diabetes: json['diabetes'] ?? '-',
        eye: json['eye'] ?? '-',
        highpress: json['highpress'] ?? '-',
        immune: json['immune'] ?? '-',
      );
    }
  }
}


class HealthScreeningDTO {
  /// 최근 검진일
  late String issuedDate;

  /// 검진명
  late String dataName;

  /// 검진값
  late String dataValue;

  HealthScreeningDTO(
      {required this.issuedDate,
        required this.dataName,
        required this.dataValue});

  factory HealthScreeningDTO.fromJson(Map<String, dynamic> json) {
    return HealthScreeningDTO(
        issuedDate: json['issuedDate'] ?? '-',
        dataName: json['dataName'] ?? '-',
        dataValue: json['dataValue'] ?? '-');
  }

  static List<HealthScreeningDTO> jsonList(dynamic json) {
    var tagObjsJson = json as List;

    return tagObjsJson
        .map((json) => HealthScreeningDTO.fromJson(json))
        .toList();
  }
}


class MedicationInfoDTO {
  /// 제조일자
  late String whenPrepared;

  /// 제조명
  late String medicationName;

  /// 약 코드
  late String medicationCode;

  MedicationInfoDTO({
    required this.whenPrepared,
    required this.medicationName,
    required this.medicationCode,
  });

  factory MedicationInfoDTO.fromJson(Map<String, dynamic> json) {
    return MedicationInfoDTO(
        whenPrepared: json['whenPrepared'] ?? '-',
        medicationName: json['medicationName'] ?? '-',
        medicationCode: json['medicationCode'] ?? '-');
  }

  static List<MedicationInfoDTO> jsonList(dynamic json) {
    var tagObjsJson = json as List;
    return tagObjsJson
        .map((json) => MedicationInfoDTO.fromJson(json))
        .toList();
  }
}



class HealthScreeningHistoryDTO {
  /// 최근 검진일
  late String issuedDate;

  /// 검진명
  late String dataName;

  /// 검진값
  late String dataValue;

  HealthScreeningHistoryDTO(
      {required this.issuedDate,
        required this.dataName,
        required this.dataValue});

  factory HealthScreeningHistoryDTO.fromJson(Map<String, dynamic> json) {
    return HealthScreeningHistoryDTO(
        issuedDate: json['issuedDate'] ?? '-',
        dataName: json['dataName'] ?? '-',
        dataValue: json['dataValue'] ?? '-');
  }

  static List<HealthScreeningHistoryDTO> jsonList(dynamic json) {
    var tagObjsJson = json as List;
    return tagObjsJson
        .map((json) => HealthScreeningHistoryDTO.fromJson(json))
        .toList();
  }


  static Map<String, List<HealthScreeningHistoryDTO>> groupDataByDate(dynamic json) {
    List<HealthScreeningHistoryDTO> historyList =  HealthScreeningHistoryDTO.jsonList(json);

    Map<String, List<HealthScreeningHistoryDTO>> groupedData = {};

    for (var history in historyList) {
      if (groupedData.containsKey(history.issuedDate)) {
        groupedData[history.issuedDate]!.add(history);
      } else {
        groupedData[history.issuedDate] = [history];
      }
    }

    return groupedData;
  }
}




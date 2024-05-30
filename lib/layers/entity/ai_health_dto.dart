import 'package:urine/layers/entity/status_dto.dart';

class AiHealthDTO {
  final StatusDTO status;
  final AiHealthData data;

  AiHealthDTO({required this.status, required this.data});

  factory AiHealthDTO.fromJson(Map<String, dynamic> json) {
    return AiHealthDTO(
        status: StatusDTO.fromJson(json['status']),
        data: AiHealthData.fromJson(json['data'])
    );
  }
}


class AiHealthData{
  /// T State: 0(정상예측) or 1(주의 예측)
  late String bone; // 관절
  String boneState = '예측 불가'; // 관절 예측 상태
  late String boneProb; // 관절 예측 확률

  late String diabetes; // 당뇨
  String diabetesState = '예측 불가'; // 당뇨 예측 상태
  late String diabetesProb; // 당뇨 예측 확률

  late String eye; // 눈건강
  String eyeState = '예측 불가'; // 눈건강 예측 상태
  late String eyeProb; // 눈건강 예측 확률

  late String highpress; // 고혈압
  late String highpressState; // 고혈압 예측 상태
  late String highpressProb; // 고혈압 예측 확률

  late String immune; // 면역
  late String immuneState = '예측 불가'; // 면역 예측 상태
  late String immuneProb; // 면역 예측 확률

  late String hypertensionAge; // 고혈압 발병 예측 나이
  late String diabetesAge; // 당뇨병 발병 얘측 나이
  late String obesityAge; // 비만 발병 예측 나이
  late String liverAge;  // 간 질환 발병 예측 나이

  AiHealthData({
    required this.bone,
    required this.boneState,
    required this.boneProb,
    required this.diabetes,
    required this.diabetesState,
    required this.diabetesProb,
    required this.eye,
    required this.eyeState,
    required this.eyeProb,
    required this.highpress,
    required this.highpressState,
    required this.highpressProb,
    required this.immune,
    required this.immuneState,
    required this.immuneProb,
    required this.hypertensionAge,
    required this.diabetesAge,
    required this.obesityAge,
    required this.liverAge,
  });

  factory AiHealthData.fromJson(Map<String, dynamic>? json){
    return AiHealthData(
      bone: json?['bone'] ?? '0',
      boneState: json?['bone'] == '0' ? '정상예측' : json?['bone'] == '1' ? '주의예측' : '예측 불가',
      boneProb: json?['boneProb'] ?? '0',
      diabetes: json?['diabetes'] ?? '0',
      diabetesState: json?['diabetes'] == '0' ? '정상예측' : json?['diabetes'] == '1' ? '주의예측' : '예측 불가',
      diabetesProb: json?['diabetesProb'] ?? '0',
      eye: json?['eye'] ?? '0',
      eyeState: json?['eye'] == '0' ? '정상예측' : json?['eye'] == '1' ? '주의예측' : '예측 불가',
      eyeProb: json?['eyeProb'] ?? '0',
      highpress: json?['highpress'] ?? '0',
      highpressState: json?['highpress'] == '0' ? '정상예측' : json?['highpress'] == '1' ? '주의예측' : '예측 불가',
      highpressProb: json?['highpressProb'] ?? '0',
      immune: json?['immune'] ?? '0',
      immuneState: json?['immune'] == '0' ? '정상예측' : json?['immune'] == '1' ? '주의예측' : '예측 불가',
      immuneProb: json?['immuneProb'] ?? '0',
      hypertensionAge: json?['hypertensionAge'] ?? '-',
      diabetesAge: json?['diabetesAge'] ?? '-',
      obesityAge: json?['obesityAge'] ?? '-',
      liverAge: json?['liverAge'] ?? '-',
    );
  }
}
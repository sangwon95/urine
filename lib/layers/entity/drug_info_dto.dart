import 'package:urine/layers/entity/status_dto.dart';

class DrugInfoDTO {
  final StatusDTO status;
  final DrugInfoDataDTO data;

  DrugInfoDTO({required this.status, required this.data});

  factory DrugInfoDTO.fromJson(Map<String, dynamic> json) {
    return DrugInfoDTO(
      status: StatusDTO.fromJson(json['status']),
      data: DrugInfoDataDTO.fromJson(json['data']),
    );
  }
}


class DrugInfoDataDTO {
  /// 제품명_ko
  late String drugNameKR;

  /// 제품명_en
  late String drugNameEN;

  /// 성분_함량
  late String ingredient;

  /// 첨가제
  late String additives;

  /// 성상
  late String properties;

  /// 급여정보
  late String medicationCode;

  /// ATC_코드
  late String atcCode;

  /// 식약처_분류
  late String classification;

  /// DUR
  late String dur;

  /// 효능_효과
  late String efficacy;

  /// 용법_용량
  late String usage;

  /// 사용상의_주의사항
  late String precaution;

  /// 복약정보
  late String info;

  /// 제조_수입사
  late String company;

  /// img_url
  late String imageUrl;

  DrugInfoDataDTO({
    required this.drugNameKR,
    required this.drugNameEN,
    required this.ingredient,
    required this.additives,
    required this.properties,
    required this.medicationCode,
    required this.atcCode,
    required this.classification,
    required this.dur,
    required this.efficacy,
    required this.usage,
    required this.precaution,
    required this.info,
    required this.company,
    required this.imageUrl});

  factory DrugInfoDataDTO.fromJson(Map<String, dynamic>? json) {
    return DrugInfoDataDTO(
      drugNameKR: json?['drugNameKR'] ?? '-',
      drugNameEN: json?['drugNameEN'] ?? '-',
      ingredient: json?['ingredient'] ?? '-',
      additives: json?['additives'] ?? '-',
      properties: json?['properties'] ?? '-',
      medicationCode: json?['medicationCode'] ?? '-',
      atcCode: json?['atcCode'] ?? '-',
      classification: json?['classification'] ?? '-',
      dur: json?['dur'] ?? '-',
      efficacy: json?['efficacy'] ?? '-',
      usage: json?['usage'] ?? '-',
      precaution: json?['precaution'] ?? '-',
      info: json?['info'] ?? '-',
      company: json?['company'] ?? '-',
      imageUrl: json?['imageUrl'] ?? '-',
    );
  }
}
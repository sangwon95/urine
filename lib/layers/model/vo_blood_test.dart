

import '../../common/util/text_format.dart';
import '../entity/summary_dto.dart';

class BloodTest {
  /// 혈색소
  String? _hemoglobin;

  /// 공복혈당
  String? _fastingBloodSugar;

  /// 총콜레스테롤
  String? _totalCholesterol;

  /// 고밀도 콜레스테롤
  String? _highDensityCholesterol;

  /// 중성지방
  String? _neutralFat;

  /// 저밀도 콜레스테롤
  String? _lowDensityCholesterol;

  /// 혈청크레아티닌
  String? _serumCreatinine;

  /// 신사구체여과율
  String? _shinsugularFiltrationRate;

  /// AST(SGOT)
  String? _astSgot;

  /// ALT(SGPT)
  String? _altSGpt;

  /// 감마지티피(γ-GTP)
  String? _gammaGtp;

  /// 검진 일
  String? _issuedDate;

  String? get issuedDate => _issuedDate;
  set issuedDate(String? value) =>_issuedDate = value!;

  String? get hemoglobin => _hemoglobin;
  set hemoglobin(String? value) =>_hemoglobin = value!;

  String? get fastingBloodSugar => _fastingBloodSugar;
  set fastingBloodSugar(String? value) => _fastingBloodSugar = value!;


  String? get gammaGtp => _gammaGtp;
  set gammaGtp(String? value) => _gammaGtp = value!;

  String? get altSGpt => _altSGpt;
  set altSGpt(String? value) =>_altSGpt = value!;


  String? get astSgot => _astSgot;
  set astSgot(String? value) => _astSgot = value!;

  String? get shinsugularFiltrationRate => _shinsugularFiltrationRate;
  set shinsugularFiltrationRate(String? value) =>_shinsugularFiltrationRate = value!;


  String? get serumCreatinine => _serumCreatinine;
  set serumCreatinine(String? value) =>_serumCreatinine = value!;


  String? get lowDensityCholesterol => _lowDensityCholesterol;
  set lowDensityCholesterol(String? value) => _lowDensityCholesterol = value!;


  String? get neutralFat => _neutralFat;
  set neutralFat(String? value) => _neutralFat = value!;


  String? get highDensityCholesterol => _highDensityCholesterol;
  set highDensityCholesterol(String? value) => _highDensityCholesterol = value!;

  String? get totalCholesterol => _totalCholesterol;
  set totalCholesterol(String? value) => _totalCholesterol = value!;

  void parseFromHealthScreeningList(List<HealthScreeningDTO> healthScreeningList) {
    for (HealthScreeningDTO value in healthScreeningList) {
      String dataName = value.dataName;
      String dataValue = TextFormat.removeAfterSpace(value.dataValue);

      switch (dataName) {
        case '혈액검사_고밀도 콜레스테롤':
          highDensityCholesterol = dataValue;
          issuedDate = TextFormat.defaultDateFormat(value.issuedDate);
          break;
        case '혈액검사_공복혈당':
          fastingBloodSugar = dataValue;
          break;
        case '혈액검사_신사구체여과율':
          shinsugularFiltrationRate = dataValue;
          break;
        case '혈액검사_저밀도 콜레스테롤':
          lowDensityCholesterol = dataValue;
          break;
        case '혈액검사_중성지방':
          neutralFat = dataValue;
          break;
        case '혈액검사_총콜레스테롤':
          totalCholesterol = dataValue;
          break;
        case '혈액검사_혈색소':
          hemoglobin = dataValue;
          break;
        case '혈액검사_혈청 크레아티닌':
          serumCreatinine = dataValue;
          break;
        case '혈액검사_ALT(SGPT)':
          altSGpt = dataValue;
          break;
        case '혈액검사_AST(SGOT)':
          astSgot = dataValue;
          break;
        case '혈액검사_감마지피티(y-GPT)':
          gammaGtp = dataValue;
          break;
        default:
        // 처리하지 않는 데이터명의 경우 아무 동작도 하지 않음
          break;
      }
    }
  }

  List<String> toList() {
    return [
      hemoglobin ?? '-', // 혈색소
      fastingBloodSugar ?? '-', // 공복 혈당
      totalCholesterol ?? '-', // 총 콜레스테롤
      highDensityCholesterol ?? '-',
      neutralFat ?? '-',
      lowDensityCholesterol ?? '-',
      serumCreatinine ?? '-',
      shinsugularFiltrationRate ?? '-',
      astSgot ?? '-',
      altSGpt ?? '-',
      gammaGtp ?? '-',
    ];
  }

  List<String> nameList() {
    return [
      '혈색소',
      '공복혈당',
      '총콜레스테롤',
      '고밀도 콜레스테롤',
      '중성지방',
      '저밀도 콜레스테롤',
      '혈청 크레아티닌',
      '신사구체여과율',
      'AST(SGOT)',
      'ALT(SGPT)',
      '감마지피티(y-GPT)',
    ];
  }
}
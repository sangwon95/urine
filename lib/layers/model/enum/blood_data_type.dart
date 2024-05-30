
enum BloodDataType {
  hemoglobin('혈색소', '범위'),
  fastingBloodSugar('공복혈당', '미만'),
  totalCholesterol('총콜레스테롤', '미만'),
  highDensityCholesterol('고밀도 콜레스테롤', '이상'),
  neutralFat('중성지방', '미만'),
  lowDensityCholesterol('저밀도 콜레스테롤', '미만'),
  serumCreatinine('혈청 크레아티닌', '이하'),
  shinsugularFiltrationRate('신사구체여과율', '이상'),
  astSgot('AST(SGOT)', '이하'),
  altSGpt('ALT(SGPT)', '이하'),
  gammaGtp('감마지피티(y-GPT)', '이하');

  const BloodDataType(this.label, this.inequalitySign);

  final String label;
  final String inequalitySign;

  static BloodDataType strToEnum(String str) {
    return BloodDataType.values.firstWhere((e) => e.label == str);
  }
}
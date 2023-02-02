class UrineModel{

  /// 잠혈
  late String blood;

  /// 빌리루빈
  late String billrubin;

  /// 우로빌리노겐
  late String urobillnogen;

  /// 케톤체
  late String ketones;

  /// 단백질
  late String protein;

  /// 아질산
  late String nitrite;

  /// 포도당
  late String glucose;

  /// 산성도
  late String pH;

  /// 비중
  late String sG;

  /// 백혈구
  late String leucoytes;

  /// 비타민
  late String vitamin;

  /// 리스트로 초기화
  late List<String> urineList = [];


  @override
  String toString() {
    return 'UrineModel{blood: $blood, billrubin: $billrubin, urobillnogen: $urobillnogen, ketones: $ketones, protein: $protein, nitrite: $nitrite, glucose: $glucose, pH: $pH, sG: $sG, leucoytes: $leucoytes, vitamin: $vitamin}';
  }

  initialization(String sb) {
    blood = parsingResultBuffer('#A01', sb);
    urineList.add(blood);

    billrubin  = parsingResultBuffer('#A02', sb);
    urineList.add(billrubin);

    urobillnogen = parsingResultBuffer('#A03', sb);
    urineList.add(urobillnogen);

    ketones  = parsingResultBuffer('#A04', sb);
    urineList.add(ketones);

    protein = parsingResultBuffer('#A05', sb);
    urineList.add(protein);

    nitrite = parsingResultBuffer('#A06', sb);
    urineList.add(nitrite);

    glucose = parsingResultBuffer('#A07', sb);
    urineList.add(glucose);

    pH = parsingResultBuffer('#A08', sb);
    urineList.add(pH);

    sG  = parsingResultBuffer('#A09', sb);
    urineList.add(blood);

    leucoytes  = parsingResultBuffer('#A10', sb);
    urineList.add(blood);

    vitamin = parsingResultBuffer('#A11', sb);
    urineList.add(vitamin);
  }

  String parsingResultBuffer(String baseStr, String sb){
    int idx = sb.replaceAll('\n','').indexOf(baseStr);
    String result = sb.substring(idx + 5, (idx + 6));
    return result;
  }
}
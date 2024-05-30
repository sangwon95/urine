import 'package:intl/intl.dart';

class Urine {

  /// 잠혈
  String blood;

  /// 빌리루빈
  String billrubin;

  /// 우로빌리노겐
  String urobillnogen;

  /// 케톤체
  String ketones;

  /// 단백질
  String protein;

  /// 아질산
  String nitrite;

  /// 포도당
  String glucose;

  /// 산성도
  String pH;

  /// 비중
  String sG;

  /// 백혈구
  String leucoytes;

  /// 비타민
  String vitamin;

  /// 리스트로 초기화
  late List<String> urineList = [];

  /// 검사 날짜 및 시간
  late String date;

  /// 저장 응답 코드
  late String? code;

  /// 저장 응답 메시지
  late String? message;

  /// 결과데이터 Map 리스트
  List<Map<String, dynamic>> dataMap = <Map<String, dynamic>>[];


  Urine({
    required this.blood,
    required this.billrubin,
    required this.urobillnogen,
    required this.ketones,
    required this.protein,
    required this.nitrite,
    required this.glucose,
    required this.pH,
    required this.sG,
    required this.leucoytes,
    required this.vitamin,
    required this.urineList,
    required this.date,
    this.code,
    this.message,
  });

  @override
  String toString() {
    return 'Urine{blood: $blood, billrubin: $billrubin, urobillnogen: $urobillnogen,'
        ' ketones: $ketones, protein: $protein, nitrite: $nitrite, glucose: $glucose, pH: $pH, sG: $sG, leucoytes: $leucoytes, vitamin: $vitamin}';
  }

  factory Urine.fromValue(String sb){
    return Urine(
        blood: parsingResultBuffer('#A01', sb),
        billrubin: parsingResultBuffer('#A02', sb),
        urobillnogen: parsingResultBuffer('#A03', sb),
        ketones: parsingResultBuffer('#A04', sb),
        protein: parsingResultBuffer('#A05', sb),
        nitrite: parsingResultBuffer('#A06', sb),
        glucose: parsingResultBuffer('#A07', sb),
        pH: parsingResultBuffer('#A08', sb),
        sG: parsingResultBuffer('#A09', sb),
        leucoytes: parsingResultBuffer('#A10', sb),
        vitamin: parsingResultBuffer('#A11', sb),
        date: DateFormat('yyyyMMddHHmmss').format(DateTime.now()).toString(),
        urineList: [],
    );
  }

  static String parsingResultBuffer(String baseStr, String sb) {
    int idx = sb.replaceAll('\n', '').indexOf(baseStr);
    String result = sb.substring(idx + 5, (idx + 6));
    return result;
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
    urineList.add(sG);

    leucoytes  = parsingResultBuffer('#A10', sb);
    urineList.add(leucoytes);

    vitamin = parsingResultBuffer('#A11', sb);
    urineList.add(vitamin);

    date = DateFormat('yyyyMMddHHmmss').format(DateTime.now()).toString();
  }
}
import '../common.dart';

class TextFormat {

  static defaultDateFormat(String dateInput) {
    if (dateInput == '') {
      return '';
    }
    String dateString = dateInput.replaceAll(RegExp(r'[^0-9]'), '');
    DateTime date = DateTime.parse(dateString);

    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    return formattedDate;
  }

  /// health chart x축 날짜 format(MM/dd)
  static String setXAxisDateTime(int duration) {
    final now = DateTime.now();
    final returnDate = now.subtract(Duration(days: duration));

    return DateFormat('MM/dd').format(returnDate);
  }


  /// 차트 X축 날짜 포멧 substring
  static String setGroupDateTime(String dateTime) {
    int year     = int.parse(dateTime.substring(0, 4));
    int month    = int.parse(dateTime.substring(4, 6));
    int day      = int.parse(dateTime.substring(6, 8));

    final mDateTime = DateTime(year, month, day, 0, 0, 0, 0 ,0);

    return DateFormat('yy\nMM\ndd').format(mDateTime);
  }




  /// ####-##-## 포멧에 맞춰 변경
  static String stringFormatDate(String originalDateString) {
    if (originalDateString.length == 8) {
      // 연도, 월, 일로 나누기
      String year = originalDateString.substring(0, 4);
      String month = originalDateString.substring(4, 6);
      String day = originalDateString.substring(6);

      // "-" 추가
      return '$year-$month-$day';
    } else {
      // 유효하지 않은 날짜 문자열 처리
      return '0000-00-00';
    }
  }

  ///MetrologyInspection 계측 검사 결과 불필요한 String 자르기
  static String removeAfterSpace(String input) {
    // 문자열에서 첫 번째 띄워쓰기의 인덱스를 찾습니다.
    String replaceText = input.replaceAll('(', ' ');
    int spaceIndex = replaceText.indexOf(' ');

    // 띄워쓰기 이후의 부분을 제거하고 결과를 반환합니다.
    return spaceIndex != -1 ? input.substring(0, spaceIndex) : replaceText;
  }



  /// SeriesChart x축 날짜 텍스트 변환 후 출력
  static seriesChartXAxisDateFormat(String dateInput) {
    if (dateInput == '') {
      return '';
    }
    // 날짜 부분 추출
    String dateString = dateInput.replaceAll(RegExp(r'[^0-9]'), '');

    // DateTime 객체로 변환
    DateTime date = DateTime.parse(dateString);

    // 원하는 형식으로 날짜 포맷
    String formattedDate = DateFormat('yyyy.MM').format(date);

    return formattedDate;
  }

  static convertTimestamp(String flutterTimestamp) {
    return flutterTimestamp
        .replaceAll(RegExp(r'[^\d]'), '')
        .replaceAllMapped(RegExp(r'(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})'),
            (Match m) => '${m[1]}년${m[2]}월${m[3]}일 / ${m[4]}시${m[5]}분');
  }

}
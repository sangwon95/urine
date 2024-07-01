
import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';

import '../../layers/model/enum/ai_analysis_results.dart';
import '../../layers/model/enum/blood_data_type.dart';

/// 분기 계산 클래스
class Branch {

  /// AI 분석 결과에 맞는 텍스트 내용으로 변환
  static AiAnalysisResults aiAnalysisToContent(String resultText) {
    String result = resultText.split(',')[0];

    if(result == '만성신장질환'){
      return AiAnalysisResults.kidneys;
    } else if(result == '방광염'){
      return AiAnalysisResults.bladder;
    } else if(result == '췌장염'){
      return AiAnalysisResults.pancreas;
    } else if(result == '빈혈'){
      return AiAnalysisResults.anemia;
    } else if(result == '당뇨'){
      return AiAnalysisResults.diabetes;
    } else if(result == '신장염'){
      return AiAnalysisResults.nephritis;
    } else {
      return AiAnalysisResults.health;
    }
  }

  static resultStatusToText(List<String> fastestResult, int index){
    if(index == 10 || index == 8 || index == 7){
      switch(fastestResult[index]){
        case '0' : return '-';
        case '1' : return '+';
        case '2' : return '++';
        case '3' : return '+++';
        case '4' : return '++++';
        case '5' : return '+++++';
        default  : return '-';
      }
    }
    else {
      switch(fastestResult[index]){
        case '0' : return '안심';
        case '1' : return '관심';
        case '2' : return '주위';
        case '3' : return '위험';
        case '4' : return '심각';
        case '5' : return '심각';
        default  : return '안심';
      }
    }
  }


  static resultStatusToImageStr(List<String> fastestResult, int index){
    if(index == 10 || index == 8 || index == 7){
      switch(fastestResult[index]){
        case '0' : return '${Texts.imagePath}/urine/result/plus_1.png';
        case '1' : return '${Texts.imagePath}/urine/result/plus_2.png';
        case '2' : return '${Texts.imagePath}/urine/result/plus_3.png';
        case '3' : return '${Texts.imagePath}/urine/result/plus_4.png';
        case '4' : return '${Texts.imagePath}/urine/result/plus_4.png';
        case '5' : return '${Texts.imagePath}/urine/result/plus_4.png';
        default  : return '${Texts.imagePath}/urine/result/plus_1.png';
      }
    }
    else {
      switch(fastestResult[index]){
        case '0' : return '${Texts.imagePath}/urine/result/step_0.png';
        case '1' : return '${Texts.imagePath}/urine/result/step_1.png';
        case '2' : return '${Texts.imagePath}/urine/result/step_2.png';
        case '3' : return '${Texts.imagePath}/urine/result/step_3.png';
        case '4' : return '${Texts.imagePath}/urine/result/step_4.png';
        case '5' : return '${Texts.imagePath}/urine/result/step_4.png';
        default  : return '${Texts.imagePath}/urine/result/step_0.png';
      }
    }
  }


  static resultStatusToColor(List<String> fastestResult, int index) {
    if (index == 10 || index == 8 || index == 7) { // ph, 비중, 비타민 예외
      return AppColors.urineExceptColor;
    }
    else {
      switch (fastestResult[index]) {
        case '0':
          return AppColors.resultColor1;
        case '1':
          return AppColors.resultColor2;
        case '2':
          return AppColors.resultColor3;
        case '3':
          return AppColors.resultColor4;
        case '4':
          return AppColors.resultColor5;
        case '5':
          return AppColors.resultColor6;
        default:
          return AppColors.resultColor1;
      }
    }
  }

  static resultStatusToPercent(List<String> statusResult, int index) {
      switch (statusResult[index]) {
        case '0':
          return 0.1;
        case '1':
          return 0.3;
        case '2':
          return 0.4;
        case '3':
          return 0.6;
        case '4':
          return 1.0;
        case '5':
          return 1.0;
        default:
          return 0.1;
      }
  }
  static urineNameToUrineDataType(String urineName) {
    switch (urineName) {
      case '잠혈':
        return 'DT01';
      case '빌리루빈':
        return 'DT02';
      case '우로빌리노겐':
        return 'DT03';
      case '케톤체':
        return 'DT04';
      case '단백질':
        return 'DT05';
      case '아질산염':
        return 'DT06';
        case '포도당':
        return 'DT07';
        case '산성도':
        return 'DT08';
        case '비중':
        return 'DT09';
      case '백혈구':
        return 'DT10';
      case '비타민':
        return 'DT11';
      default:
        return 'DT00';
    }
  }

  static Color calculateBloodStatusColor(BloodDataType type, double value,
      {required Color badColor, required Color goodColor}) {
    switch (type) {
      case BloodDataType.hemoglobin:
        //TODO: gender 부분 수정해줘야됨 (type.label임시)
        if (type.label == 'M') {
          if (13.0 <= value && 16.5 >= value) {
            return goodColor;
          } else {
            return badColor;
          }
        } else {
          // 여자
          if (12.0 <= value && 15.5 >= value) {
            return goodColor;
          } else {
            return badColor;
          }
        }
      case BloodDataType.fastingBloodSugar:
        if (100 > value) {
          return goodColor;
        } else {
          return badColor;
        }
      case BloodDataType.totalCholesterol:
        if (200 > value) {
          return goodColor;
        } else {
          return badColor;
        }
      case BloodDataType.highDensityCholesterol:
        if (60 < value) {
          return goodColor;
        } else {
          return badColor;
        }
      case BloodDataType.neutralFat:
        if (150 > value) {
          return goodColor;
        } else {
          return badColor;
        }
      case BloodDataType.lowDensityCholesterol:
        if (130 > value) {
          return goodColor;
        } else {
          return badColor;
        }
      case BloodDataType.serumCreatinine:
        if (1.5 >= value) {
          return goodColor;
        } else {
          return badColor;
        }
      case BloodDataType.shinsugularFiltrationRate:
        if (60 <= value) {
          return goodColor;
        } else {
          return badColor;
        }
      case BloodDataType.astSgot:
        if (40 >= value) {
          return goodColor;
        } else {
          return badColor;
        }
      case BloodDataType.altSGpt:
        if (35 >= value) {
          return goodColor;
        } else {
          return badColor;
        }
      case BloodDataType.gammaGtp:
        //TODO: (type.label) 임시
        if (type.label == 'M') {
          if (63.0 >= value) {
            return goodColor;
          } else {
            return badColor;
          }
        } else {
          // 여자
          if (35.0 >= value) {
            return goodColor;
          } else {
            return badColor;
          }
        }
    }
  }

  static Color getBloodPressureColor(String resultText, String resultLabel) {
    Color borderColor = Colors.blueAccent;

    if(resultLabel == '청력(좌/우)') {
      if(resultText.contains('비정상') || resultText.contains('비 정상')) {
        borderColor = Colors.red;
      }
    } else if(resultLabel == '혈압') {

      List<int> values = resultText
          .split('/')
          .map((value) => int.tryParse(value.trim()) ?? 0)
          .toList();

      // 추출한 혈압 값이 유효한지 확인
      if (values.length == 2) {
        int systolic = values[0];
        int diastolic = values[1];

        // 혈압이 정상 범위인 경우 파랑색 반환
        if (systolic <= 120 && diastolic <= 80) {
          return borderColor;
        }
        // 그 외의 경우 빨간색을 반환
        else {
          return Colors.red;
        }
      } else {
        // 혈압 값이 올바르게 구성되지 않은 경우 파랑색 반환
        return borderColor;
      }
    }
    return borderColor;
  }


  /// 차트 x축 갯수에 따른 bar차트 폭 비율 리턴
  static double calculateChartWidthRatio(int length) {
    switch (length) {
      case 1:
        return 0.2;
      case 2:
        return 0.2;
      case 3:
        return 0.25;
      case 4:
        return 0.3;
      default:
        return 0.35;
    }
  }


  /// 피 검사 기준 수치 반환
  static double bloodTestStandardValue(BloodDataType type) {
    switch (type) {
      case BloodDataType.hemoglobin:
        return 0.0;
      case BloodDataType.fastingBloodSugar:
        return 100.0;
      case BloodDataType.totalCholesterol:
        return 200.0;
      case BloodDataType.highDensityCholesterol:
        return 60.0;
      case BloodDataType.neutralFat:
        return 150.0;
      case BloodDataType.lowDensityCholesterol:
        return 130.0;
      case BloodDataType.serumCreatinine:
        return 1.5;
      case BloodDataType.shinsugularFiltrationRate:
        return 60.0;
      case BloodDataType.astSgot:
        return 40.0;
      case BloodDataType.altSGpt:
        return 35.0;
      case BloodDataType.gammaGtp:
        //TODO: 임시
       // if (Authorization().gender == 'M') {
          return 63.0;
       // } else {
          // 여자
          return 35.0;
       // }
    }
  }


  /// 수면, 걷기 달성률 계산
  static calculateAchievementRate(int value, int target) {
    if (target == 0 || value == 0) {
      return 0.0;
    }

    if (value > target) {
      return 100.0;
    }

    // 달성률 계산
    double rate = (value / target) * 100;
    return rate;
  }


  /// 예약 현황에서 예약취소버튼 활성화/비활성화
  static bool possibleToCancel(String status) {
    if (status == '요청' || status == '확인') {
      return true;
    } else {
      return false;
    }
  }
}
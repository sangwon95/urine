

import 'package:urine/common/common.dart';

class LifeLogUrineBranch {
  /// urine 상태값으로 이미지 경로 반환
  static resultStatusToImageStr(String dataDesc, String value) {
    if (dataDesc == '비타민' || dataDesc == '비중' || dataDesc == '산성도') {
      switch (value) {
        case '0':
          return '${AppStrings.imagePath}/tab/daily/plus_1.png';
        case '1':
          return '${AppStrings.imagePath}/tab/daily/plus_2.png';
        case '2':
          return '${AppStrings.imagePath}/tab/daily/plus_3.png';
        case '3':
          return '${AppStrings.imagePath}/tab/daily/plus_4.png';
        case '4':
          return '${AppStrings.imagePath}/tab/daily/plus_4.png';
        case '5':
          return '${AppStrings.imagePath}/tab/daily/plus_4.png';
        default:
          return '${AppStrings.imagePath}/tab/daily/plus_1.png';
      }
    } else {
      switch (value) {
        case '0':
          return '${AppStrings.imagePath}/tab/daily/step_0.png';
        case '1':
          return '${AppStrings.imagePath}/tab/daily/step_1.png';
        case '2':
          return '${AppStrings.imagePath}/tab/daily/step_2.png';
        case '3':
          return '${AppStrings.imagePath}/tab/daily/step_3.png';
        case '4':
          return '${AppStrings.imagePath}/tab/daily/step_4.png';
        case '5':
          return '${AppStrings.imagePath}/tab/daily/step_4.png';
        default:
          return '${AppStrings.imagePath}/tab/daily/step_0.png';
      }
    }
  }

  static resultStatusToText(String dataDesc, String value) {
    if (dataDesc == '비타민' || dataDesc == '비중' || dataDesc == '산성도') {
      switch (value) {
        case '0':
          return '낮음';
        case '1':
          return '낮음';
        case '2':
          return '보통';
        case '3':
          return '높음';
        case '4':
          return '다소 높음';
        case '5':
          return '다소 높음';
        default:
          return '미 측정';
      }
    } else {
      switch (value) {
        case '0':
          return '안심';
        case '1':
          return '관심';
        case '2':
          return '주위';
        case '3':
          return '위험';
        case '4':
          return '심각';
        case '5':
          return '심각';
        default:
          return '미 측정';
      }
    }
  }

  /// 소변분석 결과에 따른 색상 설정
  static  resultStatusToTextColor(String dataDesc, String value) {
    if (dataDesc == '비타민' || dataDesc == '비중' || dataDesc == '산성도') {
      return AppColors.urineExceptColor;
    } else {
      switch (value) {
        case '0':
          return AppColors.urineStageColor1;
        case '1':
          return AppColors.urineStageColor2;
        case '2':
          return AppColors.urineStageColor3;
        case '3':
          return AppColors.urineStageColor4;
        case '4':
          return AppColors.urineStageColor5;
        case '5':
          return AppColors.urineStageColor5;
        default:
          return AppColors.urineStageColor1;
      }
    }
  }
}
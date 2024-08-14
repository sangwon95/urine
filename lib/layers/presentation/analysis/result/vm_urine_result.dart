

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';
import 'package:urine/common/dart/extension/datetime_extension.dart';
import 'package:urine/layers/domain/usecase/urine/urine_ai_analysis_usecase.dart';
import 'package:urine/layers/model/authorization.dart';

import '../../../../../../common/util/branch.dart';
import '../../../../../../common/util/text_format.dart';
import '../../../../../../main.dart';
import '../../../domain/usecase/urine/urine_chart_usecase.dart';
import '../../../entity/urine_chart_dto.dart';
import '../../../model/vo_chart.dart';
import '../../ingredient/v_ingredient_result.dart';
import '../../widget/w_custom_dialog.dart';
import 'd_ai_analysis.dart';

class UrineResultViewModel extends ChangeNotifier {

  BuildContext context;

  UrineResultViewModel(this.context);


  /// 성분 분석: 측정된 소변데이터로
  /// 한밭대학교에서 제공해주는 API 연동
  fetchAiAnalyze(List<String> statusList) async  {
    showAiAnalysisDialog();

    Future.delayed(2.seconds, () async {
      try {
        Map<String, dynamic> toMap = {
          "blood": statusList[0] == '0'|| statusList[0] == '5' ? '-' : '${statusList[0]}+',
          "bilirubin": statusList[1] == '0' || statusList[1] == '5'? '-' : '${statusList[1]}+',
          "urobilinogen": statusList[2] == '0' || statusList[2] == '5'? '-' : '${statusList[2]}+',
          "ketones": statusList[3] == '0' || statusList[3] == '5'? '-' : '${statusList[3]}+',
          "protein": statusList[4] == '0' || statusList[4] == '6'? '-' : '${statusList[4]}+',
          "nitrite": statusList[5] == '1' ? '1+' : '-',
          "glucose": statusList[6] == '0' || statusList[6] == '6'? '-' : '${statusList[6]}+',
          "leukocytes": statusList[9] == '0' || statusList[9] == '5' ? '-' : '${statusList[9]}+',
        };

          String? result = await UrineAiAnalysisUseCase().execute(toMap);
        logger.d(toMap);
          if (result != null &&(result != 'ERROR' || result != 'unknown')) {
            Nav.doPop(context); // 성분분석 진행 알림 다이얼로그 pop
            Nav.doPush(context, IngredientResultView(resultText: result, statusList: statusList));
          } else {
            aiDialog(context, '정상적으로 처리 되지 않았습니다.\n다시 시도 해주세요.');
          }

      } catch (e) {
        logger.i('성분분석 : $e');
        aiDialog(context, '정상적으로 처리 되지 않았습니다.\n다시 시도 해주세요.');
      }
    });
  }


  /// AI 성분 분석 시작시 보여주는 다이얼로그
  /// 분석 시작시 다른 이벤트 못받게 설정함
  showAiAnalysisDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AiAnalysisAlertDialog();
      },
    );
  }


  /// ai 성분분석 다이얼로그
  aiDialog(BuildContext context, String message){
    Nav.doPop(context); // 성분분석 진행 알림 다이얼로그 pop
    CustomDialog.showMyDialog(
      title: '성분 분석',
      content: message,
      mainContext: context,
    );
  }

}
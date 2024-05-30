

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

  UrineResultViewModel(this.context){
    fetchUrineChartDio();
  }

  final String _selectedUrineName = '포도당';

  final String _rangeStartDate = DateTime.now().subtract(90.days).formattedClean;
  final String _rangeEndDate = DateTime.now().formattedClean;

  /// ChartData(x축, y축) List
  List<ChartData> _chartData = [];

  List<ChartData> get chartData => _chartData;
  String get selectedUrineName => _selectedUrineName;


  /// 차트 데이터 조회
  Future<void> fetchUrineChartDio() async {
    final toMap = {
      'userID': Authorization().userID,
      'searchStartDate': _rangeStartDate,
      'searchEndDate': _rangeEndDate,
    };

    UrineChartDTO? urineChartDTO = await UrineChartCase().execute(toMap);
    if(urineChartDTO?.status.code == '200'){
      chartData.clear();

      // 서버에서 불러온데이터를 사용자가 선택한 [_selectedUrineName]를 통해
      // 같은 dataType으로만 골라 x,y축 데이터를 만들어 _chartData에 추가한다.
      for(var value in urineChartDTO!.data)
      {
        if(value.dataType == Branch.urineNameToUrineDataType(_selectedUrineName))
        {
          if (!_chartData.any((element) => element.x
              .toString()
              .contains(TextFormat.setGroupDateTime(value.datetime)))) {

            if(_chartData.length < 7){
              _chartData.add(ChartData(
                  x: TextFormat.setGroupDateTime(value.datetime),
                  y: int.parse(value.status)));
            }
          }
        }

        if(_chartData.length == 7) break;
      }
    } else if(urineChartDTO?.status.code =='ERR_MS_4003'){
      print('해당 날짜에 검사한 이력이 없습니다.');
    }
    notifyListeners();
  }


  /// 성분 분석: 측정된 소변데이터로
  /// 한밭대학교에서 제공해주는 API 연동
  fetchAiAnalyze(List<String> statusList) async  {
    showAiAnalysisDialog();

    Future.delayed(2.seconds, () async {
      try {
        Map<String, dynamic> toMap = {
            "blood": statusList[0] == '0' ? '-' : '${statusList[0]}+',
            "bilirubin": statusList[1] == '0' ? '-' : '${statusList[1]}+',
            "urobilinogen": statusList[2] == '0' ? '-' : '${statusList[2]}+',
            "ketones": statusList[3] == '0' ? '-' : '${statusList[3]}+',
            "protein": statusList[4] == '0' ? '-' : '${statusList[4]}+',
            "nitrite": statusList[5] == '0' ? '-' : '${statusList[5]}+',
            "glucose": statusList[6] == '0' ? '-' : '${statusList[6]}+',
            "leukocytes": statusList[9] == '0' ? '-' : '${statusList[9]}+',
          };

          String? result = await UrineAiAnalysisUseCase().execute(toMap);
          if (result != null &&(result != 'ERROR' || result != 'unknown')) {
            Nav.doPop(context); // 성분분석 진행 알림 다이얼로그 pop
            Nav.doPush(context, IngredientResultView(resultText: result));
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
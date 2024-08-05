
import 'package:flutter/material.dart';
import 'package:urine/common/dart/extension/datetime_extension.dart';
import 'package:urine/common/util/branch.dart';
import 'package:urine/common/util/snackbar_utils.dart';
import 'package:urine/layers/model/authorization.dart';

import '../../../../../common/common.dart';
import '../../../../../common/util/text_format.dart';
import '../../../../../main.dart';
import '../../domain/usecase/urine/urine_chart_usecase.dart';
import '../../entity/urine_chart_dto.dart';
import '../../model/vo_chart.dart';
import 'd_date_range.dart';

class AnalysisTrendViewModel extends ChangeNotifier {

  /// 조회할 검사 항목 요소
  String _selectedUrineName = '잠혈';

  /// 서버 조회용 [DateTime] 데이터 포멧
  String _rangeStartDate = DateTime.now().formattedClean;
  String _rangeEndDate = DateTime.now().formattedClean;

  /// 화면에 보여줄 시작날짜, 종료날짜
  String _uiStartDate = DateTime.now().formattedDateTime;
  String _uiEndDate = DateTime.now().formattedDateTime;

  /// date range toggle init index
  int _toggleIndex = 0;

  /// ChartData(x축, y축) List
  final List<ChartData> _chartData = [];

  /// x축 데이터 길이에 따라 width 추가 길이 설정
  double _addWidthChartLength = 0;

  String get selectedUrineName => _selectedUrineName;
  String get uiStartDate => _uiStartDate;
  String get uiEndDate => _uiEndDate;
  int get toggleIndex => _toggleIndex;
  List<ChartData> get chartData => _chartData;
  double get addWidthChartLength => _addWidthChartLength;

  set selectedUrineName(String? selected) {
    _selectedUrineName = selected ?? '잠혈';
    notifyListeners();
  }


  /// 차트 데이터 조회
  Future<void> fetchUrineChartDio(context) async {
    final toMap = {
      'userID': Authorization().userID,
      'searchStartDate': _rangeStartDate,
      'searchEndDate': _rangeEndDate,
    };
    logger.d(toMap);

    UrineChartDTO? urineChartDTO = await UrineChartCase().execute(toMap);
    if(urineChartDTO?.status.code == '200'){
      chartData.clear();
      _addWidthChartLength = 0.0;

      // 서버에서 불러온데이터를 사용자가 선택한 [_selectedUrineName]를 통해
      // 같은 dataType으로만 골라 x,y축 데이터를 만들어 _chartData에 추가한다.
      for(var value in urineChartDTO!.data)
      {
        if(value.dataType == Branch.urineLabelToUrineDataType(_selectedUrineName))
        {
          if (!_chartData.any((element) => element.x
              .toString()
              .contains(TextFormat.setGroupDateTime(value.datetime)))) {
            _chartData.add(ChartData(
                x: TextFormat.setGroupDateTime(value.datetime),
                y: int.parse(value.status)));
          }
        }
      }

      // 측정한 날짜가 4일 이상이면 가로로 스크롤 할 수 있게
      // [_addWidthChartLength]를 늘려준다.
      if(chartData.length > 4){
        _addWidthChartLength = 30.0 * chartData.length;
      }
    } else if(urineChartDTO?.status.code =='ERR_MS_4003'){
      print('해당 날짜에 검사한 이력이 없습니다.');
    }

    SnackBarUtils.showCenterSnackBar(context, '좌우로 이동 가능합니다');
    notifyListeners();
  }


  /// 날짜 범위 피커
  showDateRangeDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DateRangeDialog(
          onSubmit: (rangeStart, rangeEnd) {
            print('${rangeStart?.formattedClean} / ${rangeEnd?.formattedClean}');
            // 날짜 하루만 선택했을 경우
            if (rangeEnd == null) {
              // 서버용 날짜
              _rangeStartDate = rangeStart!.formattedClean;
              _rangeEndDate = rangeStart.formattedClean;
              // ui용 날짜
              _uiStartDate = rangeStart.formattedDateTime;
              _uiEndDate = rangeStart.formattedDateTime;
            } else {
              _rangeStartDate = rangeStart!.formattedClean;
              _rangeEndDate = rangeEnd.formattedClean;
              _uiStartDate = rangeStart.formattedDateTime;
              _uiEndDate = rangeEnd.formattedDateTime;
            }
            notifyListeners();
          },
        );
      },
    );
  }


  /// onToggle으로부터 받은 index를 Duration값으로 변환3
  int indexToDurationDay(int index){
    switch(index){
      case 0: return 0;
      case 1: return 7;
      case 2: return 30;
      case 3: return 180;
      default: return 0;
    }
  }


  /// 날짜 간편 조회 토글
  onToggle(int? index) {
    if (index == null) return;

    logger.d('onToggle: $index');
    _toggleIndex = index;
    final DateTime now = DateTime.now();
    final DateTime rangeStart =
        now.subtract(Duration(days: indexToDurationDay(index)));
    final DateTime rangeEnd = now;

    // Set server dates
    _rangeStartDate = rangeStart.formattedClean;
    _rangeEndDate = rangeEnd.formattedClean;

    // Set UI dates
    _uiStartDate = rangeStart.formattedDateTime;
    _uiEndDate = rangeEnd.formattedDateTime;

    // Notify listeners
    notifyListeners();
  }
}

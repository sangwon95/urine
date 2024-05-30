import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:urine/common/common.dart';
import 'package:urine/common/constant/app_dimensions.dart';


class UrinePieChart extends StatefulWidget {
  /// 소변 검사 결과 파이 데이터
  final List<PieChartData> pieData;

  const UrinePieChart({
    Key? key,
    required this.pieData,
  }) : super(key: key);

  @override
  State<UrinePieChart> createState() => _UrinePieChartState();
}

class _UrinePieChartState extends State<UrinePieChart> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {

    // data = [
    //   _ChartData('잠혈\n${Branch.resultStatusToText(widget.statusList, 0)}', 10, AppColors.urineStageColor1),
    //   _ChartData('빌리루빈\n${Branch.resultStatusToText(widget.statusList, 1)}', 10, AppColors.urineStageColor1),
    //   _ChartData('우로빌리노겐\n${Branch.resultStatusToText(widget.statusList, 2)}', 10, AppColors.urineStageColor1),
    //   _ChartData('케톤체\n${Branch.resultStatusToText(widget.statusList, 3)}', 10, AppColors.urineStageColor1),
    //   _ChartData('단백질\n${Branch.resultStatusToText(widget.statusList, 4)}', 10, AppColors.urineStageColor2),
    //   _ChartData('아질산염\n${Branch.resultStatusToText(widget.statusList, 5)}', 10, AppColors.urineStageColor2),
    //   _ChartData('포도당\n${Branch.resultStatusToText(widget.statusList, 6)}', 10, AppColors.urineStageColor3),
    //   _ChartData('PH\n${Branch.resultStatusToText(widget.statusList, 7)}', 10, AppColors.urineStageColor4),
    //   _ChartData('비중\n${Branch.resultStatusToText(widget.statusList, 8)}', 10, AppColors.urineStageColor2),
    //   _ChartData('백혈구\n${Branch.resultStatusToText(widget.statusList, 9)}', 10, AppColors.urineStageColor1),
    //   _ChartData('비타민\n${Branch.resultStatusToText(widget.statusList, 10)}', 10, AppColors.urineStageColor1),
    // ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
        tooltipBehavior: _tooltip,
        series: <CircularSeries<PieChartData, String>>[
          DoughnutSeries<PieChartData, String>(
              dataSource: widget.pieData,
              pointColorMapper:(PieChartData data, _) => data.color,
              dataLabelMapper:(PieChartData data, _) => data.x,
              dataLabelSettings: const DataLabelSettings(
                  isVisible: true, labelPosition: ChartDataLabelPosition.outside,
                textStyle: TextStyle(color: Colors.black, fontSize: AppDim.fontSizeXSmall, fontWeight: FontWeight.bold)
              ),
              xValueMapper: (PieChartData data, _) => data.x,
              yValueMapper: (PieChartData data, _) => data.y,
              innerRadius: '10%',
              radius: '60%',
              explodeAll: true,
              explode: true,
              strokeColor: Colors.white,
              name: 'Urine',)
        ]);
  }
}

class PieChartData {
  PieChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
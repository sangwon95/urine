import 'package:flutter/material.dart';

import '../../model/vo_chart.dart';
import '../widget/line_chart.dart';

class HorizontalUrineChart extends StatelessWidget {
  final List<ChartData> chartData;
  final double addWidthChartLength;

  const HorizontalUrineChart({
    super.key,
    required this.chartData,
    required this.addWidthChartLength,
  });

  double get chartHeight => 250;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: width - 45 + addWidthChartLength,
        alignment: Alignment.topCenter,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 25, 0),
            child: SizedBox(
              height: chartHeight,
              width: width - 45 + addWidthChartLength,
              child: BarChart().buildColumnSeriesChart(chartData: chartData),
            )),
      ),
    );
  }
}

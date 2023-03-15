import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:urine/utils/color.dart';

import '../model/chart.dart';
import 'package:intl/intl.dart';


/// SfCartesian ColumnSeries Chart
class BarChart{
  late List<ChartData> chartData;

  /// Returns the cartesian stacked line chart.
  SfCartesianChart buildColumnSeriesChart({required List<ChartData> chartData}) {

    this.chartData = chartData;

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(isVisible: false),
      primaryXAxis: CategoryAxis(
        labelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        majorGridLines: const MajorGridLines(width: 1),
        labelRotation: 0, //0
      ),

      primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 5,
          axisLine: const AxisLine(width: 1),
          labelFormat: '{value}',
          labelStyle: TextStyle(fontSize: 12),
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getColumnSeries(),
      trackballBehavior: TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap),
    );
  }

  /// Returns the list of chart seris which need to render
  /// on the stacked line chart.
  List<ChartSeries<ChartData, String>> _getColumnSeries() {
    return <ChartSeries<ChartData, String>> [
      StackedLineSeries<ChartData, String>(
        dataSource: chartData,
        xValueMapper: (ChartData sales, _) => sales.x.toString(),
        yValueMapper: (ChartData sales, _) => sales.y.toInt(),
        dataLabelMapper: (ChartData sales, _) => (sales.y.toString()),
        color: mainColor,
        width: 2.0,
        dataLabelSettings:  DataLabelSettings(
            labelAlignment: ChartDataLabelAlignment.outer,
            isVisible: true,
            textStyle: TextStyle(color: mainColor, fontWeight: FontWeight.w600, fontSize: 15)),
         markerSettings: const MarkerSettings(
             borderWidth: 3,
             isVisible: true,
             borderColor: Color(0xff6da8f6)
         )
      ),

    ];
  }


  /// Returns the cartesian stacked line chart.
  SfCartesianChart buildColumnSeriesMiniChart({required List<ChartData> chartData}) {

    this.chartData = chartData;

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(isVisible: false),

      /// X축 설정
      primaryXAxis: CategoryAxis(
        labelStyle: TextStyle(fontSize: 0, fontWeight: FontWeight.bold, color: Colors.white),
        axisLine: const AxisLine(width: 0),
        majorGridLines: const MajorGridLines(width: 0),
        labelRotation: 0, //0
      ),

      /// Y축 설정
      primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 5,
          axisLine: const AxisLine(width: 0),
          majorGridLines: const MajorGridLines(dashArray: <double>[5,5], width: 1),
          //labelFormat: '{value}',
          //labelStyle: TextStyle(fontSize: 12),
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getColumnSeriesMini(),
      trackballBehavior: TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap),
    );
  }

  /// Returns the list of chart seris which need to render
  /// on the stacked line chart.
  List<ChartSeries<ChartData, String>> _getColumnSeriesMini() {
    return <ChartSeries<ChartData, String>> [
      StackedLineSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData sales, _) => sales.x.toString(),
          yValueMapper: (ChartData sales, _) => sales.y.toInt(),
          dataLabelMapper: (ChartData sales, _) => (sales.y.toString()),
          color: mainColor,
          width: 2.5,
          dataLabelSettings:  DataLabelSettings(
              isVisible: false,
          ),
          markerSettings: const MarkerSettings(
              borderWidth: 3,
              isVisible: true,
              borderColor: Color(0xff265ed7)
          )
      ),

    ];
  }
}



//
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// import '../model/chart.dart';
//
// /// 발열측정 결과
// /// SfCartesian Stacked Line Chart
// class ResultLineChart{
//   List<Result> resultDataFever = [];
//   // final TrackballBehavior _trackballBehavior = TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap);
//
//
//   /// Returns the cartesian stacked line chart.
//   SfCartesianChart buildStackedLineChart(List<Result> resultDataFever) {
//     this.resultDataFever = resultDataFever;
//     return SfCartesianChart(
//       plotAreaBorderWidth: 0,
//       legend: Legend(isVisible: false),
//       primaryXAxis: CategoryAxis(
//         labelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
//         majorGridLines: const MajorGridLines(width: 0),
//         labelRotation: 0, //0
//       ),
//
//       primaryYAxis: NumericAxis(
//           maximum: 40.0,
//           minimum: 34.0,
//           axisLine: const AxisLine(width: 0),
//           labelFormat: r'{value}',
//           labelStyle: TextStyle(fontSize: 12),
//           majorTickLines: const MajorTickLines(size: 0)),
//       series: _getStackedLineSeries(),
//       trackballBehavior: TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap),
//     );
//   }
//
//    /// Returns the list of chart seris which need to render
//    /// on the stacked line chart.
//    List<StackedLineSeries<ChartData, String>> _getStackedLineSeries() {
//      final List<ChartData> chartData = <ChartData>[
//
//        ChartData(
//            x: dateParsing(resultDataFever[0].reg_date.toString()),
//            y: double.parse(double.parse(resultDataFever[0].temp.toString()).toStringAsFixed(1)),
//         ),
//
//      ];
//      return <StackedLineSeries<ChartData, String>>[
//        StackedLineSeries<ChartData, String>(
//            dataSource: chartData,
//            xValueMapper: (ChartData sales, _) => sales.x.toString(),
//            yValueMapper: (ChartData sales, _) => sales.y,
//            dataLabelMapper: (ChartData sales, _) => sales.y.toString(),
//            color: mainColor,
//            dataLabelSettings:  DataLabelSettings(isVisible: true, textStyle: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 10)),
//            markerSettings: const MarkerSettings(isVisible: true, borderColor: Color(0xFFf6c86d))),
//
//      ];
//    }
//
//    /// 날짜 ' '기준으로 자르기
//    String  dateParsing(String value) {
//      int targetNum = value.indexOf(' ');
//
//      String date = value.substring(0, targetNum);
//      String time = value.substring(targetNum, value.length);
//
//      String sum = '$date\n$time';
//      return sum;
//    }
//
// }

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:intl/intl.dart';
import 'package:urine/common/common.dart';

import '../../model/vo_chart.dart';


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
        labelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
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
      trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
      ),
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
        color: AppColors.primaryColor,
        width: 2.0,
        dataLabelSettings:  DataLabelSettings(
            labelAlignment: ChartDataLabelAlignment.outer,
            isVisible: true,
            textStyle: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600, fontSize: 15)),
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
        labelStyle: const TextStyle(fontSize: 0, fontWeight: FontWeight.bold, color: Colors.white),
        axisLine: const AxisLine(width: 0),
        majorGridLines: const MajorGridLines(width: 0),
        labelRotation: 0, //0
      ),

      /// Y축 설정
      primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 7,
          axisLine: const AxisLine(width: 0),
          majorGridLines: const MajorGridLines(width: 1, color: Colors.white),
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
          color: AppColors.primaryColor,
          width: 1.5,
          dataLabelSettings:  const DataLabelSettings(
              isVisible: false,
          ),

          markerSettings: MarkerSettings(
              shape: DataMarkerType.circle,
              borderWidth: 3,
              isVisible: true,
              color: AppColors.white,
              borderColor: AppColors.primaryColor
          )
      ),

    ];
  }
}

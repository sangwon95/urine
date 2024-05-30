
import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/model/vo_chart.dart';
import 'package:urine/layers/presentation/widget/frame_container.dart';
import 'package:urine/layers/presentation/widget/line_chart.dart';

import '../../widget/style_text.dart';


/// 과거 7개의 검사 결과 추이
class ResultSummaryChart extends StatelessWidget {
  final List<ChartData> chartData;

  const ResultSummaryChart({
    super.key,
    required this.chartData,
  });

  @override
  Widget build(BuildContext context) {
    return FrameContainer(
      backgroundColor: AppColors.greyBoxBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
            [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(AppConstants.radius),
                    border: Border.all(color: AppColors.brightGrey, width: AppConstants.borderLightWidth)
                ),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                  child: StyleText(
                      text: '포도당',
                      color: AppColors.blackTextColor,
                      fontWeight: AppDim.weight500,
                      maxLinesCount: 1,
                      size: AppDim.fontSizeSmall,
                      align: TextAlign.start
                  ),
                ),
              ),


              Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(AppConstants.radius),
                    border: Border.all(color: AppColors.brightGrey, width: AppConstants.borderLightWidth)
                ),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                  child: StyleText(
                      text: '7/11',
                      color: AppColors.blackTextColor,
                      fontWeight: AppDim.weight500,
                      maxLinesCount: 1,
                      size: AppDim.fontSizeSmall,
                      align: TextAlign.start
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
              height: 90,
              child: BarChart().buildColumnSeriesMiniChart(chartData: chartData)),
        ],
      ),
    );
  }
}

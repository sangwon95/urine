
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/model/vo_chart.dart';
import 'package:urine/layers/presentation/widget/frame_container.dart';
import 'package:urine/layers/presentation/widget/line_chart.dart';
import 'package:urine/layers/presentation/widget/w_vertical_line.dart';

import '../../widget/style_text.dart';


/// 과거 7개의 검사 결과 추이
class ResultSummaryChart extends StatelessWidget {
  final List<ChartData> chartData;

  const ResultSummaryChart({
    super.key,
    required this.chartData,
  });

  String get guide1  => '✓ 가장 최근 7일간의 검사 결과를 보여줍니다.';
  String get guide2  => '✓ 좌측 부터 가장 최근 데이터 입니다. ';
  String get guide3  => '✓ 하루에 여러번 검사시 가장 최근 데이터 기준으로 표기됩니다.';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: 160,
            child: BarChart().buildColumnSeriesMiniChart(chartData: chartData)
        ),
        const Gap(AppDim.large),

        StyleText(
          text: guide1,
          size: AppDim.fontSizeSmall,
          color: AppColors.greyTextColor,
          fontWeight: AppDim.weight500,
        ),
        const Gap(AppDim.xSmall),

        StyleText(
          text: guide2,
          size: AppDim.fontSizeSmall,
          color: AppColors.greyTextColor,
          fontWeight: AppDim.weight500,
        ),
        const Gap(AppDim.xSmall),

        StyleText(
          text: guide3,
          size: AppDim.fontSizeSmall,
          color: AppColors.greyTextColor,
          fontWeight: AppDim.weight500,
          maxLinesCount: 2,
          softWrap: true,
        ),
      ],
    );
  }
}



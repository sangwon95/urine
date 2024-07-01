

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:urine/common/constant/app_dimensions.dart';
import 'package:urine/layers/presentation/trend/vm_analysis_trend.dart';
import 'package:urine/layers/presentation/trend/w_date_range_box.dart';
import 'package:urine/layers/presentation/trend/w_date_range_toggle_switch.dart';
import 'package:urine/layers/presentation/widget/scaffold/frame_scaffold.dart';

import '../widget/default_button.dart';
import 'w_horizontal_urine_chart.dart';
import 'w_learn_more_box.dart';
import 'w_urine_item_drop_button.dart';

/// 검사 내역 추이 화면
class AnalysisTrendView extends StatefulWidget {
  const AnalysisTrendView({super.key});

  @override
  State<AnalysisTrendView> createState() => _AnalysisTrendViewState();
}

class _AnalysisTrendViewState extends State<AnalysisTrendView> {

  String get title => '검사 내역 추이';
  String get searchText => '검색';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AnalysisTrendViewModel(),
      child: FrameScaffold(
        appBarTitle: title,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Consumer<AnalysisTrendViewModel>(
            builder: (context, provider, child) {
              return Column(
                children:
                [
                  const Gap(AppDim.large),

                  /// 검사 항목, 날짜 범위
                  Row(
                    children: [
                      UrineNameDropButton(
                        onChanged: (selected) => provider.selectedUrineName = selected ,
                        selectedUrineName: provider.selectedUrineName,
                      ),
                      const Gap(AppDim.small),

                      Expanded(
                          child: DateRangeBox(
                            onTap: () => provider.showDateRangeDialog(context),
                            dateText: '${provider.uiStartDate} ~ ${provider.uiEndDate}',
                          )
                      )
                    ],
                  ),

                  /// 날짜 간편 조회
                  DateRangeToggleSwitch(
                    toggleIndex: provider.toggleIndex,
                    onToggle: provider.onToggle,
                  ),
                  const Gap(AppDim.medium),

                  /// 검색 버튼
                  DefaultButton(
                    btnName: searchText,
                    buttonHeight: AppDim.xXLarge,
                    onPressed: () => provider.fetchUrineChartDio()
                  ),

                  /// 추이 차트
                  HorizontalUrineChart(
                    chartData: provider.chartData,
                    addWidthChartLength: provider.addWidthChartLength,
                  ),
                  const Gap(AppDim.large),

                  /// 더 알아보기
                  const LearnMoreBox(),
                  const Gap(AppDim.large),

                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

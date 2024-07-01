import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/presentation/analysis/result/vm_urine_result.dart';
import 'package:urine/layers/presentation/analysis/result/w_result_summary_chart.dart';
import 'package:urine/layers/presentation/analysis/result/w_urine_result_item.dart';
import 'package:urine/layers/presentation/widget/default_button.dart';
import 'package:urine/layers/presentation/widget/scaffold/frame_scaffold.dart';

/// 검사 결과 화면 (검사기와 검사후, 히스토리에서 터치 이벤트시)
class UrineResultView extends StatefulWidget {

  /// 검사 결과 리스트
  final List<String> urineList;

  const UrineResultView({
    super.key,
    required this.urineList,
  });

  @override
  State<UrineResultView> createState() => _UrineResultViewState();
}

class _UrineResultViewState extends State<UrineResultView> {
  String get title => '소변 검사';

  String get ingredientAnalysisText => '성분분석';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UrineResultViewModel(context),
      child: FrameScaffold(
        appBarTitle: title,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: AppConstants.viewPadding,
            child: Column(
              children: [

                Column(
                  children:
                  [
                    /// 7일간 추이 미니 차트
                    Consumer<UrineResultViewModel>(
                      builder: (context, provider, child) {
                        return ResultSummaryChart(chartData: provider.chartData);
                      },
                    ),
                    const Gap(AppDim.large),

                    /// 검사 결과 리스트
                    SizedBox(
                      height: 580,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 11,
                        itemBuilder: (BuildContext context, int index) {
                          return UrineResultListItem(
                              resultList: widget.urineList,
                              index: index,
                          );
                        },
                      ),
                    ),
                  ],
                ),


                /// 성분 분석 버튼
                const Gap(AppDim.xLarge),
                Consumer<UrineResultViewModel>(
                  builder: (context, provider, child) {
                    return  DefaultButton(
                      btnName: ingredientAnalysisText,
                      onPressed: () {
                        provider.fetchAiAnalyze(widget.urineList);
                      }, // 성분분석 결과 화면 이동
                    );
                  },
                ),
                const Gap(AppDim.xLarge),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

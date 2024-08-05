import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/model/authorization.dart';
import 'package:urine/layers/presentation/analysis/result/vm_urine_result.dart';
import 'package:urine/layers/presentation/analysis/result/w_result_summary_chart.dart';
import 'package:urine/layers/presentation/analysis/result/w_urine_result_item.dart';
import 'package:urine/layers/presentation/widget/default_button.dart';
import 'package:urine/layers/presentation/widget/scaffold/frame_scaffold.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';

import '../../../../common/util/text_format.dart';
import '../../widget/result_item_box.dart';

/// 검사 결과 화면 (검사기와 검사후, 히스토리에서 터치 이벤트시)
class UrineResultView extends StatefulWidget {

  /// 검사 결과 리스트
  final List<String> urineList;

  /// 검사 날짜
  final String testDate;

  const UrineResultView({
    super.key,
    required this.urineList,
    required this.testDate,
  });

  @override
  State<UrineResultView> createState() => _UrineResultViewState();
}

class _UrineResultViewState extends State<UrineResultView> {

  String get title => '소변 검사 결과';
  String get ingredientAnalysisText => '성분분석';
  String get intro  => '가정에서 정기적으로\n소변건강 상태를 체크하세요.';

  String get guide1  => '✓ 정기적인 검진을 통해 변화를 확인해보세요.';
  String get guide2  => '✓ 지속적으로 수치가 높으면 의료 검진 권장';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UrineResultViewModel(context),
      child: FrameScaffold(
        appBarTitle: title,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 24.07.27 검사 결과 요약 차트 비활성화
              // Consumer<UrineResultViewModel>(
              //   builder: (context, provider, child) {
              //     return ResultSummaryChart(chartData: provider.chartData);
              //   },
              // ),
              // const Gap(AppDim.large),

              const Gap(AppDim.small),
              StyleText(
                text: intro,
                color: AppColors.primaryColor,
                size: AppDim.fontSizeXxLarge,
                fontWeight: AppDim.weightBold,
                maxLinesCount: 2,
                height: 1.2,
              ),
              const Gap(AppDim.xSmall),

              /// 검사 결과 리스트
              SizedBox(
                height: 550,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 11,
                  itemBuilder: (BuildContext context, int index) {
                    return UrineResultListItem(
                      status: widget.urineList[index],
                      index: index,
                    );
                  },
                ),
              ),
              const Gap(AppDim.xXLarge),

              /// 신규 검사 결과 리스트 GridView 3x4
              // Consumer<UrineResultViewModel>(
              //   builder: (context, provider, child) {
              //     return GridView.builder(
              //       physics: const NeverScrollableScrollPhysics(),
              //       shrinkWrap: true,
              //       itemCount: 11,
              //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
              //         childAspectRatio: 1 / 0.95, //item 의 가로 1, 세로 1 의 비율
              //         mainAxisSpacing: 1, //수평 Padding
              //         crossAxisSpacing: 1, //수직 Padding
              //       ),
              //       itemBuilder: (BuildContext context,int index){
              //         // return Text(index.toString());
              //         return ResultItemBox(
              //                 index: index,
              //                 status: widget.urineList[index],
              //                 chartData: provider.chartData,
              //               );
              //       },
              //     );
              //   }
              // ),

              const Gap(AppDim.xSmall),

              StyleText(
                text: guide1,
                size: AppDim.fontSizeLarge,
                color: AppColors.blackTextColor,
                fontWeight: AppDim.weight500,
                softWrap: true,
                maxLinesCount: 2,
              ),
              const Gap(AppDim.xSmall),

              StyleText(
                text: guide2,
                size: AppDim.fontSizeLarge,
                color: AppColors.blackTextColor,
                fontWeight: AppDim.weight500,
                softWrap: true,
                maxLinesCount: 2,
              ),
              const Gap(AppDim.xSmall),




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
              const Gap(AppDim.xXLarge),

            ],
          ),
        ),
      ),
    );
  }
}

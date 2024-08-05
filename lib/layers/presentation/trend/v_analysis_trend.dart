
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:urine/common/constant/app_dimensions.dart';
import 'package:urine/layers/presentation/trend/vm_analysis_trend.dart';
import 'package:urine/layers/presentation/trend/w_date_range_box.dart';
import 'package:urine/layers/presentation/trend/w_date_range_toggle_switch.dart';
import 'package:urine/layers/presentation/widget/scaffold/frame_scaffold.dart';

import '../../../common/constant/app_colors.dart';
import '../widget/default_button.dart';
import '../widget/style_text.dart';
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
  String get intro => '✓ 추이 검색';
  String get searchText => '검색';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AnalysisTrendViewModel(),
      child: FrameScaffold(
        appBarTitle: title,
        backgroundColor: AppColors.greyBoxBg,
        bodyPadding: EdgeInsets.all(0),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: AppDim.paddingMedium,
                color:  AppColors.white,
                child: Consumer<AnalysisTrendViewModel>(
                  builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyleText(
                          text: intro,
                          size: AppDim.fontSizeXLarge,
                          color: AppColors.primaryColor,
                          fontWeight: AppDim.weightBold,
                        ),
                        const Gap(AppDim.medium),

                        /// 검사 항목, 날짜 범위
                        Row(
                          children: [
                            UrineNameDropButton(
                              onChanged: (selected) => provider.selectedUrineName = selected ,
                              selectedUrineName: provider.selectedUrineName,
                            ),

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
                          onPressed: () => provider.fetchUrineChartDio(context)
                        ),

                        /// 추이 차트
                        HorizontalUrineChart(
                          chartData: provider.chartData,
                          addWidthChartLength: provider.addWidthChartLength,
                        ),
                        const Gap(AppDim.medium),

                        StyleText(
                          text: 'Tip) 좌우로 이동 가능합니다',
                          color: AppColors.blackTextColor,
                          fontWeight: AppDim.weightBold,
                          align: TextAlign.start,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.red.withOpacity(0.3),
                          decorationThickness: 5,
                        ),

                        const Gap(AppDim.medium),
                      ],
                    );
                  },
                ),
              ),

              /// 더 알아보기
              // const LearnMoreBox(),
              // const Gap(AppDim.xXLarge),

            ],
          ),
        ),
      ),
    );
  }
}

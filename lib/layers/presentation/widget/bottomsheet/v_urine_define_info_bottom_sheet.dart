import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:urine/layers/presentation/widget/bottomsheet/vm_urine_define_info_bottom_sheet.dart';
import 'package:urine/layers/presentation/widget/w_future_handler.dart';

import '../../../../common/common.dart';
import '../../analysis/result/w_result_summary_chart.dart';
import '../style_text.dart';


class UrineDefineInfoBottomSheetView extends StatefulWidget {
  final String urineLabel;
  final int index;

  const UrineDefineInfoBottomSheetView({
    super.key,
    required this.urineLabel,
    required this.index,
  });

  @override
  State<UrineDefineInfoBottomSheetView> createState() => _UrineDefineInfoBottomSheetViewState();
}

class _UrineDefineInfoBottomSheetViewState extends State<UrineDefineInfoBottomSheetView> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UrineDefineInfoBottomSheetViewModel(widget.urineLabel),
        child: Container(
          height: 680,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDim.medium,
            vertical: AppDim.small,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: AppConstants.lightRadius,
                topRight: AppConstants.lightRadius),
          ),
          child:  Consumer<UrineDefineInfoBottomSheetViewModel>(
              builder: (context, provider, child) {
                return FutureHandler(
                    isLoading: provider.isLoading,
                    isError: provider.isError,
                    onRetry: () {},
                    errorMessage: provider.errorMessage,
                    child: Column(
                      children: [
                        _buildTopBar(),
                        _buildCancelButton(),
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  StyleText(
                                      text: provider.urineDesc?[widget.index]['title'] ?? '-',
                                      color: AppColors.blackTextColor,
                                      fontWeight: AppDim.weightBold,
                                      maxLinesCount: 2,
                                      size: AppDim.fontSizeXLarge,
                                      align: TextAlign.center),
                                ],
                              ),
                              const Gap(AppDim.xXLarge),
                              StyleText(
                                text: provider.urineDesc?[widget.index]['subTitle'] ??
                                    'Q. -',
                                color: AppColors.blackTextColor,
                                fontWeight: AppDim.weightBold,
                                maxLinesCount: 1,
                                size: AppDim.fontSizeXLarge,
                                align: TextAlign.start,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.yellow.withOpacity(0.4),
                                decorationThickness: 5,
                              ),
                              const Gap(AppDim.small),
                              StyleText(
                                  text: provider.urineDesc?[widget.index]['description'] ?? '-',
                                  color: AppColors.blackTextColor,
                                  height: 1.2,
                                  fontWeight: AppDim.weight500,
                                  maxLinesCount: 10,
                                  softWrap: true,
                                  align: TextAlign.start),
                              const Gap(AppDim.xXLarge),
                              StyleText(
                                text:
                                'Q. 나의 ${provider.urineDesc?[widget.index]['label'] ?? ''} 추이는?',
                                color: AppColors.blackTextColor,
                                fontWeight: AppDim.weightBold,
                                maxLinesCount: 1,
                                size: AppDim.fontSizeXLarge,
                                align: TextAlign.start,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.yellow.withOpacity(0.4),
                                decorationThickness: 5,
                              ),
                              const Gap(AppDim.small),
                              ResultSummaryChart(chartData: provider.chartData),
                            ],
                          ),
                        ),
                      ],
                    ),
                );
              })


        ),


    );
  }

  /// 상단 바 widget
  _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 3,
          margin: EdgeInsets.only(top: AppDim.xSmall),
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: AppConstants.borderLightRadius,
          ),
        )
      ],
    );
  }

  /// 취소 버튼
  _buildCancelButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(Icons.cancel, color: AppColors.grey, size: AppDim.iconSmall),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}


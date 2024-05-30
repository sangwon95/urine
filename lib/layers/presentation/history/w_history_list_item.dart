
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:urine/common/common.dart';
import 'package:urine/common/util/text_format.dart';
import 'package:urine/layers/presentation/history/vm_urine_history.dart';

import '../../entity/history_dto.dart';
import '../analysis/result/v_urine_result.dart';
import '../widget/style_text.dart';

class HistoryListItem extends StatelessWidget {

  final HistoryDataDTO history;

  const HistoryListItem({Key? key,
    required this.history,
  }) : super(key: key);

  String get negativeText => '음성';
  String get positiveText => '양성';

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<HistoryViewModel>(context, listen: false);

    return InkWell(
      /// 아이템 클릭 시 이벤트 처리
      onTap: () => viewModel.getUrineResultDio(history.datetime)
          .then((urineStatus)=>{
            if(urineStatus.isNotEmpty) {
              Nav.doPush(context, UrineResultView(urineList: urineStatus))
            } else {
              context.showSnackbar('데이터 손상이 있습니다. 다시 시도해주세요.')
            }
          }),
      child: SizedBox(
          height: 85,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    StyleText(
                        text: TextFormat.convertTimestamp(history.datetime),
                        color: AppColors.greyTextColor,
                        size: AppDim.fontSizeSmall,
                        fontWeight: FontWeight.w500,
                        maxLinesCount: 1,
                    ),

                    const Gap(AppDim.xSmall),
                    Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: AppDim.xSmall, horizontal: AppDim.medium),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.all(AppConstants.radius),
                                border: Border.all(color: AppColors.primaryColor),
                              ),
                              child: StyleText(
                                  text: negativeText,
                                  color: AppColors.primaryColor,
                              ),
                            ),
                            StyleText(
                                text: ' - ${history.negativeCnt}',
                                size: AppDim.fontSizeLarge,
                                fontWeight: AppDim.weight500,
                                color: AppColors.primaryColor,
                            ),
                          ],
                        ),

                        const Gap(AppDim.medium),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: AppDim.xSmall, horizontal: AppDim.medium),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.all(AppConstants.radius),
                                border: Border.all(color: AppColors.red),
                              ),
                              child: StyleText(
                                text: positiveText,
                                color: AppColors.red
                              ),
                            ),
                            StyleText(
                              text: ' - ${history.positiveCnt}',
                              size: AppDim.fontSizeLarge,
                              fontWeight: AppDim.weight500,
                              color: AppColors.red,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),

                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.greyTextColor,
                  size: AppDim.iconXSmall,
                ),
          ]
          )
      ),
    );
  }

}
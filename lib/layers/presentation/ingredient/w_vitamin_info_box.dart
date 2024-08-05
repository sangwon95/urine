

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:urine/layers/presentation/widget/result_item_box.dart';

import '../../../../../common/common.dart';
import '../widget/frame_container.dart';
import '../widget/style_text.dart';

class VitaminInfoBox extends StatelessWidget {
  final String status;

  const VitaminInfoBox({
    super.key,
    required this.status,
  });

  String get additionalText => '비타민C 과잉은 요당, 단백뇨, 알칼리뇨 등의 잘못된 측정이 유발되니 재검사를 권장합니다.';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDim.paddingLarge,
      color:  AppColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyleText(
            text: '✓ 비타민C 농도',
            size: AppDim.fontSizeXLarge,
            color: AppColors.primaryColor,
            fontWeight: AppDim.weightBold,
          ),
          const Gap(AppDim.medium),
          Row(
            children: [
              SizedBox(
                width: 130,
                child: ResultItemBox(
                  index: 10,
                  status: status,
                ),
              ),
              const Gap(AppDim.medium),
              Expanded(
                child: StyleText(
                  text: additionalText,
                  color: AppColors.blackTextColor,
                  maxLinesCount: 5,
                  softWrap: true,
                  size: AppDim.fontSizeLarge,
                ),
              ),
            ],
          )


        ],
      ),
    );
  }

}
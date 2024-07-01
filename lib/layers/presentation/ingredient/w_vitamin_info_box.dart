

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../common/common.dart';
import '../widget/frame_container.dart';
import '../widget/style_text.dart';

class VitaminInfoBox extends StatelessWidget {
  final String resultTitleText;
  final String additionalText;
  final String title;

  const VitaminInfoBox({
    super.key,
    required this.title,
    required this.resultTitleText,
    required this.additionalText,
  });

  @override
  Widget build(BuildContext context) {
    return FrameContainer(
      backgroundColor: AppColors.white,
      borderColor: AppColors.yellow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              StyleText(
                text: title,
                size: AppDim.fontSizeLarge,
                fontWeight: AppDim.weightBold,
              ),

            ],
          ),
          const Gap(AppDim.medium),

          Container(
            padding: AppDim.paddingSmall,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(AppConstants.lightRadius),
              color: AppColors.yellow,
            ),
            child: Center(
              child: StyleText(
                text: resultTitleText,
                color: Colors.white,
                softWrap: true,
                maxLinesCount: 7,
                fontWeight: AppDim.weightBold,
                size: AppDim.fontSizeLarge,
              ),
            ),
          ),
          const Gap(AppDim.medium),

          SizedBox(
            width: double.infinity,
            child: StyleText(
                text: '• $additionalText',
                maxLinesCount: 4,
                size: AppDim.fontSizeSmall,
                softWrap: true),
          ),
        ],
      ),
    );
  }

}
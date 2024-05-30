
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:urine/common/constant/app_colors.dart';
import 'package:urine/common/constant/app_dimensions.dart';
import 'package:urine/layers/presentation/widget/frame_container.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';

class ResultContentBox extends StatelessWidget {

  final String title;
  final String subTitle;
  final String content;

  const ResultContentBox({
    super.key,
    required this.title,
    required this.subTitle,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return FrameContainer(
      backgroundColor: AppColors.greyBoxBg,
      borderColor: AppColors.greyBoxBorder,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            StyleText(
              text: title,
              size: AppDim.fontSizeLarge,
              fontWeight: AppDim.weightBold,
            ),

            const Gap(AppDim.small),
            StyleText(
              text: subTitle,
              fontWeight: AppDim.weight500,
              maxLinesCount: 4,
              softWrap: true,
            ),

            const Gap(AppDim.small),
            StyleText(
              text: content,
              color: AppColors.blackTextColor,
              fontWeight: AppDim.weight500,
              maxLinesCount: 5,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}

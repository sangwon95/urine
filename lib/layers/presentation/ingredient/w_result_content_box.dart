
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:urine/common/constant/app_colors.dart';
import 'package:urine/common/constant/app_dimensions.dart';
import 'package:urine/layers/presentation/widget/frame_container.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';

class ResultContentBox extends StatelessWidget {
  final String title;
  final String content;

  const ResultContentBox({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDim.paddingLarge,
      color: AppColors.white,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            StyleText(
              text: title,
              color: AppColors.primaryColor,
              size: AppDim.fontSizeXLarge,
              fontWeight: AppDim.weightBold,
            ),
            const Gap(AppDim.small),

            StyleText(
              text: content,
              height: 1.5,
              size: AppDim.fontSizeLarge,
              color: AppColors.blackTextColor,
              fontWeight: AppDim.weight500,
              maxLinesCount: 50,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}

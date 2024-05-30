import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';

import '../../model/enum/urine_analysis_type.dart';
import '../widget/frame_container.dart';


/// 소변검사 메인화면의  검사진행, 검사내역, 검사추이 버튼
class AnalysisItemButton extends StatelessWidget {
  final VoidCallback onTap;
  final UrineAnalysisType type;

  const AnalysisItemButton({
    super.key,
    required this.onTap,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FrameContainer(
        backgroundColor: AppColors.primaryColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDim.small),
              child: Image.asset(
                type.image,
                height: AppDim.imageSmall,
                width: AppDim.imageSmall,
              ),
            ),

            const Gap(AppDim.small),
            StyleText(
              text: type.title,
              color: AppColors.whiteTextColor,
              fontWeight: AppDim.weightBold,
            )
          ],
        ),
      ),
    );
  }
}

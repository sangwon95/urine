

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:urine/common/common.dart';
import 'package:urine/common/constant/app_dimensions.dart';
import 'package:urine/layers/presentation/widget/frame_container.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';


/// 결과추이 - 더 알아보기
class LearnMoreBox extends StatelessWidget {
  const LearnMoreBox({super.key});

  String get title => '알아보기';
  String get content => '✓ 결과 내역 추이를 통해서 자신의 건강상태 추이를 확인할 수 있습니다.\n\n✓ 검사 항목은 총 11개 입니다.\n\n✓ 검색 기간을 수동, 1주, 1달, 6개월으로 간단하게 설정할 수 있습니다.\n\n✓ 사용 그래프는 좌우로 스크롤이 가능합니다';

  @override
  Widget build(BuildContext context) {
    return FrameContainer(
      margin: const EdgeInsets.all(AppDim.xSmall),
      backgroundColor: AppColors.greyBoxBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyleText(
            text: title,
            fontWeight: AppDim.weightBold,
          ),

          const Gap(AppDim.medium),
          StyleText(
            text: content,
            size: AppDim.fontSizeSmall,
            maxLinesCount: 7,
            softWrap: true,
          )
        ],
      ),
    );
  }
}

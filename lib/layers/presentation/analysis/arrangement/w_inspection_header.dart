import 'package:flutter/material.dart';
import 'package:urine/layers/model/authorization.dart';

import '../../../../../common/common.dart';
import '../../widget/style_text.dart';


class InspectionHeader extends StatelessWidget {
  const InspectionHeader({super.key});

  String get helloText => '안녕하세요. ${Authorization().name}님!';
  String get guideText => '검사기를 연결해주세요.';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleText(
          text: helloText,
          color: AppColors.primaryColor,
          size: AppDim.fontSizeXxLarge,
          fontWeight: AppDim.weightBold,
        ),
        StyleText(
          text: guideText,
          size: AppDim.fontSizeXLarge,
          fontWeight: AppDim.weightBold,
          maxLinesCount: 2,
        ),
      ],
    );
  }
}

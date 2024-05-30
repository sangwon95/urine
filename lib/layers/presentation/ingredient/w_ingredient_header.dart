import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:urine/common/common.dart';

import '../widget/style_text.dart';


class IngredientHeader extends StatelessWidget {
  final String disease;

  const IngredientHeader({
    super.key,
    required this.disease,
  });

  String get nameText => '심재기님 성분 분석';

  String get adjText1 => '=> 지난 소변검사에서 ';

  String get resultText => disease;

  String get adjText2 => '인자가 검출되었어요';

  String get emptyText => '=> 지난 소변검사에서 검출된 인자가 없습니다.';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// 헤더 텍스트
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyleText(
                text: nameText,
                size: AppDim.fontSizeXLarge,
                color: AppColors.primaryColor,
                fontWeight: AppDim.weightBold,
              ),
              const Gap(AppDim.xSmall),

              disease == ''
                  ? StyleText(
                      text: emptyText,
                      fontWeight: AppDim.weight500,
                      maxLinesCount: 2,
                      softWrap: true,
                    )
                  : Row(
                      children: [
                        StyleText(
                          text: adjText1,
                          fontWeight: AppDim.weight500,
                          size: AppDim.fontSizeSmall,
                          maxLinesCount: 2,
                          softWrap: true,
                        ),
                        StyleText(
                          text: resultText,
                          fontWeight: AppDim.weightBold,
                          color: AppColors.salmon,
                          maxLinesCount: 2,
                          softWrap: true,
                          decoration: TextDecoration.underline,
                        ),
                        StyleText(
                          text: adjText2,
                          fontWeight: AppDim.weight500,
                          size: AppDim.fontSizeSmall,
                          maxLinesCount: 2,
                          softWrap: true,
                        ),
                      ],
                    )
            ],
          ),
        ),
      ],
    );
  }
}

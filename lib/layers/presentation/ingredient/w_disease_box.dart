
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:urine/layers/presentation/ingredient/v_disease_info.dart';

import '../../../common/constant/app_colors.dart';
import '../../../common/constant/app_dimensions.dart';
import '../../../common/util/nav.dart';
import '../widget/default_button.dart';
import '../widget/style_text.dart';

class DiseaseBox extends StatelessWidget {
  const DiseaseBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDim.paddingLarge,
      color:  AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyleText(
            text: '✓ 성분별 질환',
            size: AppDim.fontSizeXLarge,
            color: AppColors.primaryColor,
            fontWeight: AppDim.weightBold,
          ),

          const Gap(AppDim.medium),
          Row(
            children: [
              Image.asset('assets/images/urine/disease.png', width: 70),
              const Gap(AppDim.medium),

              Expanded(
                child: Column(
                  children: [
                    DefaultButton(
                      btnName: '질환정보 보기   ->',
                      buttonHeight: 45,
                      onPressed: () => Nav.doPush(context, const DiseaseInfoView()),
                    ),
                    const Gap(AppDim.small),
                    StyleText(
                      text: '✓ 성분별 질환 정보를 확인하실 수 있습니다.',
                      maxLinesCount: 2,
                      softWrap: true,
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

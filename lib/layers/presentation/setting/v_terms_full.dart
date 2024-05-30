import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../common/constant/terms_content.dart';
import '../widget/scaffold/frame_scaffold.dart';
import '../widget/style_text.dart';

/// 전체 이용약관 화면
class TermsFullView extends StatelessWidget {
  TermsFullView({super.key});

  final termsText = TermsContent();

  String get title => '이용약관 및 정책';

  @override
  Widget build(BuildContext context) {
    return FrameScaffold(
      appBarTitle: title,
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDim.medium, vertical: AppDim.large),
              child: Container(
                  width:MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(border: Border.all(
                      width: AppConstants.borderLightWidth,
                      color: AppColors.primaryColor,
                  ),
                    borderRadius: AppConstants.borderLightRadius,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppDim.medium),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        /// 개인정보 수집 및 이용 동의
                        Padding(
                          padding: const EdgeInsets.all(AppDim.small),
                          child: StyleText(
                              text: termsText.privacyTitle,
                              size: AppDim.fontSizeLarge,
                              fontWeight: AppDim.weightBold,
                          ),
                        ),
                        StyleText(
                            text: termsText.privacyMainText,
                            softWrap: true,
                            maxLinesCount: 100,
                        ),
                        const Gap(AppDim.medium),

                        /// 민감정보 처리에 대한 동의
                        Padding(
                          padding: const EdgeInsets.all(AppDim.small),
                          child: StyleText(
                              text: termsText.sensitiveTitle,
                              size: AppDim.fontSizeLarge,
                              fontWeight: AppDim.weightBold,
                          ),
                        ),
                        StyleText(
                            text: termsText.sensitiveMainText,
                            softWrap: true,
                            maxLinesCount: 100,
                        ),
                        const Gap(AppDim.medium),

                        /// 연구과제 설명 및 참여 동의
                        Padding(
                          padding: const EdgeInsets.all(AppDim.small),
                          child: StyleText(
                            text: termsText.researchTitle,
                            size: AppDim.fontSizeLarge,
                            fontWeight: AppDim.weightBold,
                            softWrap: true,
                            maxLinesCount: 2,
                          ),
                        ),
                        StyleText(
                          text: termsText.researchMainText,
                          softWrap: true,
                          maxLinesCount: 200,
                        ),
                      ],
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

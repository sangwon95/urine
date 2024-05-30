
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';

import '../../../../common/constant/terms_content.dart';

/// 이용약관 다이얼로그
class TermsAlertDialog extends StatelessWidget {
  TermsAlertDialog({super.key});

  final termsText = TermsContent();

  String get title => '이용약관';
  String get checkText => '확인';
  double get contentHeight => 270;
  int get contentMaxLinesCount => 100;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AlertDialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
          borderRadius: AppConstants.borderRadius),
      content: SizedBox(
        height: 450,
        width: size.width * 0.9,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppDim.large),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StyleText(
                      text: title,
                      size: AppDim.fontSizeLarge,
                      fontWeight: AppDim.weightBold,
                      color: AppColors.primaryColor,
                    ),

                    // 오른쪽 상단 취소 버튼
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close,
                          color: Colors.black, size: AppDim.large),
                    ),
                  ],
                ),
              ),

              Container(
                height: contentHeight,
                margin: const EdgeInsets.symmetric(horizontal: AppDim.large),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(AppDim.xSmall)),
                  border: Border.all(color: AppColors.greyBoxBorder, width: AppConstants.borderLightWidth)
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(AppDim.medium),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        /// 개인정보 수집 및 이용 동의
                        Padding(
                          padding: const EdgeInsets.only(bottom: AppDim.medium),
                          child: StyleText(
                            text: termsText.privacyTitle,
                            size: AppDim.fontSizeLarge,
                            fontWeight: AppDim.weightBold,
                          ),
                        ),
                        StyleText(
                            text: termsText.privacyMainText,
                            size: AppDim.fontSizeSmall,
                            softWrap: true,
                            maxLinesCount: contentMaxLinesCount,
                        ),

                        /// 민감정보 처리에 대한 동의
                        Padding(
                          padding: const EdgeInsets.only(bottom: AppDim.medium),
                          child: StyleText(
                            text: termsText.sensitiveTitle,
                            size: AppDim.fontSizeLarge,
                            fontWeight: AppDim.weightBold,
                            softWrap: true,
                            maxLinesCount: 2,
                          ),
                        ),
                        StyleText(
                          text: termsText.sensitiveMainText,
                          size: AppDim.fontSizeSmall,
                          softWrap: true,
                          maxLinesCount: contentMaxLinesCount,
                        ),

                        /// 연구과제 설명 및 참여 동의
                        Padding(
                          padding: const EdgeInsets.only(bottom: AppDim.medium),
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
                          size: AppDim.fontSizeSmall,
                          softWrap: true,
                          maxLinesCount: contentMaxLinesCount,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(AppDim.large),
                child: TextButton(
                  onPressed: () => Nav.doPop(context),
                  style: TextButton.styleFrom(
                    minimumSize: const Size(double.infinity, AppConstants.buttonHeight),
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: AppConstants.borderLightRadius
                    ),
                  ),
                  child: StyleText(
                    text: checkText,
                    color: AppColors.whiteTextColor,
                    fontWeight: AppDim.weightBold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
      actionsAlignment: MainAxisAlignment.end,
      actionsPadding: const EdgeInsets.all(0),
    );
  }

}

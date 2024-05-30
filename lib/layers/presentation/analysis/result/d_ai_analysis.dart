
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/model/authorization.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';

/// Ai 분석 진행 다이얼로그
class AiAnalysisAlertDialog extends StatelessWidget {
  const AiAnalysisAlertDialog({super.key});

  String get title => '성분 분석';
  String get contentText => '${Authorization().name}님 데이터 분석중입니다.';
  String get checkUpText => '제공되는 데이터는 참고 용도로만사용되어야\n하며, 전문가와의 상담을 권장합니다.';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        return false; // 뒤로가기 방지
      },
      child: AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDim.large)),
        content: SizedBox(
          width: width * 0.7,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(AppDim.xXLarge),
                StyleText(
                  text: title,
                  size: AppDim.fontSizeLarge,
                  fontWeight: AppDim.weightBold,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: SpinKitFadingFour(
                      color: AppColors.primaryColor,
                      size: 70
                  ),
                ),
                StyleText(
                    text: contentText,
                    color: AppColors.primaryColor,
                    fontWeight: AppDim.weightBold,
                ),

                const Gap(AppDim.xLarge),
                StyleText(
                  text: checkUpText,
                  size: AppDim.fontSizeSmall,
                  color: AppColors.blackTextColor,
                  softWrap: true,
                  maxLinesCount: 3,
                  align: TextAlign.center,
                ),
                const Gap(AppDim.xLarge),

              ],
            ),
          ),
        ),
        contentPadding: const EdgeInsets.all(0),
        actionsAlignment: MainAxisAlignment.end,
        actionsPadding: const EdgeInsets.all(0),
      ),
    );
  }
}

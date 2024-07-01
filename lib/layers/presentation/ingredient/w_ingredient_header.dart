import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/model/authorization.dart';

import '../widget/style_text.dart';


class IngredientHeader extends StatelessWidget {
  final String disease;

  const IngredientHeader({
    super.key,
    required this.disease,
  });

  String get nameText => '${Authorization().name}님 성분 분석';

  String get adjText1 => '=> 지난 소변검사에서 ';

  String get resultText => '\"$disease\"';

  String get adjText2 => ' 과 관련될 수 있는 성분이 발견되었습니다.';
  String get adjText3 => ' 참고로만 생각해 주시기 바랍니다.';

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
                  : RichText(text: TextSpan(
                text: adjText1,
                style: _defaultTextStyle(),
                children: <TextSpan>[
                  TextSpan(
                    text: resultText,
                    style: _stateTextStyle(),
                  ),
                  TextSpan(text: adjText2),
                  TextSpan(text: adjText3),

                 // TextSpan(text: adjText2),
                ],
              ))
            ],
          ),
        ),
      ],
    );
    // }

  }

  TextStyle _defaultTextStyle() {
    return TextStyle(
      fontSize: AppDim.fontSizeMedium,
      fontWeight: AppDim.weightNormal,
      color: AppColors.blackTextColor,
      fontFamily: 'pretendard',
    );
  }

  TextStyle _stateTextStyle() {
    return TextStyle(
      fontSize: AppDim.fontSizeMedium,
      fontWeight: AppDim.weight500,
      color: AppColors.darkOrange,
      fontFamily: 'pretendard',
    );
  }

  TextStyle _boldTextStyle() {
    return TextStyle(
      fontSize: AppDim.fontSizeMedium,
      fontWeight: AppDim.weightBold,
      color: AppColors.blackTextColor,
      fontFamily: 'pretendard',
    );
  }
}


// import 'package:flutter/cupertino.dart';
// import 'package:gap/gap.dart';
//
// import '../../../common/constant/app_colors.dart';
// import '../../../common/constant/app_dimensions.dart';
// import '../../model/authorization.dart';
// import '../widget/style_text.dart';
//
// class IngredientHeader extends StatelessWidget {
//   final String disease;
//
//   const IngredientHeader({
//     super.key,
//     required this.disease,
//   });
//
//   String get nameText => '${Authorization().name}님 측정결과 분석';
//   String get adjText1 => '측정된 성분의 농도는 ';
//   String get stateText => '\"주의\"';
//   String get adjText2 => ' 수준이고 ';
//   String get resultText => '\"$disease\"';
//   String get adjText3 => ' 질환과 관련된 성분이오니 참고하시기바랍니다.';
//   String get emptyText => '=> 지난 소변검사에서 검출된 인자가 없습니다.';
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         StyleText(
//           text: nameText,
//           size: AppDim.fontSizeXLarge,
//           color: AppColors.primaryColor,
//           fontWeight: AppDim.weightBold,
//         ),
//         const Gap(AppDim.xSmall),
//         disease.isEmpty
//             ? StyleText(
//           text: emptyText,
//           fontWeight: AppDim.weight500,
//           maxLinesCount: 2,
//           softWrap: true,
//         )
//             : RichText(
//           text: _buildTextSpan(),
//         ),
//       ],
//     );
//   }
//
//   TextSpan _buildTextSpan() {
//     return TextSpan(
//       text: adjText1,
//       style: _defaultTextStyle(),
//       children: <TextSpan>[
//         TextSpan(
//           text: stateText,
//           style: _stateTextStyle(),
//         ),
//         TextSpan(text: adjText2),
//         TextSpan(
//           text: resultText,
//           style: _boldTextStyle(),
//         ),
//         TextSpan(text: adjText3),
//       ],
//     );
//   }
//
//   TextStyle _defaultTextStyle() {
//     return TextStyle(
//       fontSize: AppDim.fontSizeMedium,
//       fontWeight: AppDim.weightNormal,
//       color: AppColors.blackTextColor,
//       fontFamily: 'pretendard',
//     );
//   }
//
//   TextStyle _stateTextStyle() {
//     return TextStyle(
//       fontSize: AppDim.fontSizeMedium,
//       fontWeight: AppDim.weight500,
//       color: AppColors.red,
//       fontFamily: 'pretendard',
//     );
//   }
//
//   TextStyle _boldTextStyle() {
//     return TextStyle(
//       fontSize: AppDim.fontSizeMedium,
//       fontWeight: AppDim.weightBold,
//       color: AppColors.blackTextColor,
//       fontFamily: 'pretendard',
//     );
//   }
//
//
// }

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/model/authorization.dart';

import '../widget/bottomsheet/v_result_box_all_bottom_sheet.dart';
import '../widget/result_item_box.dart';
import '../widget/style_text.dart';

class IngredientHeader extends StatelessWidget {
  final String disease;
  final List<String> statusList;

  const IngredientHeader({
    super.key,
    required this.disease,
    required this.statusList,
  });

  String get nameText => '${Authorization().name}님,\n성분 분석 결과 입니다';
  String get adjText1 => '✓ 측정된 성분과 관련된 질환은 ';
  String get resultText => '\"$disease 등\"';
  String get adjText2 => ' 이 있으며 참고하시기 바랍니다.';


  String get emptyText => '측정 성분 분석 결과 ';
  String get emptyText2 => '\"소변건강양호\"';
  String get emptyText3 => '으로 측정되었으며, 주기적인 검사를 권장합니다.';


  String get adjText4 => '✓ 성분의 농도와 존재 여부를 통해 여러 질환 정보를 제공합니다.';
  String get adjText5 => ' [성분관련 질환 더보기]';


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDim.paddingLarge,
      color: AppColors.white,
      child: Row(
        children: [
          /// 헤더 텍스트
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyleText(
                  text: nameText,
                  size: AppDim.fontSizeXxLarge,
                  color: AppColors.primaryColor,
                  fontWeight: AppDim.weightBold,
                  maxLinesCount: 2,
                  height: 1.2,
                ),
                const Gap(AppDim.small),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        enableDrag: true,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return ResultBoxAllBottomSheet(
                            statusList: statusList,
                          );
                        });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      StyleText(
                        text: '더보기',
                        size: AppDim.fontSizeMedium,
                        fontWeight: AppDim.weightBold,
                      ),
                      Icon(Icons.add, size: AppDim.iconSmall),
                    ],
                  ),
                ),
                const Gap(AppDim.small),

                _buildMainPointReulstBoxs(),
                const Gap(AppDim.large),

                disease == ''
                    ? RichText(
                    text: TextSpan(
                      text: emptyText,
                      style: _defaultTextStyle(),
                      children: <TextSpan>[
                        TextSpan(
                          text: emptyText2,
                          style: _stateTextStyle(),
                        ),
                        TextSpan(text: emptyText3),

                        // TextSpan(text: adjText2),
                      ],
                    ))
                    : RichText(
                        text: TextSpan(
                        text: adjText1,
                        style: _defaultTextStyle(),
                        children: <TextSpan>[
                          TextSpan(
                            text: resultText,
                            style: _stateTextStyle(),
                          ),
                          TextSpan(text: adjText2),

                          // TextSpan(text: adjText2),
                        ],
                      )),
                const Gap(AppDim.small),


              ],
            ),
          ),
        ],
      ),
    );
    // }
  }

  Widget _buildMainPointReulstBoxs() {
    return SizedBox(
      height: 110,
      child: Row(
        children: [
          Expanded(
            child: ResultItemBox(
              index: 0,
              status: statusList[0],
            ),
          ),
          Expanded(
            child: ResultItemBox(
              index: 4,
              status: statusList[4],
            ),
          ),
          Expanded(
            child: ResultItemBox(
              index: 6,
              status: statusList[6],
            ),
          ),
        ],
      ),
    );
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
      fontSize: AppDim.fontSizeXxLarge,
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


import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';
import 'package:urine/common/util/branch.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';


class UrineResultListItem extends StatelessWidget {
  final int index;
  final List<String>? resultList;

  const UrineResultListItem({
    Key? key,
    required this.index,
    required this.resultList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: AppDim.small),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: AppColors.grey,
                    width: 0.3
                )
            )
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
            [
              /// 항목
              SizedBox(
                  width: 80,
                  child: Center(
                    child: StyleText(
                      text: AppConstants.urineNameList[index],
                      fontWeight: AppDim.weight500,
                      size: AppDim.fontSizeSmall,
                      color: AppColors.blackTextColor,
                    ),
                  )
              ),

              /// 결과 Image
              Image.asset(
                  Branch.resultStatusToImageStr(resultList!, index),
                  height: 90,
                  width: 170
              ),

              /// 결과 Text
              SizedBox(
                width: 45,
                child: StyleText(
                    text: Branch.resultStatusToText(resultList!, index),
                    fontWeight: AppDim.weight500,
                    color: Branch.resultStatusToColor(resultList!, index),
                    maxLinesCount: 1
                ),
              ),
            ]
        ));
  }



}
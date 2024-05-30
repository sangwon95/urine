
import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';

import '../widget/style_text.dart';


/// 입사일 TextBox Widget
class DateRangeBox extends StatelessWidget {
  final String dateText;
  final VoidCallback onTap;

  const DateRangeBox({
    super.key,
    required this.dateText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppConstants.dropButtonHeight,
        margin: AppDim.marginXSmall,
        padding: AppDim.paddingSmall,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(AppConstants.radius),
            border: Border.all(color: AppColors.brightGrey),
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: AppDim.small),
              child: StyleText(
                text: dateText,
                color: AppColors.blackTextColor,
                fontWeight: AppDim.weight500,
                size: AppDim.fontSizeSmall,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, size: AppDim.iconSmall)
          ],
        ),
      ),
    );
  }
}
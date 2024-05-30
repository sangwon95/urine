import 'package:flutter/material.dart';
import 'package:urine/common/constant/app_colors.dart';
import 'package:urine/common/constant/app_dimensions.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';

import '../../../../common/constant/app_constants.dart';


class BirthDateBox extends StatelessWidget {
  final String? birthDate;
  final VoidCallback onTap;

  const BirthDateBox({
    super.key,
    this.birthDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: AppConstants.signupTextFieldHeight,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: AppDim.large),
          decoration: BoxDecoration(
            color: AppColors.signupTextFieldBg,
            borderRadius: BorderRadius.all(AppConstants.radius),
          ),
          child: StyleText(
            text: birthDate ?? '생년월일을 입력해주세요.',
            size: AppDim.fontSizeSmall,
            color: birthDate == null
                ? AppColors.greyTextColor
                : AppColors.blackTextColor,
          )),
    );
  }
}
